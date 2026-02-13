# IMU Shock Detection Configuration

## Overview

The IMU Shock Detection feature enables the system to detect and respond to mechanical shock events affecting the Inertial Measurement Units (IMUs). When a shock is detected, the Extended Kalman Filter (EKF) can be rewound to prevent shock-induced errors from corrupting the navigation estimates.

## Parameters

### Timing Parameters

#### `imuShockDetectLatencyMs`
- **Type:** `uint8_t`
- **Units:** milliseconds (ms)
- **Description:** Time duration used for EKF rewind to prevent shock from influencing EKF estimates. This value determines how far back in time the EKF is rewound when a shock is detected.
- **Typical Range:** 10-100 ms
- **Impact:** Larger values provide more protection but may introduce greater latency in shock response

#### `imuShockRejectLatchMs`
- **Type:** `uint8_t`
- **Units:** milliseconds (ms)
- **Description:** Time required following the detected end of a shock to disable shock rejection. This creates a "latch" period where shock rejection remains active even after shock values drop below thresholds, preventing premature deactivation.
- **Typical Range:** 100-500 ms
- **Impact:** Longer latch times ensure shock rejection persists until the system has fully stabilized

---

### Options

#### `imuShockOptions`
- **Type:** `uint8_t`
- **Description:** Bitfield that controls shock rejection behavior options. See `eImuShockOptions` for available flags.
- **Common Options:**
  - Enable/disable shock detection
  - Select shock detection algorithm variant
  - Configure EKF rewind behavior

---

### Acceleration Thresholds

#### `imuShockDeltaAccHighThreshold`
- **Type:** `uint8_t`
- **Units:** m/s²
- **Description:** Minimum acceleration difference between the 3 IMUs required to detect the **start** of a shock event. This is a high-threshold trigger that initiates shock detection.
- **Typical Range:** 2-10 m/s²
- **Impact:** Lower values increase sensitivity but may increase false positives; higher values may miss weak shocks

#### `imuShockDeltaAccLowThreshold`
- **Type:** `uint8_t`
- **Units:** m/s²
- **Description:** Maximum acceleration difference between the 3 IMUs (within the latch time) to detect the **end** of a shock event. When differences drop below this level, the shock is considered resolved.
- **Typical Range:** 0.5-5 m/s²
- **Impact:** Should be lower than the high threshold to create proper hysteresis; wider gap prevents oscillation between shock/no-shock states

---

### Gyroscope Thresholds

#### `imuShockDeltaGyroHighThreshold`
- **Type:** `uint8_t`
- **Units:** deg/s
- **Description:** Minimum angular rate difference between the 3 IMUs required to detect the **start** of a shock event. Complements acceleration-based detection for rotational shocks.
- **Typical Range:** 5-20 deg/s
- **Impact:** Lower values increase sensitivity to rotational shocks; higher values require more pronounced angular rates

#### `imuShockDeltaGyroLowThreshold`
- **Type:** `uint8_t`
- **Units:** deg/s
- **Description:** Maximum angular rate difference between the 3 IMUs (within the latch time) to detect the **end** of a shock event. Works in conjunction with acceleration thresholds.
- **Typical Range:** 1-10 deg/s
- **Impact:** Should be lower than the high threshold; wider gap prevents oscillation and ensures stable shock termination

---

## Usage Example

### Configuration for Vehicle Dynamics
```cpp
config.imuShockDetectLatencyMs = 50;           // 50ms EKF rewind window
config.imuShockRejectLatchMs = 200;            // 200ms latch time after shock end
config.imuShockOptions = 0x01;                 // Enable shock detection
config.imuShockDeltaAccHighThreshold = 5;      // 5 m/s² to trigger
config.imuShockDeltaAccLowThreshold = 2;       // 2 m/s² to confirm end
config.imuShockDeltaGyroHighThreshold = 10;    // 10 deg/s to trigger
config.imuShockDeltaGyroLowThreshold = 4;      // 4 deg/s to confirm end
```

---

## Tuning Guidelines

### For Sensitive Applications (e.g., precision navigation)
- Increase `imuShockDetectLatencyMs` to provide better protection
- Lower acceleration/gyroscope thresholds to catch subtle shocks
- Longer latch time to ensure full stabilization

### For Rugged Environments (e.g., off-road vehicles)
- Consider reducing thresholds further to detect frequent impacts
- Balance latch time against desired responsiveness
- Monitor EKF rewind performance in field testing

### For Minimal Interference
- Increase thresholds to only catch significant shocks
- Shorter latch times for faster recovery
- Reduce `imuShockDetectLatencyMs` if rewind latency is unacceptable

---

## Shock Detection Algorithm

The system detects shocks by monitoring **inter-IMU differences**:

1. **Shock Start:** When differences exceed either the acceleration OR gyroscope high thresholds
2. **Active Shock:** Shock rejection remains active for the duration of the shock event
3. **Shock End:** When ALL differences drop below their respective low thresholds AND the latch timer expires
4. **EKF Rewind:** The navigation state is rewound by `imuShockDetectLatencyMs` to remove shock-corrupted estimates

---

## Performance Considerations

- **Latency Impact:** EKF rewind introduces latency proportional to `imuShockDetectLatencyMs`
- **Computational Load:** Shock detection adds minimal overhead (difference calculations and comparisons)
- **IMU Health:** Requires all 3 IMUs to be operational for reliable shock detection


