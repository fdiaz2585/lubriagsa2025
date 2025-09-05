@echo off
title Micrositio Power BI - Inicio Backend y Frontend

echo ===============================
echo Iniciando Micrositio Power BI
echo ===============================

REM Liberar puerto 5173 si está ocupado
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":5173" ^| findstr LISTENING') do (
    echo Puerto 5173 ocupado por PID %%a
    echo Matando proceso %%a...
    taskkill /PID %%a /F
    echo Proceso %%a terminado.
)

echo.

REM Iniciar backend en nueva ventana
echo Iniciando Backend...
start cmd /k "cd /d %~dp0backend && npm run start"

REM Pequeña pausa para que no se solapen las ventanas
timeout /t 2 /nobreak >nul

REM Iniciar frontend en nueva ventana
echo Iniciando Frontend...
start cmd /k "cd /d %~dp0frontend && npm run dev"

echo.
echo Micrositio Power BI arrancado correctamente.
echo Revisa las ventanas de consola abiertas para Backend y Frontend.
echo Presiona cualquier tecla para cerrar esta ventana...
pause >nul
exit
