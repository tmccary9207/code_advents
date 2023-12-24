/**
 * Checks if there are three or more vowels in a string.
 * @param {string} datum String to check.
 */
function hasThreeOrMoreVowels(datum: string): boolean {
    return (datum.match(/([aeiou])/g) || []).length > 2;
}

/**
 * Checks if there is a pair of letters repeated in a string.
 * @param {string} datum String to check.
 */
function hasSameLetterPair(datum: string): boolean {
    return (datum.match(/(.)\1{1,}/g) || []).length > 0;
}

/**
 * Checks if there is any naughty strings in the string.
 * @param {string} datum String to check.
 */
function hasNoNaughtyStrings(datum: string): boolean {
    return (datum.match(/(ab)|(cd)|(pq)|(xy)/g) || []).length < 1;
}

/**
 * Checks if string is nice.
 * @param {string} datum String to check.
 */
function isStringNice(datum: string): boolean {
    return hasThreeOrMoreVowels(datum) &&
        hasSameLetterPair(datum) &&
        hasNoNaughtyStrings(datum);
}

export { hasThreeOrMoreVowels, hasSameLetterPair, hasNoNaughtyStrings, isStringNice }
