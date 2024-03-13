# frozen_string_literal: true

def count_memory_chars(input)
  no_quotes = input[1..-2]
  two_letter_match_count = no_quotes.scan(/(\\")|(\\\\)/).length
  four_letter_match_count = no_quotes.scan(/(\\x[0-9|a-f|A-F]{2})/).length
  input.length - (no_quotes.length - (two_letter_match_count + (3 * four_letter_match_count)))
end

def count_reencode_string_chars(input)
  no_quotes = input[1..-2]
  escaped_slash_count = no_quotes.scan(/(\\)/).length
  escaped_quotes_count = no_quotes.scan(/(")/).length
  (escaped_slash_count + escaped_quotes_count) + 4
end
