import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { applyLogic, getInstructions, isInstructionDoable, runInstructions, setupWiresWithValueInstructions, translateInstructions } from "./logic.ts";

Deno.test("translateInstructions", () => {
    assertEquals(
        {
            type: "valueInstruction",
            wireLabel: "x",
            value: "123",
        },
        translateInstructions("123 -> x")
    );
    assertEquals(
        {
            type: "leftRightLogicInstruction",
            wireLabel: "z",
            logicLeft: "x",
            logicLeftNumber: false,
            logicRight: "y",
            logicRightNumber: false,
            logicOperator: "AND",
        },
        translateInstructions("x AND y -> z")
    );
    assertEquals(
        {
            type: "leftRightLogicInstruction",
            wireLabel: "q",
            logicLeft: "p",
            logicLeftNumber: false,
            logicRight: "2",
            logicRightNumber: true,
            logicOperator: "LSHIFT",
        },
        translateInstructions("p LSHIFT 2 -> q")
    );
    assertEquals(
        {
            type: "notLogicInstruction",
            wireLabel: "f",
            logicRight: "e",
            logicRightNumber: false,
        },
        translateInstructions("NOT e -> f")
    );
});

Deno.test("getInstructions", () => {
    assertEquals(
        [
            [
                {
                    type: "valueInstruction",
                    wireLabel: "x",
                    value: "123",
                },
                {
                    type: "valueInstruction",
                    wireLabel: "y",
                    value: "456",
                },
            ],
            [
                {
                    type: "leftRightLogicInstruction",
                    wireLabel: "d",
                    logicLeft: "x",
                    logicLeftNumber: false,
                    logicRight: "y",
                    logicRightNumber: false,
                    logicOperator: "AND",
                },
                {
                    type: "leftRightLogicInstruction",
                    wireLabel: "e",
                    logicLeft: "x",
                    logicLeftNumber: false,
                    logicRight: "y",
                    logicRightNumber: false,
                    logicOperator: "OR",
                },
                {
                    type: "leftRightLogicInstruction",
                    wireLabel: "f",
                    logicLeft: "x",
                    logicLeftNumber: false,
                    logicRight: "2",
                    logicRightNumber: true,
                    logicOperator: "LSHIFT",
                },
                {
                    type: "leftRightLogicInstruction",
                    wireLabel: "g",
                    logicLeft: "y",
                    logicLeftNumber: false,
                    logicRight: "2",
                    logicRightNumber: true,
                    logicOperator: "RSHIFT",
                },
                {
                    type: "notLogicInstruction",
                    wireLabel: "h",
                    logicRight: "x",
                    logicRightNumber: false,
                },
                {
                    type: "notLogicInstruction",
                    wireLabel: "i",
                    logicRight: "y",
                    logicRightNumber: false,
                },
            ]
        ],
        getInstructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i")
    );
});

Deno.test("setupWiresWithValueInstructions", () => {
    assertEquals(
        new Map([
            ["x", 123],
            ["y", 456],
        ]),
        setupWiresWithValueInstructions([
            {
                type: "valueInstruction",
                wireLabel: "x",
                value: "123",
            },
            {
                type: "valueInstruction",
                wireLabel: "y",
                value: "456",
            },
        ])
    );
});

Deno.test("isInstructionDoable", () => {
    assertEquals(
        true,
        isInstructionDoable(
            {
                type: "notLogicInstruction",
                wireLabel: "f",
                logicRight: "123",
                logicRightNumber: true,
            },
            new Map<string, number>()
        )
    );
    assertEquals(
        false,
        isInstructionDoable(
            {
                type: "notLogicInstruction",
                wireLabel: "f",
                logicRight: "q",
                logicRightNumber: false,
            },
            new Map<string, number>()
        )
    );
    assertEquals(
        true,
        isInstructionDoable(
            {
                type: "notLogicInstruction",
                wireLabel: "f",
                logicRight: "q",
                logicRightNumber: false,
            },
            new Map<string, number>([["q", 1]])
        )
    );
    assertEquals(
        true,
        isInstructionDoable(
            {
                type: "leftRightLogicInstruction",
                wireLabel: "g",
                logicLeft: "2",
                logicLeftNumber: true,
                logicRight: "2",
                logicRightNumber: true,
                logicOperator: "RSHIFT",
            },
            new Map<string, number>()
        )
    );
    assertEquals(
        false,
        isInstructionDoable(
            {
                type: "leftRightLogicInstruction",
                wireLabel: "g",
                logicLeft: "x",
                logicLeftNumber: false,
                logicRight: "2",
                logicRightNumber: true,
                logicOperator: "RSHIFT",
            },
            new Map<string, number>()
        )
    );
    assertEquals(
        true,
        isInstructionDoable(
            {
                type: "leftRightLogicInstruction",
                wireLabel: "g",
                logicLeft: "x",
                logicLeftNumber: false,
                logicRight: "2",
                logicRightNumber: true,
                logicOperator: "RSHIFT",
            },
            new Map<string, number>([["x", 2]])
        )
    );
    assertEquals(
        true,
        isInstructionDoable(
            {
                type: "leftRightLogicInstruction",
                wireLabel: "g",
                logicLeft: "x",
                logicLeftNumber: false,
                logicRight: "y",
                logicRightNumber: false,
                logicOperator: "RSHIFT",
            },
            new Map<string, number>([["x", 2], ["y", 3]])
        )
    );
});

