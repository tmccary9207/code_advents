function countMemoryChars(input: string) {
  return input.replaceAll(/(\\x[0-9|a-f|A-F]{2})|(\\")|(\\\\)/g, "A")
    .replaceAll(/\"/g, "")
    .length;
}

function reencodeString(input: string) {
  return '"' + input.replaceAll(/(\\)/g, "\\\\").replaceAll(/(")/g, '\\"') +
    '"';
}

export { countMemoryChars, reencodeString };
