# 2015 - DAY 6

1,000x1,000 grid of lights is present. From there instructions are given in `action from-position through to-position` with the action being `turn on`, `toggle` or `turn off` while the positions are a pair of numbers representing a rectangle (inclusive). The goal is to output how many lights are left on. The lights start off in the off position.

1,000 x 1,000 光グリッドで説明からアクション・Rectangleの位置から光コントロールする。最後に何点まだ光っているを出力する。アクション：turn off オフする, turn on オンにする, toggle オフ・オン状態を着替える。初期化状態で全光はオフです。

## MY ANSWER?

`543903` lights are on.

## DENO/TYPESCRIPT

I use some Typescript Enums (some folks hate them because of performance) and an interface to keep myself coordinated. From there, the plan is to take each row of input and turn that into a set of instructions. In Javascript, creating a filled 2D array with arrays generated with `fill` creates references so the `from` with a lambda function that calls fill for uniqueness is required. After translating the instructions and creating an array I use a double loop to set the lights state. Lastly, I just loop through each row and column counting the ones that are on.

タイプスクリプトのEnumとインターフェースを使っている（わかりやすいと思います）。これからインプットを命令に変換する。（Javascriptで２D配列を作るのときにダブル `fill` するとレファレンス作るのでバグ発生する。）命令配列をループするそしてそれからX/Yに光ステートを設定する。最後にカウントする。

## PYTHON 3


## RUBY 3


## GO


## RUST


## ELIXIR


## CLOJURE


