# GNSS Jamming and Spoofing

This page describes how the GPX-1 handles GNSS radio frequency (RF) interference (jamming) and counterfeit GNSS signals (spoofing), what it reports, and what the host system should do with those reports.

The GPX-1 provides **interference mitigation and jamming/spoofing detection** suited to commercial and industrial use. It is not a controlled-reception-pattern-antenna (CRPA) or null-steering anti-jam system, and it does not authenticate signals (e.g. Galileo OSNMA). A strong enough jammer or spoofer can still deny or corrupt GNSS. The capabilities below reduce the effect of interference and let the host detect it and respond.

## Summary

| Capability | Where it runs | Behavior |
|---|---|---|
| In-band interference filtering | GNSS receiver (each of the two GPX-1 receivers) | Always on. Digital filters attenuate narrowband in-band interference. |
| Jamming detection | GNSS receiver | Always on. Reported in `status2` of the GNSS position DIDs. |
| Spoofing detection | GNSS receiver | Always on. Reported in `status2` of the GNSS position DIDs. |
| Spoofed satellite exclusion | GNSS receiver | Satellites the receiver detects as spoofed are excluded from that receiver's position solution. |
| Multi-constellation, multi-band tracking | GNSS receiver | GPS, Galileo, BeiDou, GLONASS, QZSS, and SBAS on L1/E1/B1 and L5/E5a/B2a bands. Interference or spoofing confined to one constellation or band is outvoted by the others. |
| Dual independent receivers | GPX-1 | GNSS1 and GNSS2 each produce their own solution and their own jam/spoof flags. |
| RTK measurement outlier rejection | GPX-1 onboard RTK engine | Code and carrier residual checks reject inconsistent satellite measurements from the RTK position and RTK compassing solutions. |
| INS outlier rejection and dead reckoning | IMX (when paired with GPX-1) | GNSS observations that disagree with the inertial estimate are de-weighted or rejected, and always rejected while a receiver reports jamming/spoofing. The INS continues to navigate through GNSS outages. |

## Interference Mitigation

### Receiver filtering

Each GNSS receiver on the GPX-1 continuously monitors its input signal. Digital filters that attenuate in-band interference are always active during positioning and need no configuration. These filters handle moderate narrowband interference. Strong or wideband interference in the GNSS bands will still reduce signal-to-noise ratio and can cause loss of tracking.

### Multi-band, multi-constellation

The GPX-1 tracks signals in two frequency bands (L1/E1/B1 and L5/E5a/B2a) across multiple constellations. Interference that affects only part of the spectrum, for example a single-band jammer or a harmonic from a nearby transmitter, leaves the satellites in other bands or constellations available. To get the most from this, keep all constellations and bands enabled:

```c++
DID_GPX_FLASH_CFG.gnssSatSigConst = 0x13FF   // GPS, QZSS, Galileo, BeiDou, GLONASS (L1 + L5 bands), SBAS
```

See [GNSS Constellations](gnss_constellations.md) and [Multi-band GNSS](multi_band_gnss_overview.md).

### Installation

Most real-world GNSS interference comes from equipment on the same platform: radio transmitters, cellular modems, DC-DC converters, displays, and cameras. Before relying on detection features:

- Mount the antennas away from transmitting antennas and noisy electronics, with a clear view of the sky.
- Use antennas with good out-of-band filtering. See [GNSS Antennas](gnss_antennas.md).
- Check `cnoMean` in `DID_GNSS1_POS` / `DID_GNSS2_POS` with the platform's own equipment powered on and off. A clear drop in average C/N0 when a device is switched on indicates platform interference.

## Jamming and Spoofing Detection

### What the receiver detects

Each GNSS receiver runs jamming and spoofing detection in the background whenever it is positioning. The receiver reports one of three levels for jamming and for spoofing:

- **None:** nothing detected, or a low level.
- **Possible:** interference or spoofing may be present.
- **Detected:** caution required. Jamming or spoofing is confirmed by the receiver.

When the receiver detects spoofing, it **excludes the spoofed satellites from its own position solution**. Spoofing that is limited to some satellites, such as one constellation, therefore normally leaves the receiver position correct as long as the genuine measurements outnumber the spoofed ones. If most measurements are spoofed, the receiver position may be wrong even while the spoofing flag is set.

### `status2` flags

The GPX-1 reports the detection state in the `status2` byte of the GNSS position DIDs, as defined by `eGnssStatus2` in data_sets.h:

| Bit | Value | Name | Meaning |
|---|---|---|---|
| 0 | `0x01` | `GNSS_STATUS2_FLAGS_GNSS_POSSIBLE_JAM_DETECT` | Possible RF jamming on the GNSS antenna |
| 1 | `0x02` | `GNSS_STATUS2_FLAGS_GNSS_JAM_DETECTED` | RF jamming detected (caution required) |
| 2 | `0x04` | `GNSS_STATUS2_FLAGS_GNSS_POSSIBLE_SPOOF_DETECT` | Possible GNSS spoofing |
| 3 | `0x08` | `GNSS_STATUS2_FLAGS_GNSS_SPOOF_DETECTED` | GNSS spoofing detected (caution required) |
| 4-7 | | | Unused |

Convenience masks:

| Mask | Value | Use |
|---|---|---|
| `GNSS_STATUS2_FLAGS_JAM_SPOOF_POSSIBLE_MASK` | `0x05` | Any "possible" bit |
| `GNSS_STATUS2_FLAGS_JAM_SPOOF_DETECTED_MASK` | `0x0A` | Any "detected" bit |
| `GNSS_STATUS2_FLAGS_JAM_SPOOF_MASK` | `0x0F` | All jam/spoof bits |

