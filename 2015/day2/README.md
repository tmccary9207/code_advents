# 2015 - DAY2

1. Each present is in the form of `{ Length }x{ Width }x{ Height }` .
2. Calculating the surface area is done by `2*l*w + 2*w*h + 2*h*l` .
3. After calculating surface area add slack by using the smallest of the three dimensions above.
4. Sum up all calulated surface areas with their respective slacks.

1. プレセントのサイズは `長さｘ広さｘ高さ` でエンコードされた文字列。
2. サーフィスエリアの計算は `２＊長さ＊広さ + ２＊広さ＊高さ + ２＊高さ＊長さ`。
3. 計算後でスラックを追加して必要です。スラックは一番小さい（広さ、長さ、高さ）。
4. 全プレセントの２＋３の合計は答えです。

## MY ANSWER?

My challenge input ends up with `1606483` as the answer.

## DENO/TYPESCRIPT

Since the file ends with invalid input a blank string because the input is one present per line I chop off the last newline. From there it is simply a case of splitting the string, calculating sides then adding the slack in a function. The last thing is to sum up all the results which is where I use reduce again.

インプットファイルの最後にニューラインがあるのでそれを削除する。それから文字列をスプリットして、3つサイドの計算、予備を追加する。最後で全結果を纏める。

## PYTHON 3

The python3 code is very much like the Deno/TypeScript code. The only real difference are some comprehensions.

パイソン3は大分タイプスクリプトとそっくりです。差はComprehensionを使った。

## RUBY 3

More of the same here. The chaining looks better than Python3 to me.

ルビーはパイソンとタイプスクリプトそっくりです。オブジェクトメソッドチェインはきれいと思います。

## GO

Go is pretty similar but requires the usual reference passes and error checking.

Go言語もそっくりですがレファレンスパスとエラーチェック必要でした。

## RUST

Rust was a bit harder than I was expecting. Most of this was due to the guarantees that Rust enforces.

Rust版はちょっと難しいでした。大分は ~expect~ / ~unwrap~ の保証です。

## ELIXIR

Elixir is such a pleasure to use with pipes taking care of the intermediate values.

Elixirは楽しかった、パイプ形式はIntermediate値を任せる。

## CLOJURE

The clojure solution looks good. I used some threading macros for beauty (in the eye of the beholder). As simple as I could think to do it right now.

Clojureのソリューションはよいと思います。スレーマクロをつかった。これはわかりやすいとおもいます。

## AWK

This one was easy in Awk. Just separate by the x create, calculate the three sides, select the smallest. After that just add up all the sides and multiply by 2 then add in the slack. Toss that into the sum. Done. It's almost like this problem was made for Awk or Perl.
