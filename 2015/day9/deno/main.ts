import {
  getLongestRoute,
  getRouteMap,
  getShortestRoute,
  lineToParts,
} from "./logic.ts";

// Learn more at https://deno.land/manual/examples/module_metadata#concepts
if (import.meta.main) {
  const text = await Deno.readTextFile("../myinput.txt");
  const lines = text.trimEnd().split("\n");
  const routes = getRouteMap(lines.map(lineToParts));
  const shortest = getShortestRoute(routes);
  const longest = getLongestRoute(routes);

  console.log(`Shortest possible distance is: ${shortest}`);
  console.log(`Longest possible distance is: ${longest}`);
}
