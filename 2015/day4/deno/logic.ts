import { crypto } from "https://deno.land/std@0.209.0/crypto/mod.ts";
import { encodeHex } from "https://deno.land/std@0.209.0/encoding/hex.ts";

/**
 * Checks if hash starts with five zeros.
 * @param {string} hash MD5 hash string.
 */
function doesHashStartWithFiveZeros(hash: string): boolean {
    return hash.slice(0, 5) === "00000";
}

/**
 * Gets the lowest possible positive number for the secret key that when hashed has five leading zeros.
 * @param {string} secretKey Secret Key
 */
async function getLowestNumber(secretKey: string): Promise<number> {
    let lowestNumber = 0;
    const encoder = new TextEncoder();
    while (lowestNumber < Number.MAX_SAFE_INTEGER) {
        const hash  = await crypto.subtle.digest("MD5", encoder.encode(`${secretKey}${lowestNumber}`));
        const hashHex = encodeHex(hash);
        if (doesHashStartWithFiveZeros(hashHex)) {
            break;
        }
        ++lowestNumber;
    }
    return lowestNumber;
}

export { doesHashStartWithFiveZeros, getLowestNumber }
