let &shell = 'cmd /c ' .. resolve(expand('<sfile>:h') .. "/powershell-invoker.bat")
set shellcmdflag=
set shellquote=
set shellxquote=(
let &shellxescape='\"&|<>()@^'
