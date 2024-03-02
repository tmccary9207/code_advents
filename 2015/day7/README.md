# 2015 - DAY 7

This challenge is a key/value and logic gate application. `AND OR NOT RSHIFT LSHIFT` are the operators. Return the value of `a` after connecting all the wires and getting a value. In part 2, you override the value of wire `b` and return the value of `a` after running the logic again.

このチャレンジーはキー・Valueとロジックゲート処理です。`AND OR NOT RSHIFT LSHIFT` 対策は必要です。最後で `a` の値を返す。パート２で返した値を `b` に設定してそしてロジックゲートを再実行する。

## MY ANSWER?

```
Wire A's value is 16076.
Wire A's value when B is overridden with 16076 is 2797.
```

## DENO/TYPESCRIPT

This one was a bit tough for me. Javascript has 32 bit integers with the signed bits being in the leftmost digits. So for each operation I use `& 0xFFFF` to make sure I keep them in 16 bit space. I just loop while their are instructions and use filter to weed out the instructions I have completed. Recursing from the wire you want would be the most optimal strategy but from a mental overhead standpoint I would rather calculate and be done.

ちょっと難しいと思います。JSは３２ビット数字を使っているので `& 0xFFFF` はそのサインビットを守る。ループで実行した命令をフィルターする。一番OptimalはRecursive計算ですがわかりやすいのために先に計算するは良いと思います。

## PYTHON 3

The same logic but I got a more convention oriented and used logic that if something doesn't exist then it must be a certain type. Writing doctests in Python3 is a bit more difficult when it is a dict you are testing. Better to just set a variable and check equals than write the output.

同じのロジックを使ったがConventionのように処理実行する。Python3のDoctestはDictのタイプでちょっと辛いです。Variableにキレイように書くそしてそのVariableをEqualにテストするは楽です。

## RUBY 3

I decided to lean on hashes and more obvious naming. Don't know if it really made it more readable. For the while logic I used a flag of work having been done as a signal to go another round with the stop condition being that the value for the target wire was already found.

今回ハッシュを使ってと読みやすいキー名に設定する決めた。本当に読みやすいかどうかわからないです。While文でProcの返す値を使った（ロジック・値設定したらも一回ループする）。パフォーマンスのためにもう目標Wireの値が設定したらループを止める。

## GO

Go was a bit fun but way too verbose for my taste. The fact I finally got access to unsigned helps but when doing not requires an "AND" operation to turn off the most signifigant digit throwing off the calculation. Good exercise and plenty of tests. Just wish there was a native way in Go of handling co-rountines to run through the values parsed to speed up processing.

## RUST

I think this is my best implementation so far. Types helped a bit but dealing with borrow checking was difficult. I think it works and runs as fast as I can make it with my current Rust experience.

このインプレメンテションは僕の一番良いと思います。タイプチェックは便利ですけど借りるチェックは辛かった。ラスト経験比べるとこれは早いと思います。

## ELIXIR

I tried to do what I did in Rust with Elixir and it works pretty well.

## CLOJURE

