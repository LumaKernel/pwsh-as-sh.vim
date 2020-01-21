@echo off
setlocal EnableDelayedExpansion
  set args=%*
  powershell -NoProfile -NoLogo -Command "$env:args"
endlocal
