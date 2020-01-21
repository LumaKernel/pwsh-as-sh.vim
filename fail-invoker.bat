@echo off

REM バックスラッシュとダブルクオーテーションを同時に
REM うまくエスケープできません終了

chcp 65001 > nul 2>nul
setlocal EnableDelayedExpansion
  REM set "_command="
  REM powershell.exe -NoProfile -NoLogo "$env:_command"
  set _command=%*
  REM set _command=%_command:\\=\\\\%
  REM set _command=%_command:\"=\\"%
  REM set _command=%_command:"=\"%
  REM set _command=!_command:\=^^\!
  REM powershell -NoProfile -NoLogo "\"$env:_command     \""
  REM set _command=!_command:"=\"!
  REM powershell -NoProfile -NoLogo "\"$env:_command     \""
  REM call "%~dp0\echo-as-it.bat" %_command%
  REM set "_command=!_command:`=``!"
  REM powershell.exe -NoProfile -NoLogo "$env:_command"
  REM set "_command=!_command:"=`\"!"
  REM powershell.exe -NoProfile -NoLogo "$env:_command"
  REM set "_command=!_command:$=`$!"
  REM powershell.exe -NoProfile -NoLogo "$env:_command"
  REM set _command=\"!_command!\"
  REM powershell.exe -NoProfile -NoLogo "$env:_command"

  REM powershell.exe -NoProfile -NoLogo "&{Param($in, $a) if ($a -match '\((.*)\)') {$a = $Matches[1]} ; if( $in.Length ) { $a = \"`$in ^| \" + $a } ; iex $a }" "@($Input)" "!_command!" 2>&1
  set "_command="
endlocal
exit /b %errorlevel%

