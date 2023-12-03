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
