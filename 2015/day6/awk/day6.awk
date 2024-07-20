#! /usr/bin/gawk

BEGIN {
    FS = " ";
}

# Handle lines like
# "toggle x1,y1 through x2,y2"
NF == 4 {
    # ONE/TWO_CORDS[1] + ONE/TWO_CORDS[2]
    split($2, ONE_CORDS, ",");
    split($4, TWO_CORDS, ",");

    for (I = ONE_CORDS[1]; I <= TWO_CORDS[1]; ++I) {
        for (J = ONE_CORDS[2]; J <= TWO_CORDS[2]; ++J) {
            # Part One Logic
            if (LIGHT_ARRAY_ONE[I][J]) {
                LIGHT_ARRAY_ONE[I][J] = 0;
            } else {
                LIGHT_ARRAY_ONE[I][J] = 1;
            }

            # Part Two Logic
            LIGHT_ARRAY_TWO[I][J] += 2;
        }
    }
}

# Handle lines like
# "turn on/off x1,y1 through x2,y2"
NF == 5 {
    split($3, ONE_CORDS, ",");
    split($5, TWO_CORDS, ",");

    if ($2 == "on") {
        NEW_VALUE = 1;
        NEW_VALUE_TWO = 1;
    } else {
        NEW_VALUE = 0;
        NEW_VALUE_TWO = -1;
    }

    for (I = ONE_CORDS[1]; I <= TWO_CORDS[1]; ++I) {
        for (J = ONE_CORDS[2]; J <= TWO_CORDS[2]; ++J) {
            # Part One Logic
            LIGHT_ARRAY_ONE[I][J] = NEW_VALUE;

            # Part Two Logic
            TEMP = LIGHT_ARRAY_TWO[I][J] + NEW_VALUE_TWO;
            LIGHT_ARRAY_TWO[I][J] = TEMP > 0 ? TEMP : 0;
        }
    }
}

END {
    for (I = 0; I < 1000; ++I) {
        for (J = 0; J < 1000; ++J) {
            LIGHTS_ON += LIGHT_ARRAY_ONE[I][J];
            TOTAL_BRIGHTNESS += LIGHT_ARRAY_TWO[I][J];
        }
    }
    print(LIGHTS_ON" lights are on.");
    print(TOTAL_BRIGHTNESS" is the total brightness.");
}
