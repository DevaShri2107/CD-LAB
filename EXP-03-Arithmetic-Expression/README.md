# Experiment 3: Valid Arithmetic Expression using FLEX and BISON

## AIM

To write a program to recognize a valid arithmetic expression using the operators `+`, `-`, `*` and `/` using FLEX and BISON.

## ALGORITHM

### FLEX

1. Include the required header files.
2. Define patterns for identifiers and digits.
3. Ignore spaces and tabs.
4. Return the recognized tokens to BISON.
5. Use `yywrap()` to indicate the end of input.

### BISON

6. Define the tokens `ID` and `DIG`.
7. Define the precedence of `+`, `-`, `*` and `/`.
8. Define grammar rules for arithmetic expressions.
9. Call `yyparse()` to parse the input.
10. Print Valid Expression if the input matches; otherwise print Invalid Expression.

## PROGRAM

### File 1: `art_expr.l`

```lex
%{
#include <stdio.h>
#include "art_expr.tab.h"
%}

%%

[a-zA-Z][a-zA-Z0-9]*   { return ID; }
[0-9]+                 { return DIG; }
[ \t]+                 ;
.                      { return yytext[0]; }
\n                     { return 0; }

%%

int yywrap() {
    return 1;
}
```

### File 2: `art_expr.y`

```yacc
%{
#include <stdio.h>
%}

%token ID DIG

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

stmt : expn ;

expn : expn '+' expn
     | expn '-' expn
     | expn '*' expn
     | expn '/' expn
     | '-' expn %prec UMINUS
     | '(' expn ')'
     | DIG
     | ID
     ;

%%

int main() {
    printf("Enter the Expression\n");
    yyparse();
    printf("Valid Expression\n");
    return 0;
}

int yyerror() {
    printf("Invalid Expression\n");
    return 0;
}
```

## COMMANDS

```bash
flex art_expr.l
bison -d art_expr.y
gcc lex.yy.c art_expr.tab.c -o art_expr -lfl
./art_expr
```

## INPUT

```text
a+b*c-d/e
```

## OUTPUT

```text
Enter the Expression
a+b*c-d/e
Valid Expression
```

### Invalid Input

```text
a=b
```

### Invalid Output

```text
Enter the Expression
a=b
Invalid Expression
```

## RESULT

Thus, the program to recognize a valid arithmetic expression using `+`, `-`, `*` and `/` using FLEX and BISON was executed and verified successfully.
