/**
 * Reduces the input for santa's movements and returns the floor number.
 * @returns floor number
 */
function reducer(input: string) {
    return input.split('').reduce((acc, val) => {
        if (val === '(') {
            return acc + 1;
        }
        return acc - 1;
    }, 0);
}

export { reducer };
