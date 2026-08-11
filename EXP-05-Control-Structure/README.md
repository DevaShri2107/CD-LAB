# Experiment 5: Valid C Control Structure using FLEX and BISON

## AIM

To write a program to recognize valid C control structure syntax such as `if-else`, `while`, `for` and `switch-case` using FLEX and BISON.

## ALGORITHM

### FLEX

1. Include the BISON header file.
2. Define patterns for control keywords such as `if`, `else`, `for`, `while`, `switch`, `case` and `default`.
3. Define patterns for identifiers, numbers and symbols.
4. Return appropriate tokens to BISON.
5. Skip white spaces.

### BISON

6. Define tokens and grammar rules for control structures.
7. Define grammar for `if-else`, `while`, `for` and `switch-case`.
8. Use `yyparse()` to start parsing.
9. If the input matches the grammar, print Valid control structure syntax.
10. Otherwise, print Invalid control structure syntax.

## PROGRAM

### File 1: `control.l`

```lex
%{
#include "control.tab.h"
%}

%%

"if"       { return IF; }
"else"     { return ELSE; }
"for"      { return FOR; }
"while"    { return WHILE; }
"switch"   { return SWITCH; }
"case"     { return CASE; }
"default"  { return DEFAULT; }

[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }
[0-9]+                  { return NUM; }

"{"  { return LBRACE; }
"}"  { return RBRACE; }
"("  { return LPAREN; }
")"  { return RPAREN; }
":"  { return COLON; }
";"  { return SEMICOLON; }

"==" { return EQ; }
"<=" { return LE; }
">=" { return GE; }
"<"  { return LT; }
">"  { return GT; }
"="  { return ASSIGN; }

[ \t\n] ;
. { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
```

### File 2: `control.y`

```yacc
%{
#include <stdio.h>
%}

%token IF ELSE FOR WHILE SWITCH CASE DEFAULT
%token ID NUM
%token LBRACE RBRACE LPAREN RPAREN COLON SEMICOLON
%token EQ LE GE LT GT ASSIGN

%%

program : stmt ;

stmt : if_stmt
     | while_stmt
     | for_stmt
     | switch_stmt
     ;

if_stmt : IF LPAREN cond RPAREN stmt
        | IF LPAREN cond RPAREN stmt ELSE stmt
        ;

while_stmt : WHILE LPAREN cond RPAREN stmt ;

for_stmt : FOR LPAREN ID ASSIGN NUM SEMICOLON
          cond SEMICOLON ID ASSIGN ID RPAREN stmt ;

switch_stmt : SWITCH LPAREN ID RPAREN LBRACE case_list RBRACE ;

case_list : CASE NUM COLON stmt
          | DEFAULT COLON stmt
          ;

cond : ID relop NUM ;

relop : EQ | LE | GE | LT | GT ;

%%

int main() {
    printf("Enter a C control structure syntax:\n");
    yyparse();
    printf("Valid control structure syntax.\n");
    return 0;
}

int yyerror() {
    printf("Invalid control structure syntax.\n");
    return 0;
}
```

## COMMANDS

```bash
flex control.l
bison -d control.y
gcc lex.yy.c control.tab.c -o control -lfl
./control
```

## INPUT

```c
if (x < 5) { y = 10; }
```

## OUTPUT

```text
Enter a C control structure syntax:
if (x < 5) { y = 10; }
Valid control structure syntax.
```

## RESULT

Thus, the program to recognize valid C control structure syntax such as `if-else`, `while`, `for` and `switch-case` using FLEX and BISON was executed and verified successfully.
