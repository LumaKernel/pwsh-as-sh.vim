Windows の Vim でがんばてって PowerShell を使おうとする話．

プラグインではないです

## 結論

Vim 側で `set shell=pwsh` としたときのエスケープ処理などを細かく設定できるようにしてもらわないとキツそう

`shellescapefunc` みたいなオプションがほしい

### それらの原因

それらの原因は， `powershell.exe/pwsh.exe` が受け取った引数を，「unescapeできるならする」という仕様から来ている．うわぁ．

![image](https://user-images.githubusercontent.com/29811106/72830789-d13e5080-3cc4-11ea-9aad-7d27e33b1a7e.png)

おわかりいただけただろうか


## 一応それなりにうごくもの

`pwsh-as-sh.vim` と `powershell-invoker.bat` を同じディレクトリにおいて，`pwsh-as-sh.vim` を `source` すればそれなりに動く

`cmd` で ダブルクオーテーションとバックスラッシュを同時にエスケープするのはよくわからないので，環境変数経由で渡している


### できる

- `!(1+2) * 3` みたいな計算
- ダブルクオーテーションを含む処理
- 日本語を含む処理
- 構文エラーを含む処理 (正しくエラーが帰ってくることも大事だろう)


### できない・わかっている問題

- `!sort` みたいなフィルター処理
- '!' (エクスクラメーションマーク) が エスケープの関係で消える
- `-NoProfile` でも遅い
  - `pwsh` より `powershell` のほうが若干はやい


更に詳しくは `check.vim` なども見てほしい．  
`so%` しながらデバッグもできる


## License

[Unlicense](https://unlicense.org/)

