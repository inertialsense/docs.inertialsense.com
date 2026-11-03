# CBOR Messaging

CBOR messaging reads and writes device configuration by name and field, rather than as whole binary structures. A
message carries any selection of fields from any number of DIDs, the device reports the outcome of each DID, and a
device behind another (a GPX connected through an IMX) is reached by addressing it. Some parameters are reachable only
this way, such as the stored startup data streams (`RMC_STORED`) and the forwarding rules (`ROUTE_FILTER`).

Messages are [CBOR](https://www.rfc-editor.org/rfc/rfc8949) maps carried in one ISB DID, `DID_CBOR` (129). The DIDs
and fields available, with their keys, types and defaults, are listed in [CBOR Parameters](cbor-parameters.md).

The [SDK](#sdk-and-cltool) and [cltool](../software/cltool.md#cbor-messaging) build and parse these messages for you.
The rest of this page describes the messages themselves, for host software that sends them directly.

## Transport

- A message to a device is an ISB `PKT_TYPE_SET_DATA` (5) packet for `DID_CBOR` (129) with offset 0. Replies and
  other messages from a device arrive as `PKT_TYPE_DATA` (4) packets for the same DID. See [ISB](isb.md) for the
  packet framing.
- **The payload is one CBOR map and nothing else.** There is no binary header; the ISB payload size is the length of
  the CBOR map.
- A message and its reply each fit in one packet: up to 2040 bytes. An IMX-5 builds replies of up to 1280 bytes.

## Keys

Every map key is an unsigned integer below 65536. Names such as `FLASH_CFG` or `MSG_TYPE` are for reading; on the wire
each is its number. What a key means depends on its range:

| Range | At the root of a message | Inside a DID |
|---|---|---|
| `0xC000`–`0xEFFF` | message keys, `MSG_*` | the same keys (a DID's own `MSG_STATUS`, for example) |
| `0x9000`–`0xBFFF` | message-type options (`SUB_*`) | the same options, for that DID |
| `0x8000`–`0x8FFF` | | options specific to the DID |
| `0x0000`–`0x7FFF` | DIDs | fields of the DID |

- **DIDs** below `0x0100` are the binary ISB DIDs at their ISB numbers: `FLASH_CFG` is 12, `DID_FLASH_CONFIG`. Their
  fields carry the same values as the binary structure. DIDs at `0x0100` and above exist only in CBOR messages.
- **Field keys belong to their DID.** `ser0BaudRate` is key 2 in `FLASH_CFG` and key 0 in `GPX_FLASH_CFG`.
- **Message keys come first** in a message, before the DIDs, so a device that forwards a message can route it without
  reading the rest.
- **Unknown keys are ignored**, at any level. Compare what you sent with what the reply reports.

## Message keys

| Key | Name | Meaning | When absent |
|---|---|---|---|
| `0xC000` | `MSG_TYPE` | The operation (`DATA` 1, `GET` 2), plus `0x80` (`REPLY`) on a reply | A message with values is `DATA`; one with keys only is `GET` |
| `0xC001` | `MSG_SRC_DEV_ID` | [Unique ID](#addressing) of the sender | The sender is a host. Devices always send it |
| `0xC002` | `MSG_DST_DEV_FILTER` | [Device filter](#addressing) of the destination | The device at the other end of the link, not forwarded |
| `0xC003` | `MSG_REQ_ID` | A number chosen by the requester, echoed in every reply | No reply is matched to it |
| `0xC004` | `MSG_ACK_TYPE` | How much a reply to `DATA` reports: `ACK_NONE` 0, `ACK_MINIMAL` 1, `ACK_DETAILED` 2 | `ACK_MINIMAL` |
| `0xC006` | `MSG_TIME_GPS_NS` | Time of the message, ns since the GPS epoch (1980-01-06); sent once GNSS time is known | |
| `0xC007` | `MSG_UPTIME_NS` | Device uptime in ns; sent instead of `MSG_TIME_GPS_NS` until GNSS time is known | |
| `0xC008` | `MSG_STATUS` | The outcome of the message, or of one DID when inside it | `OK` |
| `0xC009` | `MSG_ERR_KEYS` | The fields a status refers to | |
| `0xC00A` | `MSG_FIELDS` | A field selection, in a DID's options map | Every field |

`MSG_ROUTE` (`0xC005`) is added by devices that forward a message; a host does not send it. The full list, with
types, is in [CBOR Parameters](cbor-parameters.md#message-keys).

## Reading: GET

A `GET` names DIDs and, for each, the fields wanted:

```
{ MSG_TYPE: GET, MSG_REQ_ID: 1, FLASH_CFG: [ser0BaudRate, insRotation] }
{ MSG_TYPE: GET, MSG_REQ_ID: 2, FLASH_CFG: [] }                          // [] = every field
```

The reply is the values, with `MSG_TYPE` `REPLY|GET` (`0x82`). On the wire, with an IMX-5 (SN62797):

```
request  a3                      map, 3 entries
           19 c0 00  02            MSG_TYPE: GET
           19 c0 03  19 03 ef      MSG_REQ_ID: 1007
           0c  82 02 04            FLASH_CFG: [ser0BaudRate (2), insRotation (4)]

reply    a5                      map, 5 entries
           19 c0 00  18 82         MSG_TYPE: REPLY|GET
           19 c0 01  1b 0d 40 00 00 00 00 f5 4d     MSG_SRC_DEV_ID: IMX-5.0 SN62797
           19 c0 03  19 03 ef      MSG_REQ_ID: 1007
           19 c0 06  1b 14 80 4e 99 8e 36 45 67     MSG_TIME_GPS_NS
           0c  a2                  FLASH_CFG: {
             02  1a 00 0e 10 00      ser0BaudRate: 921600
             04  83 f9 00 00 f9 00 00 f9 00 00   insRotation: [0.0, 0.0, 0.0] }
```

`MSG_TYPE` may be left out of a request that has keys only, so the smallest read is a single DID:
`a1 0c 81 02` (`{ FLASH_CFG: [ser0BaudRate] }`). Add `MSG_REQ_ID` to match the reply to it.

In a DID made of nested maps, a key path (an array of keys) selects one entry: `RMC_STORED: [[3, 13]]` reads port 3's
`GNSS1_POS` (13) entry. Field names with dots, such as `FLASH_CFG`'s `wheelConfig.radius`, are ordinary keys.

## Writing: DATA

A `DATA` message carries values. The device applies them on top of its current values: fields not in the message keep
their values, and the whole map is applied or rejected per DID.

```
{ MSG_TYPE: DATA, MSG_REQ_ID: 2, FLASH_CFG: { gnss2AntOffset: [0.0, 0.0, 0.5] } }
```

Configuration DIDs are stored in flash by the device after a write; a value written this way survives a reset. The
reply depends on `MSG_ACK_TYPE`:

| `MSG_ACK_TYPE` | Reply |
|---|---|
| `ACK_NONE` | None |
| `ACK_MINIMAL` (default) | Errors, and any value the device kept differently from what was sent. With nothing to report, the reply has only its message keys |
| `ACK_DETAILED` | Every value written, as the device kept it |

A detailed write to an IMX-5, rewriting `ser2BaudRate` (key 28):

```
request  a3  19 c0 03 19 3c c7   19 c0 04 02   0c a1 18 1c 1a 00 0e 10 00
             MSG_REQ_ID          MSG_ACK_TYPE:  FLASH_CFG: { ser2BaudRate: 921600 }
                                 ACK_DETAILED
reply    a5  19 c0 00 18 81   19 c0 01 1b 0d 40 00 00 00 00 f5 4d   19 c0 03 19 3c c7
             MSG_TYPE:         MSG_SRC_DEV_ID                        MSG_REQ_ID
             REPLY|DATA
             19 c0 06 1b 14 80 4e 9c f1 a3 79 6c   0c a1 18 1c 1a 00 0e 10 00
             MSG_TIME_GPS_NS                      FLASH_CFG: { ser2BaudRate: 921600 }
```

## Outcomes

Each DID in a message succeeds or fails on its own, and the reply reports it inside that DID. A DID that failed carries
`MSG_STATUS`, and `MSG_ERR_KEYS` when particular fields are at fault, and no values. A DID the device does not serve is
left out of its reply.

| `MSG_STATUS` | Value | Meaning |
|---|---|---|
| `OK` | 0 | Not sent: a DID without a status succeeded |
| `BAD_REQUEST` | 1 | The message, or the DID's part of it, is not well formed |
| `BAD_VALUE` | 2 | A value is invalid. With `MSG_ERR_KEYS`, those fields have the wrong type or are out of range; without, the device rejected the combination of values. Nothing in the DID is applied |
| `UNSUPPORTED` | 3 | The device serves the DID but not this operation (for example `SUBSCRIBE`) |
| `RESP_TOO_LARGE` | 4 | The value did not fit the reply; [ask for it separately](#large-replies) |
| `FORWARD_DENIED` | 5 | The forwarding device refused to pass the DID on (see [Addressing](#addressing)) |
| `READ_ONLY` | 6 | The DID cannot be written by the sender |
| `ERROR` | 7 | The device could not complete the operation |
| `REQ_TOO_LARGE` | 8 | The forwarding device could not fit the DID into the message it sends on; send it in a smaller message |
| `UNREACHABLE` | 9 | The message passed through too many forwarding devices to go further |

A status at the root of the reply, outside any DID, covers the whole message: `BAD_REQUEST` when the message is not one
well-formed map, and `UNSUPPORTED` for a `MSG_TYPE` the device does not handle.

A value of the wrong type, an IMX-5 asked to set `ser2BaudRate` to -1:

```
request  { MSG_TYPE: DATA, MSG_REQ_ID: 5, FLASH_CFG: { ser2BaudRate: -1, ser0BaudRate: 921600 } }
         a3 19 c0 00 01 19 c0 03 05 0c a2 18 1c 20 02 1a 00 0e 10 00
reply    { MSG_TYPE: REPLY|DATA, …, FLASH_CFG: { MSG_STATUS: BAD_VALUE, MSG_ERR_KEYS: [28] } }
         … 0c a2 19 c0 08 02 19 c0 09 81 18 1c
```

Neither value is applied. A GPX-1 that rejects a combination reports `BAD_VALUE` alone:

```
request  { MSG_TYPE: DATA, GPX_FLASH_CFG: { dynamicModel: 99, ser2BaudRate: 115200 } }
reply    { MSG_TYPE: REPLY|DATA, …, GPX_FLASH_CFG: { MSG_STATUS: BAD_VALUE } }
```

## Addressing

Every device has a 64-bit **unique ID**: its hardware type, version and serial number.

| Bits | Content |
|---|---|
| 63–58 | Hardware type: IMX = 3, GPX = 4 |
| 57–54 | Hardware major version |
| 53–48 | Hardware minor version |
| 47–0 | Serial number |

IMX-5.0 SN62797 is `0x0D40_0000_0000_F54D`; GPX-1.0 SN928401213 is `0x1040_0000_3756_473D`. A device sends its own in
`MSG_SRC_DEV_ID` on every message.

A **device filter** in `MSG_DST_DEV_FILTER` is a unique ID in which any part may be all ones, meaning any value. Each
part is compared on its own:

| Filter | Reaches |
|---|---|
| (absent) | The device at the other end of the link only |
| `0x1040_0000_3756_473D` | That GPX only |
| `0x13FF_FFFF_FFFF_FFFF` | Any GPX |
| `0x1040_FFFF_FFFF_FFFF` | Any GPX-1.0 |
| `0xFFFF_FFFF_FFFF_FFFF` | Every device that can be reached |

**A GPX behind an IMX.** An IMX forwards a message whose filter can match its GPX, and returns the GPX's reply. Its
`MSG_SRC_DEV_ID` says which device answered, and a filter that matches several devices draws a reply from each. A read
of the GPX's own configuration through its IMX, on the wire:

```
request  a4  19 c0 00 02   19 c0 02 1b 13 ff ff ff ff ff ff ff   19 c0 03 19 08 26   18 79 81 02
             GET           MSG_DST_DEV_FILTER: any GPX           MSG_REQ_ID          GPX_FLASH_CFG: [ser2BaudRate]
reply    { MSG_TYPE: REPLY|GET, MSG_SRC_DEV_ID: 0x1040_0000_3756_473D, MSG_DST_DEV_FILTER: 0, MSG_REQ_ID: 2086,
           MSG_UPTIME_NS: …, GPX_FLASH_CFG: { ser2BaudRate: 921600 } }
```

**The IMX owns its GPX's configuration.** It sets several `GPX_FLASH_CFG` values from its own `FLASH_CFG`, and pushes
them to the GPX.

- Write `GPX_FLASH_CFG` **to the IMX** (no filter). The IMX applies the change to its GPX, keeps its own values for the
  fields its `FLASH_CFG` controls, and reports those as adjusted.
- A `GPX_FLASH_CFG` write addressed **to the GPX** through the IMX is refused with `FORWARD_DENIED`. The IMX's forwarding
  rules are readable in [`ROUTE_FILTER`](cbor-parameters.md#route_filter).
- Reads addressed to the GPX are forwarded; the GPX answers them.

A GPX connected directly to the host is written like any other device.

## Values

| Field type | CBOR |
|---|---|
| `uint8`…`uint64`, `int8`…`int64` | Integer |
| `float32`, `float64` | Floating point |
| `bool` | `true` / `false` |
| `type[N]` | Array |

- **A value may use any encoding that represents it exactly:** any integer width that fits, half, single or double
  precision (or an integer) for a float, and 0 or 1 for a `bool`. Devices encode floats in the shortest exact form, as
  `f9 00 00` for 0.0 above.
- **A value that would change meaning is rejected** with `BAD_VALUE`, never clamped. That covers out of range, negative
  for an unsigned field, and a float for an integer field.
- **Arrays:** a shorter array updates only the elements given, and extra elements are ignored. Replies hold the whole
  array.
- CBOR tags, indefinite-length items, `null` and `undefined` are not accepted.

## Finding what a device serves

`CAPABILITIES` (`0x7FFC`) lists, for each DID a device serves, the field keys it serves. Its own entry lists the DIDs:

```
{ CAPABILITIES: [] }                   // every DID
{ CAPABILITIES: [GPX_FLASH_CFG] }      // one DID's fields
```

An IMX-5 with a GPX answers `CAPABILITIES: [12, 90, 32767, 32765, 121, 32764]`: `FLASH_CFG`, `CAN_CONFIG`,
`ROUTE_FILTER`, `RMC_STORED`, `GPX_FLASH_CFG` (its copy of its GPX's) and `CAPABILITIES`.

## Large replies

A reply carries everything that fits. What did not fit is marked `MSG_STATUS: RESP_TOO_LARGE` at the level where it was
left out, a whole DID or one field inside it; a value is never cut partway. Ask for the marked parts in a further
request. A whole `FLASH_CFG` fits one reply on every device.

## SDK and cltool

- **cltool:** `-cbor-get` and `-cbor-set` read and write in the same YAML form as `-get` and `-set`, `-cbor-dst`
  addresses a device, and `-cbor-out` prints every message in CBOR diagnostic notation. See
  [cltool: CBOR Messaging](../software/cltool.md#cbor-messaging).
- **SDK:** `ISDevice::cborRequest()` sends a request built with `CborRequest` and returns each device's `CborReply`;
  `cborRequestAsync()` does the same without blocking. `ISDevice::cborGetStruct()` reads a whole binary-backed DID into
  its C structure, asking again for any part marked `RESP_TOO_LARGE`. The registry headers in `src/cbor/` define each DID's
  and field's key (`CBOR_DID_FLASH_CFG`, `CBOR_FLASH_CFG__SER0BAUDRATE`), and `cbor_registry_did_key()` /
  `cbor_registry_field_key()` translate names to keys.
