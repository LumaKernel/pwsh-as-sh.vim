@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
  set _vim_command=%*

  powershell -NoProfile -NoLogo -Command "iex $env:_vim_command"

  REM TODO filter が動きそうで動かない
  REM powershell -NoProfile -NoLogo -Command "$script:in = @($Input); if( $script:in.Count ) { $script:in | iex $env:_vim_command } else { iex $env:_vim_command }"

  REM TODO そもそもこれで決め打ちフィルターしても動かない
  REM powershell -NoProfile -NoLogo -Command "@(1,2,3)"

  exit /b !errorlevel!
endlocal

