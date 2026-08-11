# Compiler Design Lab

This repository contains the Compiler Design laboratory experiments implemented using **FLEX, BISON, YACC, and C**.

## List of Experiments

| No. | Experiment                                       |
| --- | ------------------------------------------------ |
| 1   | Lexical Analyzer using FLEX with Symbol Table    |
| 2   | Lexical Analyzer using FLEX                      |
| 3   | Valid Arithmetic Expression using FLEX and BISON |
| 4   | Valid Variable using FLEX and BISON              |
| 5   | Valid C Control Structures using FLEX and BISON  |
| 6   | Calculator using FLEX and BISON                  |
| 7   | Three Address Code using FLEX and BISON          |
| 8   | Type Checking using FLEX and BISON               |

## Tools Used

* FLEX
* BISON
* YACC
* GCC
* C Programming Language

## Experiments

### Experiment 1 — Lexical Analyzer with Symbol Table

Develop a lexical analyzer using FLEX to recognize identifiers, constants, comments and operators in a C program and create a symbol table for identifiers.

### Experiment 2 — Lexical Analyzer

Implement a lexical analyzer using FLEX to recognize keywords, identifiers, numbers, operators, header files, preprocessor directives and delimiters.

### Experiment 3 — Arithmetic Expression

Recognize valid arithmetic expressions using the operators `+`, `-`, `*` and `/` using FLEX and BISON.

### Experiment 4 — Valid Variable

Recognize a valid variable that starts with a letter followed by any number of letters or digits using FLEX and BISON.

### Experiment 5 — C Control Structures

Recognize valid C control structure syntax such as `if-else`, `while`, `for` and `switch-case` using FLEX and BISON.

### Experiment 6 — Calculator

Implement a simple calculator using FLEX and BISON to evaluate arithmetic expressions using operator precedence.

### Experiment 7 — Three Address Code

Generate Three Address Code (TAC) for simple arithmetic expressions using FLEX and BISON with temporary variables such as `t1`, `t2`, etc.

### Experiment 8 — Type Checking

Implement type checking for simple declarations and expressions using FLEX and BISON with a symbol table to identify type mismatches and undefined variables.

## Repository Structure

```text
CD-LAB/
│
├── README.md
│
├── EXP-01-Lexical-Analyzer-Symbol-Table/
│   ├── README.md
│   ├── symtab.l
│   └── input.c
│
├── EXP-02-Lexical-Analyzer/
│   ├── README.md
│   ├── lexer.l
│   └── iplex.c
│
├── EXP-03-Arithmetic-Expression/
│   ├── README.md
│   ├── art_expr.l
│   └── art_expr.y
│
├── EXP-04-Valid-Variable/
│   ├── README.md
│   ├── valvar.l
│   └── valvar.y
│
├── EXP-05-Control-Structure/
│   ├── README.md
│   ├── control.l
│   └── control.y
│
├── EXP-06-Calculator/
│   ├── README.md
│   ├── cal.l
│   └── cal.y
│
├── EXP-07-Three-Address-Code/
│   ├── README.md
│   ├── tac.l
│   └── tac.y
│
└── EXP-08-Type-Checking/
    ├── README.md
    ├── typecheck.l
    └── typecheck.y
```

## Common Compilation Commands

### FLEX only

```bash
flex filename.l
gcc lex.yy.c -o output -lfl
./output
```

### FLEX + BISON

```bash
flex filename.l
bison -d filename.y
gcc lex.yy.c filename.tab.c -o output -lfl
./output
```

## Practical Record Format

Each experiment contains a `README.md` with the following sections:

* **Aim**
* **Algorithm**
* **Program**
* **Commands**
* **Input**
* **Output**
* **Result**

---

## Deva Shri M H
## 24CS0180

**Compiler Design Laboratory — Experiments 1 to 8**
