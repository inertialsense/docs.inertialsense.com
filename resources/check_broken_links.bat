@echo off

echo.
echo You must hard reflesh docs.inertialsense.com in your browser to update cache!!!
echo - Use CTRL + F5 in Chrome. 
echo.
start chrome https://www.deadlinkchecker.com/

:: Sleep using ping for invalid ip and timeout
ping 123.45.67.89 -n 1 -w 5000 > nul
