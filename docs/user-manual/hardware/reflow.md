# Reflow Soldering
</br>
</br>
</br>

## Use of "No Clean" soldering paste is recommended as it does not require cleaning after the soldering process. The following examples of paste meet these criteria.
</br>
</br>
<center>

| Solder                | Details                                                               |
| ----------------------| ---------------------------------------------                         |
|Soldering Paste        | OM338 SAC405 / Nr.143714 (Cookson Electronics)                        |
|Allow Specification    | Sn 95.5/ Ag 4/ Cu 0.5 (95.5% Tin/ 4% Silver/ 0.5% Copper)             |
|Melting temperatures   | 217 °C
</center>
</br>
</br>
</br>

## The following reflow profile is recommended for soldering:

<center>

![Reflow_plot](../images/Reflow.png)
</center>

</br>
</br>
<center>



| Phase     | Name                  | Recommended   | Details                                               |
| ------    |-----------------------|---------------|-------------------------------------------------------|
<b>Preheat  |                       |               |                                                       |
<b>         |dT/dt                  | 3°C/sec       | Preheat Temperature Rise Rate                         |
|           |T<sub>s</sub>MIN       | 150°C         | Preheat Minimum Temperature                           |  
|           |T<sub>s</sub>MAX       | 200°C         | Preheat Maximum Temperature                           |
|           |t<sub>s</sub>Preheat   | 60 - 120 sec  | Time Spent Between Preheat MIN and Max temperatures   | 
<b>Reflow   |                       |               |                                                       |
|           |T<sub>L</sub>          | 217°C         | Reflow Liquidus temperatures                          |
|           |T<sub>P</sub>          | 245°C         | Reflow Peak temperatures                              |
|           |t<sub>L</sub>          | 40-60 sec     | Time Spent above Reflow Liquidus temperatures         |
<b> Cooling |                       |               |                                                       |
|           |dT/dt                  | 4°C/sec| Maximum Cooling Temperature Fall Rate|



</center>
</br>
</br>
</br>

### Note:
- A convection soldering oven is highly recommended over an infrared type radiation oven as it allows precision control of the temperature and all parts will be heated evenly.
- To avoid falling off, the uINS should be placed on the topside of a PCB during soldering.
- The part must not be soldered with a damp heat process.
