import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { reducer } from './reducer.ts';

Deno.test("reducer function example 1", () => {
    assertEquals(0, reducer("(())"));
    assertEquals(0, reducer("()()"));
});
Deno.test("reducer function example 2", () => {
    assertEquals(3, reducer("((("));
    assertEquals(3, reducer("(()(()("));
    assertEquals(3, reducer("))((((("));
});
Deno.test("reducer function example 3", () => {
    assertEquals(-1, reducer("())"));
    assertEquals(-1, reducer("))("));
});
Deno.test("reducer function example 4", () => {
    assertEquals(-3, reducer(")))"));
    assertEquals(-3, reducer(")())())"));
});
