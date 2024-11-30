/**
 * Checks for the first password condition that there is three
 * ascending letters in it.
 * @param input password to check
 * @returns Whether the password has three ascending letters.
 */
export function checkConditionOne(input: string): boolean {
  const charCodes = input.split("").map((x) => x.charCodeAt(0));
  let posOne = charCodes.shift();
  let posTwo = charCodes.shift();
  let posThree = charCodes.shift();

  while (charCodes.length > 0 && posOne) {
    if (posOne + 1 == posTwo && posTwo + 1 == posThree) {
      return true;
    }

    posOne = posTwo;
    posTwo = posThree;
    posThree = charCodes.shift();
  }

  return false;
}

/**
 * Checks to make sure the password doesn't contain `i`, `l` or `o`.
 * @param input password to check
 * @returns Whether the password does not contain `i`, `l` or `o`.
 */
export function checkConditionTwo(input: string): boolean {
  return input.match(/[ilo]/) == null;
}

/**
 * Checks to see if the password has two different pairs of letters.
 * @param input password to check
 * @returns Whether the password has two different pairs of letters.
 */
export function checkConditionThree(input: string): boolean {
  const matches = input.matchAll(/([a-z])\1{1}/g).toArray();

  if (matches.length < 2) {
    return false;
  }

  const firstMatch = matches[0][0];

  for (const matchArray in matches) {
    if (firstMatch != matchArray[0]) {
      return true;
    }
  }

  return false;
}

/**
 * Checks to see password matches all required checks.
 * @param password Password to check against conditions.
 * @returns A flag indicating whether the password matches all checks.
 */
export function passesAllChecks(password: string): boolean {
  return checkConditionOne(password) && checkConditionTwo(password) &&
    checkConditionThree(password);
}

/**
 * Gets the next char alphabetically.
 * @param currentChar The current char in the password.
 * @returns Next char alphabetically.
 * 'z' -> 'a', 'h' -> 'j', 'k' -> 'm', 'n' -> 'p'
 */
export function getNextChar(currentChar: string): string {
  const currentCharCode = currentChar.charCodeAt(0);

  switch (currentCharCode) {
    case 122:
      // z -> a
      return "a";
    case 104:
    case 107:
    case 110:
      // i, l, o aren't valid so skip them.
      return String.fromCharCode(currentCharCode + 2);
    default:
      return String.fromCharCode(currentCharCode + 1);
  }
}

const letters = "abcdefghjkmnpqrstuvwxyz";
const lettersLength = 23;

/**
 * Generate combinations of strings using valid chars from
 * the designated first letter to the specified length.
 * @param length How many characters long strings to generate.
 * @param firstLetter Starting letter for the strings.
 */
function* generateCombinations(
  length: number,
  firstLetter: string,
) {
  function* helper(currentArray: string[]): Generator<string> {
    if (currentArray.length === length) {
      yield currentArray.join("");
      return;
    }
    for (let i = 0; i < lettersLength; i++) {
      yield* helper([...currentArray, letters[i]]);
    }
  }

  for (let i = letters.indexOf(firstLetter); i < lettersLength; i++) {
    yield* helper([letters[i]]);
  }
}

/**
 * Gets the next technically valid password by
 * rotating the right most character until the
 * password checks pass.
 * @param current Current password to work with.
 * @returns The next technically valid password.
 */
export function getNextPassword(current: string): string {
  const next = current.split("");
  const length = next.length;
  let nextPasswordTail: string | void;

  for (let i = length - 1; i > -1; --i) {
    // current -> abcdefgh, i -> 6
    // base -> abcdef
    // nextChar -> "g" -> "h"
    const base = next.slice(0, i).join("");
    const nextChar = getNextChar(next[i]);
    const gen = generateCombinations(length - i, nextChar);
    do {
      nextPasswordTail = gen.next().value;
      const newGeneratedPass = base + nextPasswordTail;
      if (passesAllChecks(newGeneratedPass) && newGeneratedPass != current) {
        return newGeneratedPass;
      }
    } while (nextPasswordTail);
  }

  return "";
}

// Learn more at https://docs.deno.com/runtime/manual/examples/module_metadata#concepts
if (import.meta.main) {
  const nextPassword1 = getNextPassword("cqjxjnds");
  const nextPassword2 = getNextPassword(nextPassword1);
  console.log(`Next password is: ${nextPassword1}`);
  console.log(`Next password after that is: ${nextPassword2}`);
}
