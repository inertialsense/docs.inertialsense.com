@echo off

cd ..

mkdocs build
"C:\Program Files (x86)\WinSCP\winscp.exe"

:: Sleep using ping for invalid ip and timeout
ping 123.45.67.89 -n 1 -w 5000 > nul
