# 2015 - DAY 6

1,000x1,000 grid of lights is present. From there instructions are given in `action from-position through to-position` with the action being `turn on`, `toggle` or `turn off` while the positions are a pair of numbers representing a rectangle (inclusive). The goal is to output how many lights are left on. The lights start off in the off position.

1,000 x 1,000 光グリッドで説明からアクション・Rectangleの位置から光コントロールする。最後に何点まだ光っているを出力する。アクション：turn off オフする, turn on オンにする, toggle オフ・オン状態を着替える。初期化状態で全光はオフです。

## MY ANSWER?

`543903` lights are on.

## PART 2

Things get a bit complicated. Toggle means add 2, turn on means add 1 and turn off means minus 1 (no negatives). After that, sum up the values of all lights.

ちょっと難しいです。 `toggle` は２に足す。 `turn on` は１に足す。 `turn off` は１に減らす（マイナスは０に設定する）。最後に合計を返す。

## MY ANSWER (PART 2)?

`14687245` is the total brightness.

## DENO/TYPESCRIPT

I use some Typescript Enums (some folks hate them because of performance) and an interface to keep myself coordinated. From there, the plan is to take each row of input and turn that into a set of instructions. In Javascript, creating a filled 2D array with arrays generated with `fill` creates references so the `from` with a lambda function that calls fill for uniqueness is required. After translating the instructions and creating an array I use a double loop to set the lights state. Lastly, I just loop through each row and column counting the ones that are on.

タイプスクリプトのEnumとインターフェースを使っている（わかりやすいと思います）。これからインプットを命令に変換する。（Javascriptで２D配列を作るのときにダブル `fill` するとレファレンス作るのでバグ発生する。）命令配列をループするそしてそれからX/Yに光ステートを設定する。最後にカウントする。

## PYTHON 3

I don't have the same typing as Typescript so I use a dictionary and the optional hinting. From there it is range and for loops. I learned that you can't cache a range in python3 and it be efficient. Everything else is the same.

タイプスクリプトのようにタイプ同じできませんがオプションタイプとDictを使う。それからRangeとForループを使う。Rangeをキャッシュするは無理です。それ以外で同じです。

## RUBY 3

This was a bit odd to me. Ruby shares the same 2D array creation rule as Javascript. Instead you need to pass a Proc that'll generate a new Array for each Array. I'm pretty sure some performance person says that is expected but how often does a solution require an array that is pre-filled with references to the same array? Aside from that the inline if else value setting is nice.

ちょっと変と思います。ルビーは同じの２D配列の作成ルールがある（JS）。新規配列の後ろにProcを渡すそしてそれは新しいインスタンスを作成する。それ以外でインラインIFは良いです。

## GO

This is one of the first times I felt Go was too verbose but in a production environment it would be good. Instruction translating wasn't that bad just long. Making the array was nice because in Go the default for integers is zero. It runs pretty fast in my opinion.

今回で面倒と思ったが本番ソフトで良いと思います。説明翻訳は悪くないです。配列作成は簡単です（Go言語数字の標準値は０）。スクリプト言語より早いです。

## RUST

I used a 2D array crate for this challenge. Made the array creation easy for sure. The code looks the same except with matches and more ownership info. Doesn't seem to run as fast the Go version.

２D配列クレートを使った。配列作成は簡単でした。大分同じですがオーナー情報がついた。Go言語より遅い感じる。

## ELIXIR

This is kind of challenging actually. Elixir is immutable and the only way to take this on is to simply return an updated map for each light in the selected rectangle. No real alternative and the performance isn't anything to get excited about.

ちょっと難しいです。ElixirはImmutableので更新すると新しい値を返す必要。セレクトされた電球を一個一個更新は新規マップを作成する。パフォーマンスはOKと思います。でもElixirはこのような問題に弱いと思います（速さ）。

## CLOJURE

This is more or less the same as the Elixir version. I wanted to keep the immutable style but obviously it would go faster with Java Arraylists.

大分Elixirと同じです。ImmutableスタイルをキープしたいでしたがArrayListとかはもっと早いとおもいます。

## AWK

This doesn't seem fast more than likely due to the dynamic array assignment and iterrating. However, the logic is nice and simple as I can pattern match on the number of fields (toggle is 4 while turn on/off is 5). From there the dynamic assignment is pretty easy (default is zero). It seems slow but having to access a giant array like that in the Awk runtime probably the slow down.
