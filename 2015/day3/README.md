# 2015 - DAY3

1. `^` -> Y + 1
2. `v` -> Y - 1
3. `>` -> X + 1
4. `<` -> X - 1

Santa starts off at 0,0 and moves around a grid according to the directions above. The challenge is to parse input and return the number of times Santa visted a location at least once.

## MY ANSWER?

My challenge input ends up with `2592` as the answer.

## DENO/TYPESCRIPT

For each direction I use a helper function that calculates the new cordinates. I put the cordinates in a Set and return the size.

ForEachの命令で関数から新規位置を計算する。新規位置をSetにいれてそしてSetのサイズを返す。

## PYTHON 3

Pretty much the same as the Deno/TypeScript version. Not much interesting going on.

タイプスクリプトのように見えそうです。あんまり違いません。

## RUBY 3

Pretty much the same as typescript and python3. A simple implementation.

タイプスクリプトのように見えそうです。あんまり違いません。

## GO

Like the others except the Set implementation comes from a package external to Golang.

他の言語のようにしましたが今回外部パッケージを使いました（Set）。

## RUST

Pretty similar to the others. Not much to say.

他の言語のようにしました。

## ELIXIR

Similar solution but a more compilicated reducer pattern.

他の言語そっくりですがReduce処理はちょっとわかりにくいです。

## CLOJURE

Not the cleanest or simpilist solution in my opinion. `conj` visited locations and the newest location in the reduce then turn the visited locations into a set. I'm sure there is a more simple looking solution I just can't imagine one at the moment.

一番キレイ・わかりやすいではないと思います。 `conj` を行ったところリストに追加してそしてReduceの後にリストをSETに変換する。そのSETのカウントを返す。もっと簡単な方法あると思いますがClojureの詳しくないのでいつかこの問題をRevisitする。

# AWK

Another smashingly easy implementation in Awk. Just couple of variables and an array to set via string keys with a counting of the number of elements in the array at the end. It almost runs too fast.
