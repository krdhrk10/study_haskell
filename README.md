# study_haskell
Study of Haskell

## 1. GHC

### 1.1. ghc command

以下のコマンドでhello.hsをコンパイルし、実行ファイル「hello」を生成する
```
$ ghc hello.hs -o hello
```

### 1.2. runghc command

GHC6.4行こうで添付されるコマンド。
自動で実行ファイルがコンパイルされ、実行される。
```
$ runghc hello.hs
```

### 1.3. ghci command

対話型インタプリタを起動する。
下記のように:から始まるコマンド入力によって各種コマンドを実行できる
```
Prelude> :?
```

なお、終了は以下
```
Prelude> :q
```

## 2. Basic

### 2.1. mainアクション

下記のように、キーワード「main」に関数をバインドすることで、エントリポイントを定義することができる。
```
main = putStrLn "Hello, Haskell"
```

### 2.2. レイアウト

下記のように、doから始まる式とインデントを揃えた複数の式によって、blockを表現することができる。
```
main = do cs <- getContents
	      putStr cs
```
この規則を「レイアウト」とか「オフサイドルール」という

### 2.3. getContentsと「<-」

getContentsは評価されると標準入力を全て読み込むアクションである。
アクションはその結果を参照する際、「<-」で他の変数にバインドする。
これはいわゆる返値とは異なるため、次のように記述することはできない
```
# これはNG
main = putStr getContents
```

なお、「<-」による束縛は一定の条件下でのみ可能であり、いつでもどこでも記述できるわけではない。

### 2.4. 「$」演算子

演算子を区切るために「$」を使用することができる。
たとえば、下記の例では lines cs の評価結果を length の引数に使用し、その評価結果をさらに print の引数として使用する。
```
main = do cs <- getContents
	      print $ length $ lines cs
```
つまり、一般的なプログラミング言語における（）に相当する
```
print(length(lines(cs)))
```

この$がなければ、プログラムは以下を区別することができなくなる。
```
print(length, lines, cs)
print(length, lines(cs))
print(length(lines), cs)
print(length(lines, cs))
print(length(lines(cs)))
```

### 2.5. length, lines, print関数

- length
  リストの長さ、文字列の長さを返却する
- lines
  改行文字で文字列を分割し、文字列リストを返却する
- print
  値を文字列化し、標準出力するアクションを返却する

### 2.6. 関数定義

引数をもった関数は次のように定義する。
（文字列を受け取り、最初のn行を返却する関数）
```
firstNLines n cs = unlines $ take n $ lines cs
```

### 2.7. unlines

lines関数の逆で、複数の文字列を改行コードで結合し、１つの文字列にする

### 2.8. take

リスト先頭からn要素をとってリストで返却する

### 2.9. reverse

リストを受け取り、逆順にして返却する

```
takeLast n ss = reverse $ take n $ reverse ss
```
