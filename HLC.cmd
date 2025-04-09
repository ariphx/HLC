@echo off
:: Cek apakah script dijalankan sebagai Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo   [!] Membutuhkan akses administrator. Mencoba restart sebagai Admin...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

color 0B
title HLC - Hop Limit Configurator

:logo
cls
echo.
echo        ___           ___       ___     
echo       /\__\         /\__\     /\  \    
echo      /:/  /        /:/  /    /::\  \   
echo     /:/__/        /:/  /    /:/\:\  \  
echo    /::\  \ ___   /:/  /    /:/  \:\  \ 
echo   /:/\:\  /\__\ /:/__/    /:/__/ \:\__\
echo   \/__\:\/:/  / \:\  \    \:\  \  \/__/
echo        \::/  /   \:\  \    \:\  \      
echo        /:/  /     \:\  \    \:\  \     
echo       /:/  /       \:\__\    \:\__\    
echo       \/__/         \/__/     \/__/    
echo.
echo   Hop Limit Configurator - @ariphx 
echo   ----------------------------
echo   [1] Set hop limit ke 65
echo   [2] Reset ke default (IPv4:128 / IPv6:64)
echo   [0] Keluar
echo.

set /p pilihan=   [1/2/0]:

if "%pilihan%"=="1" goto setHop
if "%pilihan%"=="2" goto resetHop
if "%pilihan%"=="0" exit
goto logo

:setHop
cls
echo.
echo   [INFO] Mengatur hop limit jadi 65...
netsh int ipv4 set glob defaultcurhoplimit=65 >nul 2>&1
netsh int ipv6 set glob defaultcurhoplimit=65 >nul 2>&1
echo.
echo   [INFO] Berhasil! Hop limit diubah ke 65.
echo.
pause
goto logo

:resetHop
cls
echo.
echo   [INFO] Mereset hop limit ke default...
netsh int ipv4 set glob defaultcurhoplimit=128 >nul 2>&1
netsh int ipv6 set glob defaultcurhoplimit=64 >nul 2>&1
echo.
echo   [INFO] Berhasil! Hop limit dikembalikan ke default.
echo.
pause
goto logo
