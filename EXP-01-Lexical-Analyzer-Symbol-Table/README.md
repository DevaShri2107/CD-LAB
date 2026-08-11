# Experiment 1: Lexical Analyzer with Symbol Table

## AIM

To develop a lexical analyzer using FLEX to recognize identifiers, constants, comments and operators in a C program and create a symbol table for identifiers.

## ALGORITHM

1. Include the required header files.
2. Define regular expressions for identifiers and constants.
3. Define rules for comments, identifiers, constants and operators.
4. When an identifier is found, insert it into the symbol table if it is not already present.
5. Print the recognized tokens.
6. Open the input C file and call `yylex()`.
7. Display the symbol table.
8. Stop.

## PROGRAM

File: `symtab.l`

```lex
%{
#include <stdio.h>
#include <string.h>

struct symtab {
    char name[30];
} symtab[100];

int sc = 0;

int lookup(char *s) {
    for (int i = 0; i < sc; i++)
        if (strcmp(symtab[i].name, s) == 0)
            return i;
    return -1;
}

void insert(char *s) {
    if (lookup(s) == -1)
        strcpy(symtab[sc++].name, s);
}
%}

DIGIT [0-9]
ID [a-zA-Z_][a-zA-Z0-9_]*

%%

"//".*                       { printf("Comment : %s\n", yytext); }
"/*"([^*]|\*+[^*/])*\*+"/"  { printf("Comment : %s\n", yytext); }
{ID}                         { insert(yytext); printf("Identifier : %s\n", yytext); }
{DIGIT}+                     { printf("Constant : %s\n", yytext); }
"+"|"-"|"*"|"/"|"="|"<"|">" { printf("Operator : %s\n", yytext); }
[ \t\n]                      ;
.                            ;

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");

    if (!yyin) {
        printf("Cannot open file\n");
        return 1;
    }

    yylex();

    printf("\nSYMBOL TABLE\n");
    printf("S.No\tName\n");

    for (int i = 0; i < sc; i++)
        printf("%d\t%s\n", i + 1, symtab[i].name);

    fclose(yyin);
    return 0;
}
```

## COMMANDS

```bash
flex symtab.l
gcc lex.yy.c -o symtab -lfl
./symtab input.c
```

## INPUT

File: `input.c`

```c
int a = 10; // sum variable
b = a + 5;
```

## OUTPUT

```text
Identifier : int
Identifier : a
Operator : =
Constant : 10
Comment : // sum variable
Identifier : b
Identifier : a
Operator : +
Constant : 5

SYMBOL TABLE
S.No    Name
1       int
2       a
3       b
```

## RESULT

Thus, the FLEX program to recognize identifiers, constants, comments and operators and to create a symbol table was executed and verified successfully.
