# Frequently Asked Questions

## What is Inertial Navigation?

Inertial navigation is a technique of estimating position, velocity, and orientation (roll, pitch, heading) by integrating IMU inertial motion data from gyros and accelerometers to continuously calculate the dead reckoning position.  The inertial sensors are supplemented with other sensors such as GPS, altimeter, and magnetometer.  Inertial navigation is commonly used on moving vehicles such as mobile robots, ships, aircraft, submarines, guided missiles, and spacecraft.   

## What does an Inertial Navigation System (INS) offer over GPS alone?

**Dead Reckoning** - An inertial navigation system (INS) integrates the IMU data to dead reckon (estimate position and velocity) between GPS updates and during GPS outage.   

**Higher Data Rates** - Typical GPS receivers data rates vary from 1Hz to 20Hz whereas INS systems like the IMX have data rates up to 1KHz.  

**Signal Conditioning** - An INS filters out noise in the GPS data and provides a smoother, more continuous data stream.  

**Orientation Data** - An INS is capable of observing the orientation (roll, pitch, and heading) of the system regardless of the motion or direction of travel.  This is because of how an INS fuses inertial data with GPS data.  A GPS with one antenna can measure direction of travel (ground track heading) but cannot estimate vehicle roll, pitch, or heading.

## How long can the IMX dead reckoning estimate position without GPS?

The IMX inertial navigation integrates the IMU data to dead reckoning position and velocity estimation between GPS updates and for a short period of time during GPS outages.  This dead reckoning is designed to filter out GPS noise and provide cleaner faster updates than are available via GPS alone. The IMX dead-reckons, or estimates position and velocity, between GPS updates and through brief GPS outages.  However, it is not designed for extended position navigation without GPS aiding.  Dead reckoning is disabled after 5 seconds of GPS outage in order to constrain position and velocity drift.  The amount of position drift during dead reckoning can vary based on several factors, including system runtime, motion experienced, and bias stability.  

## Can the IMX estimate position without GPS?

No.  GPS is required to provide initial position estimation and to aid in IMU bias estimation.  The IMX can dead reckon (estimate position without GPS) for brief periods of time.  However, the quality of dead reckoning is a function of IMU bias estimation, which improves while the GPS is aiding the INS.      

## How does vibration affect navigation accuracy? 

The IMX accuracy may degrade in the presence of mechanical vibrations that exceed 3g of acceleration. Empirical data shows degradation at approximately 100 - 150 Hz. Adding vibration isolation to the mount may be necessary to reduce the vibrations seen by the product and to improve accuracy.

## Can the IMX operate underwater?

The IMX can only dead reckon for short periods of time and in general requires GPS to provide position and velocity data.  The GPS antenna must be above the water surface in order for the GPS to function properly.  It is ideal that the GPS antenna be fixed relative to the IMX (IMU) module in order to maintain precision when moving faster than 2 m/s or 0.8 m/s^2.  However, the GPS antenna may be tethered above the IMX, where the GPS antenna is floating on the water surface and the IMX is below the water surface.  System position will reflect the GPS antenna position and attitude (roll, pitch, heading) will reflect the IMX module orientation. 

## Can the IMX operate at >4g acceleration?

Typical L1 GPS receivers lose fix above 4g acceleration because the doppler variation starts to get too large and the receiver may become unstable or not be able to get/keep a fix.  Additionally, the acceleration begins to affect the stability of the GPS XTAL oscillator.

On the IMX, the GPS will regain fix within seconds after acceleration drops below 4g. The IMX will track the velocity and position using inertial navigation for up to 5 seconds of GPS outage. As long as GPS outage is below 5 seconds, the IMX should be able to track position through a launch.

## Customer Support 

Have other questions or needs?  Please email us at [support@inertialsense.com](mailto:support@inertialsense.com).