Deno.test("applyLogic", () => {
    {
        const wires = new Map([
            ["x", 123],
            ["y", 456],
        ]);
        const wiresUpdated = new Map([
            ["x", 123],
            ["y", 456],
            ["d", 72],
        ]);
        applyLogic(
            {
                type: "leftRightLogicInstruction",
                wireLabel: "d",
                logicLeft: "x",
                logicLeftNumber: false,
                logicRight: "y",
                logicRightNumber: false,
                logicOperator: "AND",
            },
            wires
        );
        assertEquals(
            wiresUpdated,
            wires
        );
    }
    {
        const wires = new Map([
            ["x", 123],
            ["y", 456],
        ]);
        const wiresUpdated = new Map([
            ["x", 123],
            ["y", 456],
            ["e", 507],
        ]);
        applyLogic(
            {
                type: "leftRightLogicInstruction",
                wireLabel: "e",
                logicLeft: "x",
                logicLeftNumber: false,
                logicRight: "y",
                logicRightNumber: false,
                logicOperator: "OR",
            },
            wires
        );
        assertEquals(
            wiresUpdated,
            wires
        );
    }
    {
        const wires = new Map([
            ["x", 123],
            ["y", 456],
        ]);
        const wiresUpdated = new Map([
            ["x", 123],
            ["y", 456],
            ["f", 492],
        ]);
        applyLogic(
            {
                type: "leftRightLogicInstruction",
                wireLabel: "f",
                logicLeft: "x",
                logicLeftNumber: false,
                logicRight: "2",
                logicRightNumber: true,
                logicOperator: "LSHIFT",
            },
            wires
        );
        assertEquals(
            wiresUpdated,
            wires
        );
    }
    {
        const wires = new Map([
            ["x", 123],
            ["y", 456],
        ]);
        const wiresUpdated = new Map([
            ["x", 123],
            ["y", 456],
            ["g", 114],
        ]);
        applyLogic(
            {
                type: "leftRightLogicInstruction",
                wireLabel: "g",
                logicLeft: "y",
                logicLeftNumber: false,
                logicRight: "2",
                logicRightNumber: true,
                logicOperator: "RSHIFT",
            },
            wires
        );
        assertEquals(
            wiresUpdated,
            wires
        );
    }
    {
        const wires = new Map([
            ["x", 123],
            ["y", 456],
        ]);
        const wiresUpdated = new Map([
            ["x", 123],
            ["y", 456],
            ["h", 65412],
        ]);
        applyLogic(
            {
                type: "notLogicInstruction",
                wireLabel: "h",
                logicRight: "x",
                logicRightNumber: false,
            },
            wires
        );
        assertEquals(
            wiresUpdated,
            wires
        );
    }
    {
        const wires = new Map([
            ["x", 123],
            ["y", 456],
        ]);
        const wiresUpdated = new Map([
            ["x", 123],
            ["y", 456],
            ["i", 65079],
        ]);
        applyLogic(
            {
                type: "notLogicInstruction",
                wireLabel: "i",
                logicRight: "y",
                logicRightNumber: false,
            },
            wires
        );
        assertEquals(
            wiresUpdated,
            wires
        );
    }
});

Deno.test("runInstructions", () => {
    assertEquals(
        72,
        runInstructions(
            "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i",
            "d"
        )
    );
    assertEquals(
        507,
        runInstructions(
            "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i",
            "e"
        )
    );
    assertEquals(
        492,
        runInstructions(
            "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i",
            "f"
        )
    );
    assertEquals(
        114,
        runInstructions(
            "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i",
            "g"
        )
    );
    assertEquals(
        65412,
        runInstructions(
            "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i",
            "h"
        )
    );
    assertEquals(
        65079,
        runInstructions(
            "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i",
            "i"
        )
    );
    assertEquals(
        123,
        runInstructions(
            "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i",
            "x"
        )
    );
    assertEquals(
        456,
        runInstructions(
            "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i",
            "y"
        )
    );
});
