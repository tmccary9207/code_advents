# 2015 - DAY2

1. Each present is in the form of `{ Length }x{ Width }x{ Height }` .
2. Calculating the surface area is done by `2*l*w + 2*w*h + 2*h*l` .
3. After calculating surface area add slack by using the smallest of the three dimensions above.
4. Sum up all calulated surface areas with their respective slacks.

## MY ANSWER?

My challenge input ends up with `1606483` as the answer.

## DENO/TYPESCRIPT

Since the file ends with invalid input a blank string because the input is one present per line I chop off the last newline. From there it is simply a case of splitting the string, calculating sides then adding the slack in a function. The last thing is to sum up all the results which is where I use reduce again.

インプットファイルの最後にニューラインがあるのでそれを削除する。それから文字列をスプリットして、3つサイドの計算、予備を追加する。最後で全結果を纏める。

## PYTHON 3


## RUBY 3


## GO


## RUST


## ELIXIR


## CLOJURE

