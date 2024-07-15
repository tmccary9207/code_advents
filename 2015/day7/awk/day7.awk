#! /usr/bin/gawk

BEGIN {
    FS=" ";
    OPERATION="OP";
    NAMED="NAMED";
    NUMER="NUMER";
    ASSIGN="ASSIGN";
    TARGET = "a";
}

NF {
    NUM_OF_NAMED = 0;
    NUM_OF_NUMER = 0;
    WIRE_NAME = "";
    OP = "";

    # SET WIRE_NAME, OP, ARGS ACCORDING TO THE THREE TYPES
    # OF OPERATIONS THAT ARE PRESENT.
    if (NF == 5) {
        WIRE_NAME = $5;
        OP = $2;
        ARGS[0] = $1;
        ARGS[1] = $3;
    } else if (NF == 4) {
        WIRE_NAME = $4;
        OP = $1;
        ARGS[0] = $2;
    } else {
        WIRE_NAME = $3;
        OP = ASSIGN;
        ARGS[0] = $1;
    }

    OPS[WIRE_NAME][OPERATION] = OP;

    # SET NUMERIC AND NAMED ARGUMENT ARRAYS.
    for (ARG in ARGS) {
        if (ARGS[ARG] ~ /^[0-9]+$/) {
            OPS[WIRE_NAME][NUMER][NUM_OF_NUMER] = ARGS[ARG];
            NUM_OF_NUMER++;
        } else {
            OPS[WIRE_NAME][NAMED][NUM_OF_NAMED] = ARGS[ARG];
            NUM_OF_NAMED++;
        }
    }

    # CLEAR OUT GENERAL ARGUMENTS ARRAY FOR NEXT LINE.
    delete ARGS;
}

function all_named_args_exist(op) {
    ALL_EXIST = 1;
    for (ARG_NUM in op[NAMED]) {
        ALL_EXIST = (op[NAMED][ARG_NUM] in CALC);
    }
    return ALL_EXIST;
}

function get_value_for_wire(op) {
    # SET LEFT AND RIGHT OPERANDS FOR OPERATION.
    LEFT = 0;
    HAS_LEFT = 0;
    RIGHT = 0;
    for (ARG_NUM in op[NAMED]) {
        VAL = CALC[op[NAMED][ARG_NUM]];
        if (HAS_LEFT) {
            RIGHT = VAL;
        } else {
            LEFT = VAL;
            HAS_LEFT = 1;
        }
    }
    for (ARG_NUM in op[NUMER]) {
        VAL = op[NUMER][ARG_NUM];
        if (HAS_LEFT) {
            RIGHT = VAL;
        } else {
            LEFT = VAL;
            HAS_LEFT = 1;
        }
    }

    # RUN THE OPERAND ON THE BOTH UNLESS IT IS NOT OR ASSIGN.
    switch (op[OPERATION]) {
    case "AND":
        return and(LEFT, RIGHT);
    case "OR":
        return or(LEFT, RIGHT);
    case "LSHIFT":
        return lshift(LEFT, RIGHT);
    case "RSHIFT":
        return rshift(LEFT, RIGHT);
    case "NOT":
        return compl(LEFT);
    default:
        return LEFT;
    }
}

function calculate_target() {
    while (1) {
        if (TARGET in CALC) {
            break;
        }

        for (WIRE_NAME in OPS) {
            if (WIRE_NAME in CALC) {
                continue;
            }
            if (all_named_args_exist(OPS[WIRE_NAME])) {
                CALC[WIRE_NAME] = get_value_for_wire(OPS[WIRE_NAME]);
            }
        }
    }
}

END {
    calculate_target();

    # GET THE FIRST A VALUE THEN CLEAR CALCULATIONS AND OVERWRITE
    # B'S VALUE.
    FIRST_A = CALC[TARGET];
    delete CALC;
    delete OPS["b"];
    OPS["b"][OPERATION] = ASSIGN;
    OPS["b"][NUMER][0] = FIRST_A;

    calculate_target();

    SECOND_A = CALC[TARGET];

    print("Wire A's value is "FIRST_A".");
    print("Wire A's value when B is overridden with "FIRST_A" is "SECOND_A".");
}
