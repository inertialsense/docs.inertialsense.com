# Inertial Sense Navigation Glossary

This glossary defines terminology used in inertial navigation, GNSS positioning, and Inertial Sense navigation systems.

---

# Navigation Systems

### IMU (Inertial Measurement Unit)

A sensor device containing:

* gyroscopes
* accelerometers

It measures **angular velocity** and **linear acceleration**, which are used to estimate motion and orientation.

---

### AHRS (Attitude and Heading Reference System)

A system that estimates **orientation** using IMU and magnetometer data.

Outputs typically include:

* roll
* pitch
* heading

---

### INS (Inertial Navigation System)

A navigation system that computes:

* position
* velocity
* orientation

by integrating IMU measurements over time.

---

### Strapdown INS

A modern INS architecture where the IMU is rigidly attached to the vehicle and navigation equations are solved in software.

This contrasts with older **gimbaled INS systems**.

---

### GNSS (Global Navigation Satellite System)

Satellite navigation systems providing global positioning and timing.

Examples include:

* GPS
* GLONASS
* Galileo
* BeiDou

---

### GNSS-INS Integration

Combining GNSS and inertial measurements to provide:

* robust positioning
* high-rate navigation
* improved reliability

---

### Dead Reckoning

Position estimation obtained by integrating velocity and heading over time without external measurements.

---

### Sensor Fusion

The process of combining measurements from multiple sensors to estimate system state more accurately.

---

# Navigation State Variables

### Position

Vehicle location expressed as:

* Latitude
* Longitude
* Altitude

This geodetic representation is often called **LLA**.

Position can also be expressed in Earth-fixed Cartesian (ECEF) coordinates:

```
p_ecef = [X, Y, Z]
```

or in local coordinates:

```
p = [North, East, Down]
```

---

### Velocity

Rate of change of position.

In the navigation frame:

```
v = [v_N, v_E, v_D]
```

Velocity can also be expressed in Earth-fixed Cartesian (ECEF) coordinates:

```
v_ecef = [v_X, v_Y, v_Z]
```

---

### Attitude

The orientation of a vehicle relative to a reference frame.

Representations include:

* Euler angles
* quaternions
* direction cosine matrices

---

# Coordinate Frames

### Body Frame

Coordinate frame fixed to the IMU.

Typical convention:

```
X → Forward
Y → Right
Z → Down
```

---

### Navigation Frame

A local Earth-referenced coordinate frame used for navigation.

Common choice:

**NED (North-East-Down)**

---

### NED Frame

Local tangent plane coordinate system:

```
X → North
Y → East
Z → Down
```

---

### ECEF Frame

Earth-Centered Earth-Fixed coordinate system.

Origin:

Earth's center of mass.

Coordinates are represented as:

```
[X, Y, Z]
```

in meters, fixed to Earth.

---

### LLA (Latitude, Longitude, Altitude)

Geodetic position representation on the Earth reference ellipsoid.

Common units:

* latitude/longitude in degrees
* altitude in meters

LLA is often used as an alternative to ECEF coordinates depending on the application.

---

### ECI Frame

Earth-Centered Inertial coordinate frame that does not rotate with Earth.

Used primarily in orbital mechanics.

---

### Sensor Frame

Coordinate frame defined by the axes of the IMU sensors.

---

### Vehicle Frame

Coordinate frame aligned with the vehicle body.

---

# Attitude Representations

### Euler Angles

Orientation defined by three sequential rotations:

```
Roll  (φ)
Pitch (θ)
Yaw   (ψ)
```

Limitations:

* gimbal lock near ±90° pitch

---

### Quaternion

A four-element representation of orientation:

```
q = [q_w, q_x, q_y, q_z]
```

Advantages:

* no singularities
* efficient for filtering

---

### Direction Cosine Matrix (DCM)

3×3 rotation matrix that converts vectors between coordinate frames.

Example:

```
C_bn
```

Transforms body frame vectors into navigation frame.

---

# Strapdown Navigation Equations

### Attitude Propagation

Orientation updated using gyro measurements:

```
q̇ = ½ Ω(ω) q
```

where

```
ω = angular rate vector
Ω = quaternion rate matrix
```

---

### Velocity Equation

Velocity evolves as:

```
v̇ = C_bn f_b + g_n - (2Ω_ie + Ω_en)v
```

where:

* `f_b` = specific force
* `g_n` = gravity vector
* `Ω_ie` = Earth rotation rate
* `Ω_en` = transport rate

---

### Position Equation

Position updated by integrating velocity:

```
ṗ = v
```

---

# IMU Measurement Terms

### Angular Rate

Rotation rate measured by gyroscopes.

Units:

```
deg/s
rad/s
```

---

### Specific Force

Acceleration measured by accelerometers excluding gravity.

---

### Linear Acceleration

True acceleration of the body.

---

### Magnetic Field

Earth magnetic field measured by magnetometers for heading estimation.

---

### Barometric Pressure

Atmospheric pressure measurement used for altitude estimation.

---

# Sensor Error Models

### Bias

Constant offset in sensor output.

```
measurement = truth + bias
```

---

### Bias Instability

Slow variation of sensor bias over time.

Often characterized using Allan variance.

---

### Angular Random Walk (ARW)

Gyroscope white noise causing attitude error growth.

Units:

```
° / √hr
```

Error growth:

