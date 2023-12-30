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


## RUST


## ELIXIR


## CLOJURE


