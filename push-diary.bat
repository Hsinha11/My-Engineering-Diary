@echo off
REM Engineering Diary Push Script
REM This batch file makes it easy to push your diary entries to GitHub

echo 🚀 Engineering Diary Push Script
echo ================================

REM Run the PowerShell script
powershell -ExecutionPolicy Bypass -File "scripts\push-diary.ps1" %*

REM Pause to see the output
pause 