@echo off
REM Verifica si el puerto 5173 está en uso y mata el proceso que lo usa para liberar el puerto

for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":5173" ^| findstr LISTENING') do (
    echo Puerto 5173 ocupado por PID %%a
    echo Matando proceso %%a...
    taskkill /PID %%a /F
)

REM Ahora arranca el frontend con puerto fijo 5173
cd /d %~dp0frontend

npm run dev
pause
