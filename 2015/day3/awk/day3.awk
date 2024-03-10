#! /usr/bin/gawk

BEGIN {
    FS="";
    CURRENT_X=0;
    CURRENT_Y=0;
    VISITED[CURRENT_X"_"CURRENT_Y""]++;
}

{
    for (i=1;i<=NF;i++) {
        switch ($i) {
        case "^":
            CURRENT_Y++;
            break;
        case "v":
            CURRENT_Y--;
            break;
        case ">":
            CURRENT_X++;
            break;
        case "<":
            CURRENT_X--;
            break;
        }
        VISITED[CURRENT_X"_"CURRENT_Y""]++;
    }
}

END {
    for (x in VISITED) count++;
    printf("At least this many houses received a single present: %d", count);
}
