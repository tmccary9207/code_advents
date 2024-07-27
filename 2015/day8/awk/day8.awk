#! /usr/bin/gawk

/^".*"$/ {
  DOUBLE_SLASHES = gsub(/\\\\/, "", $1);
  SLASH_QUOTES = gsub(/\\"/, "", $1);
  HEX_ENCODES = gsub(/\\x[0-9|a-f|A-F]{2}/, "", $1);
  MEMORY_CHARS += 2 + DOUBLE_SLASHES + SLASH_QUOTES + (3 * HEX_ENCODES);
  # 4 FOR THE ESCAPE QUOTES ON ALL STRINGS + 2 FOR EACH DOUBLE SLASH + 2 FOR EACH SLASH QUOTE + THE NUMBER OF HEX ENCODES
  REENCODE_CHARS += 4 + (DOUBLE_SLASHES * 2) + (SLASH_QUOTES * 2) + HEX_ENCODES;
}

END {
  print("The number of characters of code for string literals minus the number of characters in memory for the values of the strings is "MEMORY_CHARS".");
  print("The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is "REENCODE_CHARS".");
}
