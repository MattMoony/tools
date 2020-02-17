@echo off

echo Connecting ... 
adb kill-server
adb tcpip 5556

if "%1%"=="desktop" (
    echo [ENV]: Desktop ...
    adb connect 192.168.0.169:5556
) else (
    echo [ENV]: Notebook ...
    adb connect 192.168.43.1:5556
)

@echo on