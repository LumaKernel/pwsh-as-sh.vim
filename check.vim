let s:shell_save = [&shell, &shellpipe, &shellslash, &shellredir, &shellquote, &shellxquote, &shellxescape, &shellcmdflag]
mes clear

let s:tests = [
      \   ['12+3', '15'],
      \   ['12 + 3', '15'],
      \   ['12+ 3', '15'],
      \   ['12 +3', '15'],
      \
      \   ['"12+3"', '12+3'],
      \   ['"12 +3"', '12 +3'],
      \   ['"12+ 3"', '12+ 3'],
      \   ['"12 + 3"', '12 + 3'],
      \
      \   ['echo (12 + 3)', '15'],
      \   ['echo "12 + 3"', '12 + 3'],
      \
      \   ['"abc" + "abc"', 'abcabc'],
      \
      \   ['"!%?><_\/"', '!%?><_\/'],
      \
      \   ['"`n"', "\n"],
      \   ['"\n"', '\n'],
      \   ['"`$"', '$'],
      \   ['$null', '', 1],
      \   ['"$null"', ''],
      \   ['"``"', '`'],
      \   ['"`""', '"'],
      \   ['"''"', "'"],
      \
      \   ['"\"', '\'],
      \   ['"\\"', '\\'],
      \   ['"\`"\"', '\"\'],
      \
      \   ['"a-b"', 'a-b'],
      \   ['"あ"', 'あ'],
      \   ['"漢字いけちゃう" + "感じ"', '漢字いけちゃう感じ'],
      \ ]

function! s:Test()
  for l:t in s:tests
    echom 'run : ' .. l:t[0]
    let l:res = system(l:t[0])
    let l:exp = l:t[1]

    if !get(l:t, 2)
      let l:exp = l:exp .. "\n"
    endif

    if l:res ==# l:exp
      echom 'Success'
    else
      echom 'res : ' .. l:res
      echom 'expected : ' .. l:exp
    endif

    echom ':'
  endfor
endfunction



try

  " 文字コードの問題を解決するために，実行前に `chcp 65001` を実行したい

  echom ":"
  echom '案1 : powershell'
  " ダメな理由 : ダブルクオーテーションが渡せない

  let &shell = "powershell"
  set shellcmdflag=
  " call s:Test()






  echom ":"
  echom '案2 : pwsh'
  " ダメな理由 : 1 と同じ

  let &shell = "powershell"
  set shellcmdflag=
  " call s:Test()







  echom ":"
  echom '案3 : invoker.ps1 みたいなのを経由する'
  " ダメな理由 :
  "   "12+3" みたいなのは渡せるが…
  "   ダブルクオーテーション単体などは渡せない
  "   そもそも 生 のまま invoker.ps1 に渡せない のを解消できていない
  "   エラーが起こる前に chcp をすることができない

  let &shell = "powershell " .. resolve(expand('<sfile>:h') .. "/powershell-invoker.ps1")
  set shellcmdflag=
  " call s:Test()





  echom ":"
  echom '案4 : cmd 経由で まず生のまま渡す'
  " コマンドは環境変数経由で渡す
  " これまでの中で一番マシ
  " 問題点 :
  "   - ! (エクスクラメーションマーク) が渡せない
  "     ( shellxescape に足してもだめ )
  "   - filter が使えない…
  "     単純に echo だけして置き換わるか見てみたけどダメだった，
  "     vim がどこから得たものを使っているかがわからない…


  " NOTE : パスに空白を含んではいけない
  "   neovim と vim でエスケープ処理の仕方とかも違うみたい
  let &shell = 'cmd /c ' .. resolve(expand('<sfile>:h') .. "/powershell-invoker.bat")
  set shellcmdflag=
  set shellquote=
  set shellxquote=(
  let &shellxescape='\"&|<>()@^'
  call s:Test()

finally
  let [&shell, &shellpipe, &shellslash, &shellredir, &shellquote, &shellxquote, &shellxescape, &shellcmdflag] = s:shell_save
endtry

