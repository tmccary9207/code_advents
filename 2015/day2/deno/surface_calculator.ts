/**
 * Calculate the surface area of the present.
 * @returns Surface Area of the present.
 */
function surfaceArea(sides: number[]) {
    return sides
        .map(x => x * 2)
        .reduce((acc, x) => acc + x, 0);
}

/**
 * Calculate the surface area plus slack for a present.
 */
function surfaceAreaWithSlack(input: string) {
    // Force TS to see this as a three item tuple instead of a number array.
    // This program isn't designed to handle bad input but before calling this
    // input it is advisable to check for bad input.
    const [length, width, height] = input.split('x')
        .map(x => parseInt(x)) as [number, number, number];
    const sides = [(length * width), (width * height), (height * length)];
    return surfaceArea(sides) + Math.min(...sides);
}

export { surfaceAreaWithSlack }
