type parts = [string, string, number];
type routemap = { [key: string]: { [key2: string]: number } };

/**
 * Takes a line of input and splits it into origin, destination, distance array.
 * @param {string} input "x to y = 1"
 * @returns ["x", "y", 1]
 */
function lineToParts(input: string): parts {
  const [origin, _, destination, __, distance] = input.split(" ");
  return [origin, destination, parseInt(distance)];
}

/**
 * Gets the route map based on an array of parts.
 * @param partArrays Array of parts.
 * @returns Route map of all possible movements.
 */
function getRouteMap(partArrays: parts[]): routemap {
  const routes: routemap = {};
  partArrays.forEach(([x, y, distance]) => {
    const originMap = routes[x] || {};
    const destMap = routes[y] || {};
    originMap[y] = distance;
    destMap[x] = distance;
    routes[x] = originMap;
    routes[y] = destMap;
  });
  return routes;
}

/**
 * Get the shortest distance that can be traveled from
 * a given routemap.
 * @param routes Route map of all possible movements.
 * @returns Shortest distance
 */
function getShortestRoute(routes: routemap): number {
  const locations = Object.keys(routes);
  const numberOfHops = locations.length - 1;
  let shortest = Infinity;

  // Loop over starting locations.
  for (let i = 0; i < locations.length; ++i) {
    let distanceForRoute = 0;
    const startLocation = locations[i];
    const visited = [startLocation];

    // Loop over locations to visit.
    for (let j = 0; j < numberOfHops; ++j) {
      const origin = routes[visited[j]];
      const destinationsNotYetVisited = Object.keys(origin).filter(
        (x) => !visited.includes(x),
      );

      if (destinationsNotYetVisited.length == 0) {
        // Found a dead end.
        break;
      }

      const [chosenDestination, distance] = destinationsNotYetVisited.reduce(
        (chosen, x) => {
          const xDistance = origin[x];
          if (xDistance < chosen[1]) {
            return [x, xDistance];
          }
          return chosen;
        },
        [
          destinationsNotYetVisited[0],
          origin[destinationsNotYetVisited[0]],
        ],
      );
      visited.push(chosenDestination);
      distanceForRoute += distance;
    }

    if (visited.length == locations.length && distanceForRoute < shortest) {
      shortest = distanceForRoute;
    }
  }

  return shortest;
}

/**
 * Get the longest distance that can be traveled from
 * a given routemap.
 * @param routes Route map of all possible movements.
 * @returns Shortest distance
 */
function getLongestRoute(routes: routemap): number {
  const locations = Object.keys(routes);
  const numberOfHops = locations.length - 1;
  let longest = 0;

  // Loop over starting locations.
  for (let i = 0; i < locations.length; ++i) {
    let distanceForRoute = 0;
    const startLocation = locations[i];
    const visited = [startLocation];

    // Loop over locations to visit.
    for (let j = 0; j < numberOfHops; ++j) {
      const origin = routes[visited[j]];
      const destinationsNotYetVisited = Object.keys(origin).filter(
        (x) => !visited.includes(x),
      );

      if (destinationsNotYetVisited.length == 0) {
        // Found a dead end.
        break;
      }

      const [chosenDestination, distance] = destinationsNotYetVisited.reduce(
        (chosen, x) => {
          const xDistance = origin[x];
          if (xDistance > chosen[1]) {
            return [x, xDistance];
          }
          return chosen;
        },
        [
          destinationsNotYetVisited[0],
          origin[destinationsNotYetVisited[0]],
        ],
      );
      visited.push(chosenDestination);
      distanceForRoute += distance;
    }

    if (visited.length == locations.length && distanceForRoute > longest) {
      longest = distanceForRoute;
    }
  }

  return longest;
}

export { getLongestRoute, getRouteMap, getShortestRoute, lineToParts };
