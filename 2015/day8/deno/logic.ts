function countMemoryChars(input: string) {
  const noQuotes = input.slice(1, -1);
  const twoLetterMatchCount = (noQuotes.match(/(\\")|(\\\\)/g) || []).length;
  const fourLetterMatchCount =
    (noQuotes.match(/(\\x[0-9|a-f|A-F]{2})/g) || []).length;
  return input.length -
    (noQuotes.length - (twoLetterMatchCount + (3 * fourLetterMatchCount)));
}

function reencodeString(input: string) {
  return '"' + input.replaceAll(/(\\)/g, "\\\\").replaceAll(/(")/g, '\\"') +
    '"';
}

function reencodeStringChars(input: string) {
  const escapedSlashCount = (input.match(/(\\)/g) || []).length;
  const escapedQuotesCount = (input.match(/(")/g) || []).length - 2;
  return (escapedSlashCount + escapedQuotesCount) + 4;
}

export { countMemoryChars, reencodeString, reencodeStringChars };
