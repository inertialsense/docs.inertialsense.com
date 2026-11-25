# CBOR Messaging

CBOR messaging reads and writes device configuration by name and field, rather than as whole binary structures. A
message carries any selection of fields from any number of domains, the device reports the outcome of each domain, and
a device behind another (a GPX connected through an IMX) is reached by addressing it. Some parameters are reachable
only this way, such as the stored startup data streams (`RMC_STORED`) and the forwarding rules (`ROUTE_FILTER`).

Messages are [CBOR](https://www.rfc-editor.org/rfc/rfc8949) maps carried in one ISB DID, `DID_CBOR` (129). The domains
and fields available, with their keys, types and defaults, are listed in [CBOR Parameters](cbor-parameters.md).

The [SDK](#sdk-and-cltool) and [cltool](../software/cltool.md#cbor-messaging) build and parse these messages for you.
The rest of this page describes the messages themselves, for host software that sends them directly.

## Domains and binary DIDs

A **domain** is a keyed map of related settings, such as `CONFIG_SYSTEM`, `CONFIG_INS` or `CONFIG_GNSS`: the unit a
CBOR message reads or writes. A binary DID such as `DID_FLASH_CONFIG` carries one fixed structure, and the settings in
it are spread over the domains they belong to. `DID_FLASH_CONFIG`'s fields are found in `CONFIG_SYSTEM`, `CONFIG_INS`,
`CONFIG_GNSS` and others, and `CONFIG_SYSTEM` draws on both `DID_FLASH_CONFIG` and, on a GPX, `DID_GPX_FLASH_CFG`.
[CBOR Parameters](cbor-parameters.md#domains) lists the binary DIDs mapped to each domain.

A domain's keys are the same on every device type. A device stores and accepts the keys it has a home for, and lists
them in [`CAPABILITIES`](#finding-what-a-device-serves).

## Transport

- A message to a device is an ISB `PKT_TYPE_SET_DATA` (5) packet for `DID_CBOR` (129) with offset 0. Replies and
  other messages from a device arrive as `PKT_TYPE_DATA` (4) packets for the same DID. See [ISB](isb.md) for the
  packet framing.
- **The payload is one CBOR map and nothing else.** There is no binary header; the ISB payload size is the length of
  the CBOR map.
- A message and its reply each fit in one packet: up to 2040 bytes. An IMX-5 builds replies of up to 1280 bytes.

## Keys

Every map key is an unsigned integer below 65536. Names such as `CONFIG_SYSTEM` or `MSG_TYPE` are for reading; on the
wire each is its number. What a key means depends on its range:

| Range | At the root of a message | Inside a domain |
|---|---|---|
| `0xC000`–`0xEFFF` | message keys, `MSG_*` | the same keys (a domain's own `MSG_STATUS`, for example) |
| `0x9000`–`0xBFFF` | message-type options (`SUB_*`) | the same options, for that domain |
| `0x8000`–`0x8FFF` | | options specific to the domain |
| `0x0000`–`0x7FFF` | domains | fields of the domain |

- **Domains** start at `0x0100`. A binary DID's number is not a domain: its fields are keys of the domains they map to.
  Inside `RMC_STORED`, which lists the data streams a port starts with, a key is a binary DID (`DID_INS_2`), because
  that is what it subscribes to.
- **Field keys belong to the map they sit in.** Key 0 is `navPeriodMs` at the top of `CONFIG_SYSTEM`, and `type` inside
  its `platform` map.
- **Message keys come first** in a message, before the domains, so a device that forwards a message can route it
  without reading the rest.
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
| `0xC008` | `MSG_STATUS` | The outcome of the message, or of one domain when inside it | `OK` |
| `0xC009` | `MSG_ERR_KEYS` | The fields a status refers to | |
| `0xC00A` | `MSG_FIELDS` | A field selection, in a domain's options map | Every field |

`MSG_ROUTE` (`0xC005`) is added by devices that forward a message; a host does not send it. The full list, with
types, is in [CBOR Parameters](cbor-parameters.md#message-keys).

## Reading: GET

A `GET` names domains and, for each, the fields wanted:

```
{ MSG_TYPE: GET, MSG_REQ_ID: 1, CONFIG_INS: [dynamicModel, rotation] }
{ MSG_TYPE: GET, MSG_REQ_ID: 2, CONFIG_INS: [] }                         // [] = every field
```

The reply is the values, with `MSG_TYPE` `REPLY|GET` (`0x82`). On the wire, with an IMX-6 (SN942741560):

```
request  a3                      map, 3 entries
           19 c0 00  02            MSG_TYPE: GET
           19 c0 03  01            MSG_REQ_ID: 1
           19 01 03  82 03 00      CONFIG_INS: [dynamicModel (3), rotation (0)]

reply    a5                      map, 5 entries
           19 c0 00  18 82         MSG_TYPE: REPLY|GET
           19 c0 01  1b 0d 80 00 00 38 31 18 38     MSG_SRC_DEV_ID: IMX-6.0 SN942741560
           19 c0 03  01            MSG_REQ_ID: 1
           19 c0 06  1b 14 88 de 3d d3 76 02 e7     MSG_TIME_GPS_NS
           19 01 03  a2            CONFIG_INS: {
             00  83 f9 00 00 f9 00 00 f9 00 00   rotation: [0.0, 0.0, 0.0],
             03  08                  dynamicModel: 8 }
```

`MSG_TYPE` may be left out of a request that has keys only, so the smallest read is a single domain:
`a1 19 01 02 81 00` (`{ CONFIG_SYSTEM: [navPeriodMs] }`). Add `MSG_REQ_ID` to match the reply to it.

A key path (an array of keys) selects one entry of a nested map: `CONFIG_PORTS: [[1, 2, 0]]` reads `Port`'s `SER2`
entry's `baudRate`, and `RMC_STORED: [[3, 13]]` reads port 3's `GNSS1_POS` (13) entry. In names, the same paths are
`{ CONFIG_PORTS: { Port: { SER2: { baudRate } } } }` and `{ RMC_STORED: { 3: { DID_GNSS1_POS } } }`.

## Writing: DATA

A `DATA` message carries values. The device applies them on top of its current values: fields not in the message keep
their values, and the whole map is applied or rejected per domain.

```
{ MSG_TYPE: DATA, MSG_REQ_ID: 2, CONFIG_INS: { offset: [0.0, 0.0, 0.5] } }
```

Configuration domains are stored in flash by the device after a write; a value written this way survives a reset. The
reply depends on `MSG_ACK_TYPE`:

| `MSG_ACK_TYPE` | Reply |
|---|---|
| `ACK_NONE` | None |
| `ACK_MINIMAL` (default) | Errors, and any value the device kept differently from what was sent. With nothing to report, the reply has only its message keys |
| `ACK_DETAILED` | Every value written, as the device kept it, with the map it sits in |

A detailed write to an IMX-6, setting serial port 2's baud rate (`CONFIG_PORTS` `Port` key 1, `SER2` key 2, `baudRate`
key 0):

```
request  a4  19 c0 00 01   19 c0 03 02   19 c0 04 02     19 01 06 a1 01 a1 02 a1 00 1a 00 0e 10 00
             DATA          MSG_REQ_ID    MSG_ACK_TYPE:   CONFIG_PORTS: { Port: { SER2: { baudRate: 921600 } } }
                                         ACK_DETAILED
reply    a5  19 c0 00 18 81   19 c0 01 1b 0d 80 00 00 38 31 18 38   19 c0 03 02
             MSG_TYPE:         MSG_SRC_DEV_ID                        MSG_REQ_ID
             REPLY|DATA
             19 c0 06 1b 14 88 de 3d e0 93 7b 4e
             MSG_TIME_GPS_NS
             19 01 06 a1 01 a3 00 a1 00 1a 00 0e 10 00 01 a1 00 1a 00 0e 10 00 02 a1 00 1a 00 0e 10 00
             CONFIG_PORTS: { Port: { SER0: { baudRate: 921600 }, SER1: { baudRate: 921600 },
                                     SER2: { baudRate: 921600 } } }
```

## Outcomes

Each domain in a message succeeds or fails on its own, and the reply reports it inside that domain. A domain that
failed carries `MSG_STATUS`, and `MSG_ERR_KEYS` when particular fields are at fault, and no values. A domain the device
does not serve is left out of its reply.

| `MSG_STATUS` | Value | Meaning |
|---|---|---|
| `OK` | 0 | Not sent: a domain without a status succeeded |
| `BAD_REQUEST` | 1 | The message, or the domain's part of it, is not well formed |
| `BAD_VALUE` | 2 | A value is invalid. With `MSG_ERR_KEYS`, those fields have the wrong type or are out of range; without, the device rejected the combination of values. Nothing in the domain is applied |
| `UNSUPPORTED` | 3 | The device serves the domain but not this operation (for example `SUBSCRIBE`) |
| `RESP_TOO_LARGE` | 4 | The value did not fit the reply; [ask for it separately](#large-replies) |
| `FORWARD_DENIED` | 5 | The forwarding device refused to pass the domain on (see [Addressing](#addressing)) |
| `READ_ONLY` | 6 | The domain cannot be written by the sender |
| `ERROR` | 7 | The device could not complete the operation |
| `REQ_TOO_LARGE` | 8 | The forwarding device could not fit the domain into the message it sends on; send it in a smaller message |
| `UNREACHABLE` | 9 | The message passed through too many forwarding devices to go further |

A status at the root of the reply, outside any domain, covers the whole message: `BAD_REQUEST` when the message is not
one well-formed map, and `UNSUPPORTED` for a `MSG_TYPE` the device does not handle.

A value of the wrong type, an IMX asked to set `dynamicModel` (key 3, a `uint8`) to -1:

```
request  { MSG_TYPE: DATA, MSG_REQ_ID: 5, CONFIG_INS: { dynamicModel: -1, lastPositionUpdateDistanceM: 0.5 } }
         a3 19 c0 00 01 19 c0 03 05 19 01 03 a2 03 20 06 f9 38 00
reply    { MSG_TYPE: REPLY|DATA, …, CONFIG_INS: { MSG_STATUS: BAD_VALUE, MSG_ERR_KEYS: [3] } }
         … 19 01 03 a2 19 c0 08 02 19 c0 09 81 03
```

Neither value is applied. A rejected combination is reported as `BAD_VALUE` alone. A GPX behind an IMX, asked for a
baud rate its port cannot run at:

```
request  { MSG_TYPE: DATA, MSG_DST_DEV_FILTER: any GPX, MSG_REQ_ID: 2,
           CONFIG_PORTS: { Port: { SER2: { baudRate: 1234 } } } }
reply    { MSG_TYPE: REPLY|DATA, MSG_SRC_DEV_ID: GPX-1.0 SN3001291994, …, CONFIG_PORTS: { MSG_STATUS: BAD_VALUE } }
```

## Addressing

Every device has a 64-bit **unique ID**: its hardware type, version and serial number.

| Bits | Content |
|---|---|
| 63–58 | Hardware type: IMX = 3, GPX = 4 |
| 57–54 | Hardware major version |
| 53–48 | Hardware minor version |
| 47–0 | Serial number |

IMX-6.0 SN942741560 is `0x0D80_0000_3831_1838`; GPX-1.0 SN3001291994 is `0x1040_0000_B2E4_14DA`. A device sends its own
in `MSG_SRC_DEV_ID` on every message.

A **device filter** in `MSG_DST_DEV_FILTER` is a unique ID in which any part may be all ones, meaning any value. Each
part is compared on its own:

| Filter | Reaches |
|---|---|
| (absent) | The device at the other end of the link only |
| `0x1040_0000_B2E4_14DA` | That GPX only |
| `0x13FF_FFFF_FFFF_FFFF` | Any GPX |
| `0x1040_FFFF_FFFF_FFFF` | Any GPX-1.0 |
| `0xFFFF_FFFF_FFFF_FFFF` | Every device that can be reached |

**A GPX behind an IMX.** An IMX forwards a message whose filter can match its GPX, and returns the GPX's reply. Its
`MSG_SRC_DEV_ID` says which device answered, and a filter that matches several devices draws a reply from each. A read
of the GPX's own configuration through its IMX, on the wire:

```
request  a4  19 c0 00 02   19 c0 02 1b 13 ff ff ff ff ff ff ff   19 c0 03 01   19 01 06 81 83 01 02 00
             GET           MSG_DST_DEV_FILTER: any GPX           MSG_REQ_ID    CONFIG_PORTS: [[Port, SER2, baudRate]]
reply    { MSG_TYPE: REPLY|GET, MSG_SRC_DEV_ID: 0x1040_0000_B2E4_14DA, MSG_DST_DEV_FILTER: 0, MSG_REQ_ID: 1,
           MSG_UPTIME_NS: …, CONFIG_PORTS: { Port: { SER2: { baudRate: 921600 } } } }
```

**The IMX owns its GPX's configuration.** It sets several of the GPX's values from its own configuration (antenna
offsets and the reference position, for example) and pushes them to the GPX.

- A write of a GPX domain (`CONFIG_SYSTEM`, `CONFIG_PORTS`, `CONFIG_GNSS`) addressed **to the GPX** through its IMX is
  not forwarded: the IMX applies it to the GPX itself, keeping its own values for the fields its configuration sets,
  and answers under the GPX's unique ID. Values it kept are reported as adjusted, as for any write.
- Reads addressed to the GPX are forwarded; the GPX answers them.
- The IMX's forwarding rules are readable in [`ROUTE_FILTER`](cbor-parameters.md#route_filter).

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
  for an unsigned field, a float for an integer field, and a value too large for the bits a setting has.
- **Arrays:** a shorter array updates only the elements given, and extra elements are ignored. Replies hold the whole
  array.
- CBOR tags, indefinite-length items, `null` and `undefined` are not accepted.

## Finding what a device serves

`CAPABILITIES` (`0x7FFC`) lists, for each domain a device serves, the top-level field keys it serves. Its own entry
lists the domains:

```
{ CAPABILITIES: [] }                   // every domain
{ CAPABILITIES: [CONFIG_GNSS] }        // one domain's fields
```

An IMX-6 answers `CAPABILITIES: [32767, 32765, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 32764]`:
`ROUTE_FILTER`, `RMC_STORED`, `CONFIG_SYSTEM` … `CONFIG_CAN`, `STATE` and `CAPABILITIES`. A GPX lists
`CONFIG_SYSTEM`, `CONFIG_PORTS` and `CONFIG_GNSS`, with fewer fields in each than an IMX.

## Large replies

A reply carries everything that fits. What did not fit is marked `MSG_STATUS: RESP_TOO_LARGE` at the level where it was
left out, a whole domain or one field inside it; a value is never cut partway. Ask for the marked parts in a further
request. Each configuration domain fits one reply on every device; `RMC_STORED` with many stored streams may not.

## SDK and cltool

- **cltool:** `-cbor-get` and `-cbor-set` read and write in the same YAML form as `-get` and `-set`, `-cbor-dst`
  addresses a device, and `-cbor-out` prints every message in CBOR diagnostic notation. See
  [cltool: CBOR Messaging](../software/cltool.md#cbor-messaging).
- **SDK:** `ISDevice::cborRequest()` sends a request built with `CborRequest` and returns each device's `CborReply`;
  `cborRequestAsync()` does the same without blocking. `ISDevice::cborGetStruct()` reads a whole domain into its view
  struct, asking again for any part marked `RESP_TOO_LARGE`. The headers in `src/cbor/domain/` define each domain's and
  field's key (`CBOR_DID_CONFIG_SYSTEM`, `CBOR_CONFIG_SYSTEM__NAVPERIODMS`) and view struct (`cbor_config_system_t`),
  and `cbor_registry_did_key()` / `cbor_registry_field_key()` translate names to keys. The headers in `src/cbor/did/`
  convert between a binary DID's struct and the domains it maps to, for example `cbor_flash_config_to_config_system()`.