```
σ_angle = ARW √t
```

---

### Velocity Random Walk (VRW)

Accelerometer white noise causing velocity error growth.

Units:

```
m/s / √hr
```

---

### Scale Factor Error

Error in sensor gain.

```
measurement = (1 + scale_factor_error) * truth
```

---

### Misalignment Error

Small angular errors between sensor axes and the reference coordinate frame.

---

### Cross-Axis Sensitivity

Sensor response to motion on another axis.

---

# Allan Variance Terms

### Allan Variance

A time-domain method used to analyze sensor noise processes.

---

### Allan Deviation

Square root of Allan variance.

Used to identify noise characteristics.

---

### Bias Instability (Allan)

Estimated from the minimum of the Allan deviation curve.

Conversion:

```
bias_instability = Allan_min / 0.664
```

---

### Rate Random Walk

Low-frequency gyro noise process.

---

### Quantization Noise

Noise introduced by digital resolution limits.

---

# GNSS Terminology

### Pseudorange

Measured distance between receiver and satellite based on signal travel time.

---

### Carrier Phase

High precision measurement of GNSS signal phase.

Used for centimeter-level positioning.

---

### RTK (Real-Time Kinematic)

Carrier-phase GNSS positioning using base station corrections.

Accuracy:

```
1–2 cm
```

---

### Base Station

Stationary GNSS receiver that provides correction data.

---

### Rover

GNSS receiver whose position is being estimated.

---

### Differential GNSS (DGNSS)

Positioning method using corrections from a reference station.

---

### Satellite Ephemeris

Precise orbital data describing satellite position.

---

### Dilution of Precision (DOP)

Measure of satellite geometry quality.

Types include:

* GDOP
* PDOP
* HDOP
* VDOP

---

# GNSS Measurement Models

### Pseudorange Equation

```
ρ = r + c(dt - dT) + I + T + ε
```

where:

* `r` = geometric range
* `dt` = receiver clock bias
* `dT` = satellite clock bias
* `I` = ionospheric delay
* `T` = tropospheric delay
* `ε` = measurement noise

---

### Carrier Phase Measurement

```
Φ = r + c(dt - dT) + λN + ε
```

where:

* `λ` = carrier wavelength
* `N` = integer ambiguity

---

# Kalman Filtering

### Kalman Filter

An optimal recursive estimator used to estimate system state.

---

### Extended Kalman Filter (EKF)

A nonlinear version of the Kalman filter commonly used in navigation.

---

### State Vector

Vector of estimated system variables.

Example INS state:

```
x = [position, velocity, attitude, biases]
```

---

### Process Model

Mathematical model predicting how system state evolves.

---

### Measurement Model

Relates sensor measurements to system state.

---

### Covariance Matrix

Represents uncertainty in the state estimate.

---

### Innovation

Difference between predicted and measured observation.

```
innovation = measurement − prediction
```

---

### Observability

Ability to estimate a state variable from available measurements.

---

# INS/GNSS Integration

### Loosely Coupled Integration

INS and GNSS are integrated at the **position/velocity level**.

---

### Tightly Coupled Integration

GNSS measurements integrated at the **pseudorange level**.

Allows operation with fewer satellites.

---

### Deep Coupling

GNSS tracking loops assisted directly by INS measurements.

---

### Lever Arm

Offset between IMU and GNSS antenna.

```
r_lever = position_GNSS − position_IMU
```

---

### Time Synchronization

Alignment of timestamps between sensors.

---

# Navigation Performance Metrics

### CEP (Circular Error Probable)

Radius containing 50% of position errors.

---

### RMS Error

Root-mean-square error of measurements.

---

### Drift Rate

Rate at which inertial navigation error grows without external aiding.

---

# Inertial Sense Protocol

### DID (Data Identifier)

Numeric identifier defining a data structure in the Inertial Sense binary protocol.

Examples include:

```
DID_INS_1
DID_IMU
DID_GPS
```

---

### Data Set

Binary structure containing navigation or configuration data.

---

### ISB (Inertial Sense Binary)

Binary communication protocol used by Inertial Sense devices.

---

### NMEA

ASCII protocol used for GNSS data output.

Example:

```
$GPGGA
```

---

# Software Tools

### SDK

Software development kit used to integrate Inertial Sense devices.

---

### EvalTool

Graphical interface used to visualize and configure devices.

---

### CLTool

Command-line tool used to communicate with devices.

---

# Hardware Products

### IMX

Inertial Sense navigation module containing:

* IMU
* magnetometer
* barometer
* navigation processor

---

### GPX

Multi-band GNSS receiver used with IMX modules.

---

### Rugged Systems

Industrialized versions of Inertial Sense modules.

---

# Common Abbreviations

| Acronym | Meaning                               |
| ------- | ------------------------------------- |
| IMU     | Inertial Measurement Unit             |
| INS     | Inertial Navigation System            |
| GNSS    | Global Navigation Satellite System    |
| AHRS    | Attitude and Heading Reference System |
| ARW     | Angular Random Walk                   |
| VRW     | Velocity Random Walk                  |
| RTK     | Real-Time Kinematic                   |
| EKF     | Extended Kalman Filter                |
| NED     | North-East-Down                       |
| ECEF    | Earth-Centered Earth-Fixed            |
| LLA     | Latitude, Longitude, Altitude         |

