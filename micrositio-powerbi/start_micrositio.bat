@echo off
title Iniciando Micrositio Power BI
echo -----------------------------
echo Iniciando backend...
cd backend
start cmd /k "node index.js"
cd ..

echo Iniciando frontend (Vite) en red local...
cd frontend
start cmd /k "npm run dev -- --host"
cd ..

echo Micrositio en marcha 🚀
pause