The flags are updated each time the receiver reports its detection state. Because the receiver does not always send a final "cleared" report when interference stops, the GPX-1 clears the flags if they have not been reported again for **10 seconds**. Expect the flags to remain set for up to 10 seconds after the event ends.

### Which DIDs to read

Each receiver reports its own flags:

| Receiver | DID | Notes |
|---|---|---|
| GNSS1 | `DID_GNSS1_POS` | GNSS1 receiver's flags. During an RTK position fix this DID contains the RTK solution, which carries the same GNSS1 receiver flags. |
| GNSS1 | `DID_GNSS1_RCVR_POS`, `DID_GNSS1_RTK_POS` | Same GNSS1 receiver flags. |
| GNSS2 | `DID_GNSS2_POS` | GNSS2 receiver's flags. |

Monitor both receivers. The two receivers share the same RF environment when their antennas are close together, so a real event usually appears on both. A flag on one receiver only can indicate an antenna, cable, or installation problem on that side.

The EvalTool shows "GNSS Jamming Detected" and "GNSS Spoof Detected" when either receiver reports a detected condition, and the SDK status decoders (`ISStatusDecode`) decode `status2` by name.

## RTK Position and RTK Compassing

The GPX-1 onboard RTK engine uses the receivers' raw code and carrier-phase measurements, not the receivers' position solutions. The receiver does not report which satellites it excluded as spoofed, so the RTK engine cannot drop exactly those satellites. Instead, it relies on its own checks:

- Code and carrier residual checks reject satellites whose measurements are inconsistent with the rest of the solution.
- C/N0 thresholds (`gnssCn0Minimum` and `gnssCn0DynMinOffset` in `DID_GPX_FLASH_CFG`) remove weak signals, which also removes many satellites degraded by interference.

Spoofing that affects only some satellites is usually caught by the residual checks. Coordinated spoofing of most of the satellites in view is not. When `status2` reports spoofing, treat RTK position and RTK heading as suspect, even if the RTK fix status still looks good.

## INS Behavior (GPX-1 with IMX)

When the GPX-1 provides GNSS to an IMX, the IMX INS adds a further layer:

- **Outlier rejection.** Each GNSS position and velocity observation is tested against the inertial prediction using normalized innovation squared (NIS). Observations that disagree with the INS are de-weighted, and large disagreements are rejected. A sudden position or velocity jump from a spoofer is therefore resisted.
- **Dead reckoning.** When GNSS is lost to jamming, the INS continues to navigate from the IMU (and any other aiding such as wheel encoders) and accuracy degrades with time. Monitor `StdPosNed`, `StdVelNed`, and `StdAttNed` in `DID_INL2_NED_SIGMA` for estimated uncertainty, and `insStatus` in the `DID_INS_*` messages for the solution state.

### Response to jam/spoof flags

The INS treats a receiver as suspect while its `status2` reports jamming detected, possible spoofing, or spoofing detected, and for 5 seconds after the flags clear. This is in addition to the GPX-1's 10-second hold. For a suspect receiver, the INS:

- **Rejects outliers instead of de-weighting them.** A position or velocity observation that exceeds the nominal NIS threshold is discarded. This also applies during RTK position and RTK compassing operation, where outliers are otherwise only de-weighted.
- **Does not realign heading from GNSS.** When heading comes only from GNSS motion, a large disagreement between GNSS and the INS would normally start a heading realignment that accepts all GNSS observations. That realignment is not started while any receiver is suspect.
- **Does not relax its outlier gates after a GNSS outage.**

Observations from a suspect receiver that agree with the INS are still used. Because the receiver excludes satellites it identifies as spoofed, its solution is often still correct.

### Remaining limitations

- **Persistent flags.** If the flags stay set and the INS drifts beyond the outlier gate, GNSS stays rejected and the INS dead-reckons. After 30 seconds of unaided dead reckoning the INS falls back to AHRS mode and later re-initializes its position from GNSS, accepting whatever position GNSS reports at that time.
- **Slow drift.** A spoofer that moves the position gradually, within the INS's expected error, is not detected by NIS checks.
- **Undetected spoofing.** If the receiver does not flag the spoofing, the INS falls back to its normal outlier handling.

## Recommended Host Response

1. Read `status2` from `DID_GNSS1_POS` and `DID_GNSS2_POS` at the GNSS rate.
2. On a **possible** flag, log the event and increase monitoring. Short "possible" events can occur in normal interference environments.
3. On a **detected** flag:
    - Treat GNSS position, velocity, time, and RTK outputs as untrusted for the duration of the flag plus the 10-second hold.
    - If the GPX-1 feeds an IMX, the INS already rejects disagreeing GNSS (see [Response to jam/spoof flags](#response-to-jamspoof-flags)). For a stricter policy, stop GNSS fusion entirely with `SYS_CFG_BITS_DISABLE_GNSS1_FUSION` / `SYS_CFG_BITS_DISABLE_GNSS2_FUSION` in `DID_FLASH_CONFIG.sysCfgBits` so that the INS dead-reckons. Re-enable it after the flags have cleared and GNSS agrees with the INS.
    - Alert the operator.
4. Cross-check GNSS1 against GNSS2, and GNSS against the INS. Disagreement between independent sources is a useful indicator even when the flags are clear.
5. Keep all constellations and both bands enabled.

## Limitations

- Detection and filtering are performed inside the GNSS receivers. Detection thresholds and algorithms are not configurable.
- The list of satellites the receiver excludes as spoofed is not available to the host or to the onboard RTK engine.
- There is no antenna-array (CRPA) nulling, direction-of-arrival detection, or signal authentication.
- Jamming strong enough to block all bands causes loss of GNSS; the INS then dead-reckons.
- Spoofing of most or all visible satellites can produce a wrong receiver position and wrong RTK solution while the spoofing flag is set.
