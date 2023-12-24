##
# Checks if there are three or more vowels in a string.
def has_three_or_more_vowels(datum)
  datum.scan(/([aeiou])/).length > 2
end

##
# Checks if there is a pair of letters repeated in a string.
def has_same_letter_pair(datum)
  /(.)\1{1,}/.match?(datum)
end

##
# Checks if there is any naughty strings in the string.
def has_no_naughty_strings(datum)
  /(ab)|(cd)|(pq)|(xy)/.match?(datum) == false
end

##
# Checks if string is nice.
def is_string_nice(datum)
  has_three_or_more_vowels(datum) and
    has_same_letter_pair(datum) and
    has_no_naughty_strings(datum)
end
