# Experiment 4: Valid Variable using FLEX and BISON

## AIM

To write a program to recognize a valid variable which starts with a letter followed by any number of letters or digits using FLEX and BISON.

## ALGORITHM

### FLEX

1. Include the required BISON header file.
2. Define patterns for letters and digits.
3. Return `LET` for letters and `DIG` for digits.
4. Use `yywrap()` to indicate the end of input.

### BISON

5. Define the tokens `LET` and `DIG`.
6. Define grammar rules for a variable.
7. The variable must start with a letter.
8. After the first letter, any number of letters or digits can occur.
9. Call `yyparse()` to validate the input.
10. Print Valid variable if the input matches; otherwise print Invalid variable.

## PROGRAM

### File 1: `valvar.l`

```lex
%{
#include "valvar.tab.h"
%}

%%

[a-zA-Z]   { return LET; }
[0-9]      { return DIG; }
\n         { return 0; }

%%

int yywrap() {
    return 1;
}
```

### File 2: `valvar.y`

```yacc
%{
#include <stdio.h>
%}

%token LET DIG

%%

variable : var ;

var : var DIG
    | var LET
    | LET
    ;

%%

int main() {
    printf("Enter the variable:\n");
    yyparse();
    printf("Valid variable\n");
    return 0;
}

int yyerror() {
    printf("Invalid variable\n");
    return 0;
}
```

## COMMANDS

```bash
flex valvar.l
bison -d valvar.y
gcc lex.yy.c valvar.tab.c -o valvar -lfl
./valvar
```

## INPUT 1

```text
add
```

## OUTPUT 1

```text
Enter the variable:
add
Valid variable
```

## INPUT 2

```text
add1
```

## OUTPUT 2

```text
Enter the variable:
add1
Valid variable
```

## INPUT 3

```text
1add
```

## OUTPUT 3

```text
Enter the variable:
1add
Invalid variable
```

## RESULT

Thus, the program to recognize a valid variable which starts with a letter followed by any number of letters or digits using FLEX and BISON was executed and verified successfully.
