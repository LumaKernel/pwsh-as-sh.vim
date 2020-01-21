Windows の Vim でがんばてって PowerShell を使おうとする話

## 結論

Vim 側で `set shell=pwsh` としたときのエスケープ処理などを細かく設定できるようにしてもらわないとキツそう

`shellescapefunc` みたいなオプションがほしい

それらの原因は， `powershell.exe/pwsh.exe` が受け取った引数を，「unescapeできるならする」という仕様から来ている．うわぁ．


## 一応

`pwsh-as-sh.vim` と `powershell-invoker.bat` を同じディレクトリにおいて，`pwsh-as-sh.vim` を `source` すればそれなりに動く

### できる

- `!(1+2) * 3` みたいな計算
- 日本語


### できない

- `!sort` みたいなフィルター処理
- '!' (エクスクラメーションマーク) が エスケープの関係で消える

更に詳しくは `check.vim` なども見てほしい．
`so%` しながらデバッグもできる




## License

[Unlicense](https://unlicense.org/)

