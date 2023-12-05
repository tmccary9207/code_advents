# 2015 - DAY1

1. Santa starts at floor 0.
2. Input of `(` he goes up one floor
3. Input of `)` he goes down one floor.
4. No min/max floors.

## MY ANSWER?

My challenge input ends up with `138` as the answer.

## DENO/TYPESCRIPT

I go for a traditional reducer style solution. Just split the string on each char and itterate over the array
that is generated from this with a reduce call. The reducer starts at 0 and just adds or subtracts 1 based on
input.

このチャンレンジでリデュース形式のソリューションを使う。インプット文字列を１文字でスプリットしてそしてその配列をリデュースする。
リデュースは `0` で始める値にコールしてそしてラムダー式関数でインプットから増える・下げる。

## PYTHON 3

I use the reducer solution again. Python3's `functools` contains `reduce` so I import that. The lambda function
is the same just python-ized. Easy enough.

リデュース形式のソリューションをつかう。Python3の `functools` から `reduce` をインポートしました。タイプスクリプトのようなラムダー式
関数を使う。

## RUBY 3

This was a weird one. I used reducer style again but with `File.read` there are extra chars in the string and
they are not newlines or line feeds. So I bit the bullet and just put a `case` instead of searching the net
for hours.

リデュース形式を使ったがロジックはちょっと違います。ルビー3は `File.read` の返す値でニューライン以外・見えない文字がある。色々試したが
解決方法見つかれなかった。 `case` を使った。

## GO

I don't write much Go but hopefully I'll get better at it over this AoC. Anyways, Go doesn't really have a reduce function built in but you can make one with generics it seems. So, the only option is to iterate over the string character by character while mutating the tally. This is the classic way of doing this.

Go言語をあんまり書いてないですがこのAoC中もっと書くと思います。Go言語は同じのリデュース関数がないです（自分でつくる必要があります）。一つのオプション残ってます、1文字1文字で合計を計算する。

## RUST

I also don't write much Rust. Thankfully, Rust does have a reduce function in the form of fold which allows you to set an initial value. Reduce in Rust doesn't take an initial value so fold it is. This was relatively easier than I had imagined.

Rust言語もあんまり書いてないです。Rustはリデュース関数ありけどFoldは最初値を受け取るのでそれを使う。思いより簡単でした。

## ELIXIR

Haven't tried Elixir much but I thought I'd try it. Being a functional first language it has a reduce function so I use that.

Elixir言語試したことがないから試すと思った。ファンクショナルファースト言語のでリデュース関数を使った。
