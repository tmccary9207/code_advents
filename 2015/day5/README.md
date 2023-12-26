# 2015 - DAY5

From a text file we are going to decide whether a piece of data is naught or nice. Afterwards, sum up the nice data pieces.

テキストファイルからNiceまたはNaughty文字列を判断する。その後Niceデータを数る。

## Criteria

1. three or more vowels (aeiou) ３つVowels
2. one letter twice in a row 文字のペアがある
3. does not contain `ab`, `cd`, `pq`, or `xy` を持てない

## MY ANSWER?

`238` nice strings in my input.

## DENO/TYPESCRIPT

I fought my temptation to make this just a regex as that would be harder to understand later. Instead, I made three functions that use a regex and check the length of it (does not contain condition is looking for falsy). From there it is just chaining `&&` to make sure all are `true`. The script just splits the input on newlines then runs `isStringNice` as a filter function then returns the length.

このチャレンジーで一つREGEXを使うのことを我慢した。後で読む・わかるは辛いと思った。代わりに３つ関数をREGEXで条件をチェックする。それから親関数はANDロジックで全ケースはTRUEをチェックする。メインでインプットをニューラインでスプリットするそして親関数でフィルターする。最後TRUE値の配列のカウント返す。

## PYTHON 3

I did the function combo of Typescript. However, Python3's regex functions "feel" different to me. Anyways, it runs super fast.

タイプスクリプトようにしました。パイソン３のREGEX関数は違うのように感じる（ご意見）。早え〜！

## RUBY 3

Same function combo. However, Ruby's regex for the has three or more vowels turns out to be a string scan instead of regex. Aside from that it's pretty much the same.

タイプスクリプトようにしました。でも３つのVowel処理は文字列オブジェクトのScanを実行する。それ以外大体同じです。

## GO

A little more difficult. Go doesn't support back reference Regexes so a walk rune by rune is required. Aside from that it's the same.

ちょっと難しいです。GO言語はRegexのReferenceをサポートしません（速度のために）。それ以外で同じです。

## RUST

This is similar to Go in that the regex isn't feature full here for performance. Same strategy and just as quick.

Go言語のように完全REGEXサポートなしですができました。

## ELIXIR


## CLOJURE


