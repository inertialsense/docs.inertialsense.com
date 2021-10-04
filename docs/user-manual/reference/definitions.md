# Definitions

## GPS Time To Fix

The time it takes for the GPS receiver to get “fix” or produce a navigation solution from the visible satellites is affected by the following GPS startup conditions:

- Cold start - In cold start mode, the receiver has no information from the last position (e.g. time, velocity, frequency etc.) at startup. Therefore, the receiver must search the full time and frequency space, and all possible satellite numbers. If a satellite signal is found, it is tracked to decode the ephemeris (18-36 seconds under strong signal conditions), whereas the other channels continue to search satellites. Once there are enough satellites with valid ephemeris, the receiver can calculate position and velocity data. Other GNSS receiver manufacturers call this startup mode Factory Startup.
- Warm start - In warm start mode, the receiver has approximate information for time, position, and coarse satellite position data (Almanac). In this mode, after power-up, the receiver normally needs to download ephemeris before it can calculate position and velocity data. As the ephemeris data usually is outdated after 4 hours, the receiver will typically start with a Warm start if it has been powered down for more than 4 hours.
- Hot start - In hot start mode, the receiver was powered down only for a short time (4 hours or less), so that its ephemeris is still valid. Since the receiver doesn't need to download ephemeris again, this is the fastest startup method.

Battery backed-up power supplied to the uINS preserves the GPS time, position, and coarse satellite position (almanac) while off.  GPS almanac data is typically valid for several weeks while the GPS is off.

## Preintegrated IMU

Also known as Coning and Sculling Integrals, Δ Theta Δ Velocity, or Integrated IMU.  For clarification, we will use the name "Preintegrated IMU" through the User Manual. They are integrated by the IMU at IMU update rates (1KHz). These integrals are reset each time they are output. Preintegrated IMU data acts as a form of compression, adding the benefit of higher integration rates for slower output data rates, preserving the IMU data without adding filter delay. It is most effective for systems that have higher dynamics and lower communications data rates.

## IMU Bias Repeatability (Turn-on to Turn-on Bias)

The initial bias will be different for each power up of the IMU due to signal processing initial conditions and physical properties.  A more repeatable bias allows for better tuning of INS parameters and faster estimate of the bias, whereas a more variable initial turn-on bias causes more difficult and longer INS convergence startup time.

## IMU Bias Stability (In-Run Bias)

Describes the amount of bias change during any one run-time following poweron.  This change is caused by temperature, time, and mechanical stress.  The INS navigation filter estimates the IMU biases in order to improve the state estimate.  The IMU bias stability directly impacts the accuracy of the INS output.   

## Random Walk

The IMU sensors measure a signal as well as noise or error, described as a stochastic process.  During IMU integration in the INS, sensor noise is accumulated and produces a random walk or drift on the final solution.  Random walk has a direct effect on the accuracy of the INS output.

## Sensor Orthogonality (Cross-Axis Alignment Error)

The three axis gyro and accelerometer sensors found in an IMU have measurement axes at 90 degrees from each other, maximizing the observability of the system.  In practice, these sensing axes in a three axis sensor are not perfectly at 90 degrees of each other, or misaligned slightly due to manufacturing imperfection.  This misalignment results in integration error in the INS and impacts accuracy.  To correct for cross-axis alignment error, the IMU is calibrated during manufacturing in a controlled motion environment. 

<!-- COMMENTED OUT UNTIL IT GETS CONTENT

## Dynamic Accuracy

-->