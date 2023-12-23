# 2015 - DAY4

In this challenge we are given a secret key, `bgvyzdsv` in my case, to which is appended a number then is hashed. If the hash starts with 5 zeros that is a number we are looking for. However, the challenge wants the lowest possible positive number.

このチャレンジーで秘密鍵と数字の文字列をMD5ハッシュする。そのハッシュは5個のゼロがあれば有効です。一番低い数字を返して必要です。

## MY ANSWER?

My challenge secret key ends up with `254575` as the answer.

## DENO/TYPESCRIPT

This challenge required some use of Deno.land modules. Had to try and read up on them and the extension it makes to the Crypto API. I wish there was more documentation on the functions from the LSP. The module does go over the obvious to hex string or base64 so that's good enough. Checking for five zeros is easy but I use string slice as I am not sure there is a better operation. After that the function to get the lowest number is easier. I use a while loop and break when a hash with five zeros appears. Not the fastest but it works.

このチャレンジーでDenoのモジュールを使って必要だった。JSのCryptoのAPIをちょっと読めました。スクリプト作成中でLSPからもっとドキュメント出してほしいですが。モジュールのドキュメントページでBase64とHexの文字列作成方法記載しましたのでそれは十分とおもいます。文字列のスライスで5個ゼロチェック処理を作った。それから数字取得処理で永遠WHILEを使う、5個ゼロハッシュあるのときにブレーキして返す。一番早いではと思いますが動きます。

## PYTHON 3

A lot like the Typescript version. Better documentation but Python3 requires a byte string for the digest module.

タイプスクリプトのようにしました。ドキュメントはもっとよいと思います。でもPython3はバイトストリング渡す必要です。

## RUBY 3

More of the same here. Except, unlike the previous two, there isn't an overflow check or maximum used. Ruby doesn't have such a concept it seems. I wouldn't code like this in production obviously but odd in any case.

タイプスクリプトのようにしましたが今回オーバーフロー・マックス数字チェックがないです。ルビーはマックス数字がありません（無限数字がある）。本番でこのようなコードを使いません。

## GO

Same logic different language. Looks a lot like the python3 in terms of bytes to digest string.

別言語ですが同じみたいです。大分パイソン３のようにバイトから文字列出力する。

## RUST

Used some crates for the hashing. Aside from that same logic.

別言語ですが同じみたいです。

## ELIXIR


## CLOJURE


