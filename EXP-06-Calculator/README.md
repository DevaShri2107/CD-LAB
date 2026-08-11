# Experiment 6: Calculator using FLEX and BISON

## AIM

To write a program to implement a calculator using FLEX and BISON.

## ALGORITHM

1. Start the program.
2. Define a regular expression for numbers in the FLEX file.
3. Return the `NUM` token and store the numeric value in `yylval`.
4. Define grammar rules in BISON for `+`, `-`, `*` and `/`.
5. Define operator precedence using `%left`.
6. Evaluate the arithmetic expression.
7. Display an error for an invalid expression.
8. Give the input and verify the output.
9. Stop.

## PROGRAM

### File 1: `cal.l`

```lex
%{
#include "cal.tab.h"
%}

DIGIT [0-9]+
%option noyywrap

%%

{DIGIT}    { yylval = atof(yytext); return NUM; }
\n|.       { return yytext[0]; }

%%
```

### File 2: `cal.y`

```yacc
%{
#include <stdio.h>
#define YYSTYPE double
%}

%token NUM

%left '+' '-'
%left '*' '/'

%%

statement : E { printf("Answer: %g\n", $1); }
          ;

E : E '+' E { $$ = $1 + $3; }
  | E '-' E { $$ = $1 - $3; }
  | E '*' E { $$ = $1 * $3; }
  | E '/' E { $$ = $1 / $3; }
  | NUM
  ;

%%

int main() {
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Invalid expression\n");
    return 0;
}
```

## COMMANDS

```bash
flex cal.l
bison -d cal.y
gcc lex.yy.c cal.tab.c -o calc -lfl
./calc
```

## INPUT

```text
2+2
```

## OUTPUT

```text
Enter the expression:
2+2
Answer: 4
```

## ADDITIONAL INPUT

```text
10+5*2
```

## OUTPUT

```text
Enter the expression:
10+5*2
Answer: 20
```

## RESULT

Thus, the program for implementing a calculator using FLEX and BISON was executed and verified successfully.
