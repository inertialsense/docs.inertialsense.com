# Plotting

## Log Inspector
[Log Inspector](../software/logInspector.md) is a convenient way to quickly plot Inertial Sense [PPD logs](data_logging.md#post-process-data-ppd-logging-instructions) that of of the .dat format. The source code is in the SDK and can be modified and expanded.

## CLTool

The CLTool can be used to load and replay `.dat` log files. The source code for the CLTool is located in the SDK and can be expanded by a user to analyze log data.

- `-rp PATH` replay data log from specified path
- `-rs=SPEED` replay data log at x SPEED

The following example replays data at 1x speed from the specified directory.
```C
cltool -rp IS_logs/20180801_222310
```

The following example will replay data as fast a possible in quiet mode (without printing to the screen).  This is useful to quickly reprocess the data.

```
cltool -rp IS_logs/20180801_222310 -rs=0 -q
```



## 3rd Party Software

The various file types described in the [overview](overview.md#data-log-types) section can be analyzed using various software packages. Matlab, Python, and Excel are popular choices and are well suited for Inertial Sense data logs.

<!-- ** THIS PARAGRAPH IS COMMENTED OUT UNTIL READY TO BE IMPLEMENTED AGAIN **

### Matlab (*.dat)

To plot using matlab, open “main.m” and push run. A user interface will open asking you to, “Select Folder that contains desired (.dat) log files to be read from.” Once you select the desired folder, the data will be read from the files and plotted. If you desire to change which data types are plotted, open “plotData.m” and change the struct “plotLog.[type]” to either a 1 or 0. “main.m” only needs to be run once, after which “plotData.m” can be run multiple times.

-->
