@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "& { . '%~dp0scripts\diary-helper.ps1'; Push-DiaryChanges }"
