# Experiment 7: Three Address Code using FLEX and BISON

## AIM

To write a program using FLEX and BISON to generate Three Address Code (TAC) for a simple arithmetic expression.

## ALGORITHM

### FLEX

1. Include the required header file.
2. Define patterns for identifiers and numbers.
3. Return appropriate tokens to BISON.
4. Ignore spaces and tabs.

### BISON

5. Define tokens and operator precedence.
6. Parse the arithmetic expression using grammar rules.
7. Generate temporary variables such as `t1`, `t2`, etc.
8. Generate three-address code during parsing.
9. Display the generated TAC.
10. Stop.

## PROGRAM

### File 1: `tac.l`

```lex id="q1c4xr"
%{
#include "tac.tab.h"
#include <string.h>
%}

%%

[a-zA-Z][a-zA-Z0-9]*  { yylval.str = strdup(yytext); return ID; }
[0-9]+                { yylval.str = strdup(yytext); return NUM; }
[ \t\n]+              ;
.                     { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
```

### File 2: `tac.y`

```yacc id="z5t8km"
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 1;
char temp[10];
%}

%union {
    char *str;
}

%token <str> ID NUM
%type <str> expr

%left '+' '-'
%left '*' '/'

%%

stmt : ID '=' expr {
          printf("%s = %s\n", $1, $3);
      }
      ;

expr : expr '+' expr {
          sprintf(temp, "t%d", tempCount++);
          printf("%s = %s + %s\n", temp, $1, $3);
          $$ = strdup(temp);
      }
     | expr '-' expr {
          sprintf(temp, "t%d", tempCount++);
          printf("%s = %s - %s\n", temp, $1, $3);
          $$ = strdup(temp);
      }
     | expr '*' expr {
          sprintf(temp, "t%d", tempCount++);
          printf("%s = %s * %s\n", temp, $1, $3);
          $$ = strdup(temp);
      }
     | expr '/' expr {
          sprintf(temp, "t%d", tempCount++);
          printf("%s = %s / %s\n", temp, $1, $3);
          $$ = strdup(temp);
      }
     | ID  { $$ = $1; }
     | NUM { $$ = $1; }
     ;

%%

int main() {
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}
```

## COMMANDS

```bash id="i2j8xz"
flex tac.l
bison -d tac.y
gcc tac.tab.c lex.yy.c -o tac -lfl
./tac
```

## INPUT

```text id="v4r6cx"
a = b + c * d
```

## OUTPUT

```text id="m7p3qa"
Enter the expression:
a = b + c * d
t1 = c * d
t2 = b + t1
a = t2
```

## RESULT

Thus, the program to generate Three Address Code using FLEX and BISON was executed and verified successfully.
