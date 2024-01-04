# 2015 - DAY 7

This challenge is a key/value and logic gate application. `AND OR NOT RSHIFT LSHIFT` are the operators. Return the value of `a` after connecting all the wires and getting a value. In part 2, you override the value of wire `b` and return the value of `a` after running the logic again.

このチャレンジーはキー・Valueとロジックゲート処理です。`AND OR NOT RSHIFT LSHIFT` 対策は必要です。最後で `a` の値を返す。パート２で返した値を `b` に設定してそしてロジックゲートを再実行する。

## MY ANSWER?

```
Wire A's value is 16076.
Wire A's value when overridden with 16076 is 2797.
```

## DENO/TYPESCRIPT

This one was a bit tough for me. Javascript has 32 bit integers with the signed bits being in the leftmost digits. So for each operation I use `& 0xFFFF` to make sure I keep them in 16 bit space. I just loop while their are instructions and use filter to weed out the instructions I have completed. Recursing from the wire you want would be the most optimal strategy but from a mental overhead standpoint I would rather calculate and be done.

ちょっと難しいと思います。JSは３２ビット数字を使っているので `& 0xFFFF` はそのサインビットを守る。ループで実行した命令をフィルターする。一番OptimalはRecursive計算ですがわかりやすいのために先に計算するは良いと思います。

## PYTHON 3

## RUBY 3

## GO

## RUST

## ELIXIR

## CLOJURE

