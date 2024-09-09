# GNSS Satellite Constellations

The uINS supports onboard M8 and external (off-board) uBlox GNSS receivers.  These receivers use multiple GNSS constellations in the global positioning solution.  

The M8 receiver supports use of 3 concurrent constellations and the ZED-F9 receivers support 4 concurrent constellations (i.e. GPS, GLONASS, Galileo, and BeiDou).

The GPX-1 module supports 4concurrent constellations.

## Constellation Selection

The satellite constellations can be enabled or disabled by setting the corresponding enable bits in `DID_FLASH_CONFIG.gnssSatSigConst` as defined by [eGnssSatSigConst](../../com-protocol/DID-descriptions/#did_flash_configgnsssatsigconst) in data_sets.h.  The following are commonly used and recommended configuration groups. 

```c++
// 3 constellations is supported by uINS onboard M8 reciever.  
// (SBAS is not considered a constellation)
DID_FLASH_CONFIG.gnssSatSigConst = 0x133F	// GPS/QZSS, Galileo, GLONASS, SBAS
DID_FLASH_CONFIG.gnssSatSigConst = 0x10FF	// GPS/QZSS, Galileo, BeiDou, SBAS
DID_FLASH_CONFIG.gnssSatSigConst = 0x130F	// GPS/QZSS, GLONASS, SBAS

// 4 constellations is supported by ZED-F9 receiver and the GPX-1 (not uINS onboard M8 receiver).
DID_FLASH_CONFIG.gnssSatSigConst = 0x13FF	// GPS/QZSS, Galileo, GLONASS, BeiDou, SBAS
```


