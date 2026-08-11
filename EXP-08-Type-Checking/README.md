# Experiment 8: Type Checking using FLEX and BISON

## AIM

To write a program using FLEX and BISON to implement type checking of variables in simple declarations and expressions using a symbol table.

## ALGORITHM

1. Start the program.
2. Use FLEX to recognize `int`, `float`, identifiers, numbers and operators.
3. Pass the recognized tokens to BISON.
4. In BISON, define grammar rules for declarations and assignments.
5. Insert each declared variable and its type into the symbol table.
6. Look up variable types when they are used in expressions.
7. If a variable is not declared, report an undefined variable.
8. Compare the types of the assignment variable and expression.
9. Print `No type mismatch` if the types match; otherwise print `Type mismatch`.
10. Stop.

## PROGRAM

### File 1: `typecheck.l`

```lex id="8z6gq1"
%{
#include "typecheck.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"int"                    { return INT; }
"float"                  { return FLOAT; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }
[0-9]+                   { yylval.str = strdup(yytext); return NUM; }

"="  { return '='; }
"+"  { return '+'; }
"-"  { return '-'; }
"*"  { return '*'; }
"/"  { return '/'; }
";"  { return ';'; }

[ \t\n] ;

%%

int yywrap() {
    return 1;
}
```

### File 2: `typecheck.y`

```yacc id="0cgz7n"
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct sym {
    char name[20];
    char type[10];
} table[50];

int n = 0;

void insert(char *name, char *type) {
    strcpy(table[n].name, name);
    strcpy(table[n].type, type);
    n++;
}

char *typeOf(char *name) {
    for (int i = 0; i < n; i++)
        if (strcmp(table[i].name, name) == 0)
            return table[i].type;
    return "undefined";
}
%}

%union {
    char *str;
}

%token <str> ID NUM
%token INT FLOAT
%type <str> expr

%%

program : stmts ;

stmts : stmts stmt
      | stmt
      ;

stmt : decl
     | assign
     ;

decl : INT ID ';' {
          insert($2, "int");
      }
     | FLOAT ID ';' {
          insert($2, "float");
      }
     ;

assign : ID '=' expr ';' {
    char *t = typeOf($1);

    if (strcmp(t, "undefined") == 0)
        printf("Undefined variable: %s\n", $1);
    else if (strcmp(t, $3) == 0)
        printf("No type mismatch in expression: %s = ...\n", $1);
    else
        printf("Type mismatch in assignment to %s\n", $1);
}
;

expr : ID {
          $$ = typeOf($1);
          if (strcmp($$, "undefined") == 0)
              printf("Undefined variable: %s\n", $1);
      }
     | NUM {
          $$ = "int";
      }
     | expr '+' expr {
          $$ = (strcmp($1, $3) == 0) ? $1 : "mismatch";
      }
     | expr '-' expr {
          $$ = (strcmp($1, $3) == 0) ? $1 : "mismatch";
      }
     | expr '*' expr {
          $$ = (strcmp($1, $3) == 0) ? $1 : "mismatch";
      }
     | expr '/' expr {
          $$ = (strcmp($1, $3) == 0) ? $1 : "mismatch";
      }
     ;

%%

int main() {
    printf("Enter declarations and expressions:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Syntax Error: %s\n", s);
    return 0;
}
```

## COMMANDS

```bash
flex typecheck.l
bison -d typecheck.y
gcc lex.yy.c typecheck.tab.c -o typecheck -lfl
./typecheck
```

## INPUT 1 — Valid Type

```text
int a;
int b;
int c;
a = b * c;
```

## OUTPUT 1

```text
Enter declarations and expressions:
No type mismatch in expression: a = ...
```

## INPUT 2 — Type Mismatch

```text
int a;
float b;
int c;
a = b + c;
```

## OUTPUT 2

```text
Enter declarations and expressions:
Type mismatch in assignment to a
```

## INPUT 3 — Undefined Variable

```text
int a;
a = b + 1;
```

## OUTPUT 3

```text
Enter declarations and expressions:
Undefined variable: b
Type mismatch in assignment to a
```

## RESULT

Thus, the FLEX and BISON program for type checking was successfully implemented. The program builds a symbol table from declarations and checks type consistency in assignment expressions.
