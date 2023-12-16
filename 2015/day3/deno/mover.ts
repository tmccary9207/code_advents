/**
 * Gets the cordinates for Santa's new location.
 * @param [currentX, currentY] - current location of Santa
 * @param direction - the direction from the elf
 * @returns a new number tuple which is Santa's location.
 */
function santaNewLocation([currentX, currentY]: [number, number], direction: string): [number, number] {
    let newCord = 0;
    switch(direction) {
        case "^":
            newCord = currentY + 1;
            return [currentX, newCord];
        case "v":
            newCord = currentY - 1;
            return [currentX, newCord];
        case ">":
            newCord = currentX + 1;
            return [newCord, currentY];
        case "<":
            newCord = currentX - 1;
            return [newCord, currentY];
        default:
            return [currentX, currentY];
    }
}

/**
 * Takes in directions from an elf and returns the number of unique houses Santa visited.
 * @param directions Directions from an elf
 * @returns The number of unique houses Santa visited.
 */
function takeDirections(directions: string): number {
    const visited = new Set<string>(["0,0"]);
    let currentLocation: [number, number] = [0, 0];
    directions
        .split('')
        .forEach((direction) => {
            currentLocation = santaNewLocation(currentLocation, direction);
            visited.add(`${currentLocation[0]},${currentLocation[1]}`);
        });
    return visited.size;
}

export { santaNewLocation, takeDirections }
