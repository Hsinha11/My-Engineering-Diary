@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\diary-helper.ps1" -Command "Update-DiaryStats"
