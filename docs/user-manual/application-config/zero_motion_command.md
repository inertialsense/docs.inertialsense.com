# Zero Motion Command

The *Zero Motion Command* is user initiated and informs the EKF that the system is stationary on the ground.  It is used to aid in IMU bias estimation which can reduce drift in the INS attitude.  It works as a virtual velocity and angular rate sensor to provide velocity and angular rate observations when the INS is stationary (zero velocity and zero angular rate).  This is done for a period of two seconds after the *Zero Motion Command* is received.  The Zero Motion Command is beneficial for the following reasons:

- Overriding incorrect GPS motion caused by weak GPS signal.  
- Speeding up gyro biases convergence time when there is no GPS signal.   

In normal AHRS mode (stationary with or without GPS), only the IMU gyro biases are estimated by the EKF.  Setting `DID_FLASH_CONFIG.insDynModel = INS_DYN_MODEL_STATIONARY (2)` is equivalent to continually issuing the zero motion command.

To use the *Zero Motion Command*: 

1. Ensure the system is stationary on the ground.  
2. Send the *Zero Motion Command* either once or continuously while the system is stationary.  This can be done either by using the *Zero Motion* button in the EvalTool General Settings tab or by sending the [DID_SYS_CMD](../../com-protocol/DID-descriptions/#did_sys_cmd) binary message.  
3. After sending the *Zero Motion Command*, wait for the [INS_STATUS_DO_NOT_MOVE](../../com-protocol/DID-descriptions/#ins-status-flags) status bit to clear in [DID_INS_x.insStatus](../../com-protocol/DID-descriptions/#did_ins_1 ) before moving the system.  This flag takes about 2 seconds to clear following the last *Zero Motion Command*.

Applying this command more than one time can further improve the IMU bias estimation.

!!! warning
​    Issuing the *Zero Motion Command* while the system is moving can cause incorrect IMU bias estimates and lead to poor INS performance. It is important to make sure that the system is stationary when using the *Zero Motion Command*. 
