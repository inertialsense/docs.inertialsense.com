# IMU Specifications

## IMU Noise Specification Conversion to Standard Deviation

The following calculations convert the noise specifications from the IMX-5 inertial measurement unit (IMU) datasheet into usable standard deviation values for simulating sensor noise at a sampling rate of 100 Hz. IMUs typically provide specifications for gyroscope and accelerometer noise in terms of "Angular Random Walk" (ARW) and "Velocity Random Walk" (VRW), expressed per \(\sqrt{\text{hours}}\). These values represent the rate at which random walk (drift) accumulates over time. To model this noise accurately in simulations, we need to translate the datasheet specifications into standard deviations that correspond to the chosen sampling rate (100 Hz, or 0.01 seconds per sample). This involves converting the ARW and VRW values from per \(\sqrt{\text{hour}}\) to per \(\sqrt{\text{second}}\) and then adjusting them based on the sampling interval, yielding noise characteristics that realistically represent the IMU's behavior in a simulated environment.

Given IMU specifications for the **IMX-5**:

- **Gyro Angular Random Walk (ARW)**: \(0.16 \, ^{\circ} / \sqrt{\text{hr}}\)
- **Accelerometer Velocity Random Walk (VRW)**: \(0.02 \, \text{m/s} / \sqrt{\text{hr}}\)
- **Sampling Rate**: 100 Hz (which corresponds to a time interval, \(\Delta t\), of \(0.01\) seconds)

### Time Conversion Factor

Since the random walk values are given per \(\sqrt{\text{hr}}\), we need to convert from hours to seconds. 1 hour is 3600 seconds, so:
\[
\text{1 hr} = 3600 \, \text{s} \Rightarrow \sqrt{\text{1 hr}} = \sqrt{3600} = 60 \, \text{s}^{1/2}
\]
To convert the noise specifications from per \(\sqrt{\text{hr}}\) to per \(\sqrt{\text{s}}\), divide by 60.

### 1. Gyroscope Noise (° and °/s)

Convert the **Gyro Angular Random Walk (ARW)** to per \(\sqrt{\text{s}}\):
\[
\text{ARW (per } \sqrt{\text{s}}) = \frac{0.16}{60} = 0.00267 \, \frac{^{\circ}}{\sqrt{\text{s}}}
\]

Now, to get the **angle drift** at a 100 Hz sampling rate, multiply by the square root of the time interval:
\[
\sigma_{\text{angle}} = 0.00267 \times \sqrt{0.01} = 0.00267 \times 0.1 = 0.000267 \, ^{\circ}
\]
So, the **angle drift standard deviation at 100 Hz** is approximately **0.000267 °**.

To get the **angular rate noise** at a 100 Hz sampling rate, divide ARW by the square root of the time interval:
\[
\sigma_{\text{gyro}} = \frac{0.00267}{\sqrt{0.01}} = 0.00267 \times 10 = 0.0267 \, ^{\circ}/\text{s}
\]

### 2. Accelerometer Noise (m/s and m/s²)

#### Velocity Drift Standard Deviation (m/s)

Convert **VRW** from per \(\sqrt{\text{hr}}\) to per \(\sqrt{\text{s}}\):
\[
\text{VRW (per } \sqrt{\text{s}}) = \frac{0.02}{60} = 0.000333 \, \frac{\text{m/s}}{\sqrt{\text{s}}}
\]

Now, multiply by the square root of the time interval to get the standard deviation at 100 Hz in terms of velocity:
\[
\sigma_{\text{velocity}} = 0.000333 \times \sqrt{0.01} = 0.000333 \times 0.1 = 0.0000333 \, \text{m/s}
\]
So, the **velocity drift standard deviation at 100 Hz** is approximately **0.0000333 m/s**.

#### Accelerometer Standard Deviation in Terms of Acceleration (m/s²)

To express the accelerometer noise as standard deviation in terms of acceleration, divide the VRW (converted per \(\sqrt{\text{s}}\)) by the square root of the time interval:
\[
\sigma_{\text{accel}} = \frac{0.000333}{\sqrt{0.01}} = 0.000333 \times 10 = 0.00333 \, \text{m/s}^2
\]
Thus, the **accelerometer noise standard deviation in terms of acceleration at 100 Hz** is approximately **0.00333 m/s²**.

---

### Summary of Results:
- **Angle Drift Standard Deviation at 100 Hz**: **0.000267 °** (denoted as \(\sigma_{\text{angle}}\))
- **Gyro Angular Rate Noise Standard Deviation at 100 Hz**: **0.0267 °/s** (denoted as \(\sigma_{\text{gyro}}\))
- **Velocity Drift Standard Deviation at 100 Hz**: **0.0000333 m/s**
- **Acceleration Noise Standard Deviation at 100 Hz**: **0.00333 m/s²**

These values represent the Gaussian noise standard deviations for each sensor at 100 Hz sampling rate.


<!-- 
% Assumed gyro model:
% b(i) = b(i-1) + v(i);
% x(i) = b(i) + n(i);
%
% Given the angle random walk (ARW) spec from Allan variance
% (noise density, usually in deg/sqrt(hr)), transform ARW to rad/sqrt(s) or
% any other desired units and simulate noise n at sampling intervals Ts as
% a white noise:
% n = ARW / sqrt(Ts) * randn();
%
% Given the rate random walk (RRW) spec from Allan variance (usually in
% deg/hr/sqrt(hr)), transform RRW to rad/s/sqrt(s) or any other desired
% units and simulate noise v in the gyro model above at sampling intervals
% Ts as a white noise:
% v = RRW * sqrt(Ts) * randn();
%
% NOTE 1: RRW is not typically mentioned in specifications but can be found
% from the Allan deviation plot. On the right side of the AD plot, find
% where the plot slope is +1/2 and fit a straight line at the same slope,
% the RRW value can be taken as a value on the straight line at correlation
% time tau=3 seconds. For Inertial Sense gyros, that value is approximately
% RRW = 0.001 deg/hr/sqrt(hr) = 2.9e-7 deg/s/sqrt(s)
%
% NOTE 2: Using just ARW and RRW in the gyro model will result in somewhat
% optimistic bias stability. Bias stability can not be modeled with a usual
% dynamic model (filter) due to the nature of the noise, but it can be
% approximated. To account for the actual sensor bias stability, the gyro
% bias model can be extended from pure random walk to use an additional
% first-order Markov process term. This introduces am aditional bias
% estimate and will increase state space dimension.
% b(i) = b(i-1) + v(i);
% bm(i) = (1 - Ts/Tb) * bm(i-1) + w(i);
% x1(i) = b(i) + bm(i) + n_arw(i);
% where Tb > 0 is the correlation time of the process. Tb can be selsected
% so that 1.89 Tb lies near the flat portion of the AD plot. Then, choose
% PSD so that the value of noise standard deviation at tau=1.89*Tb
% approximates the value of the AD plot in its flat region.
% Simulate noise w as a white noise:
% w(i) = BI / sqrt(Tb) / 0.4365  * sqrt(Ts)
%
% The two models should yield the same ARW and BI on Allan variance plot
% for different sampling times Ts.
% For additional details, see https://www.mathworks.com/help/nav/ug/inertial-sensor-noise-analysis-using-allan-variance.html
% For details on Note 2 see J. Farrell, F. Silva, F. Rahman, J. Wendel
% "IMU Error Modeling Tutorial: INS state estimation with real-time sensor
% calibration", IEEE Control Systems Magazine, vol. 42, no. 6, Dec. 2022. (edited)  
-->