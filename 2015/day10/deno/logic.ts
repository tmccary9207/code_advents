/**
 * Get a Look And Say Sequence of a digit only string.
 * @param input Input String
 * @returns A new string with Look And Say Sequence when evaluating the input string.
 */
function lookAndSay(input: string): string {
  const chars = input.split('');
  let currentChar = chars[0];
  let currentCharCount = 0;
  let output = '';

  for (const char of chars) {
    if (currentChar == char) {
      ++currentCharCount;
    } else {
      output = output + currentCharCount.toString() + currentChar;
      currentChar = char;
      currentCharCount = 1;
    }
  }
  output = output + currentCharCount.toString() + currentChar;

  return output;
}

export { lookAndSay }
