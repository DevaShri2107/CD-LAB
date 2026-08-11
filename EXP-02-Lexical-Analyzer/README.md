# Experiment 2: Lexical Analyzer using FLEX

## AIM

To implement a lexical analyzer using FLEX to identify keywords, identifiers, numbers, operators, preprocessor directives, header files and delimiters from a C program.

## ALGORITHM

1. Include the required header file.
2. Define patterns for C keywords and other tokens.
3. Create the definitions, rules and C code sections of FLEX.
4. Match keywords, identifiers, numbers, operators, delimiters, preprocessor directives and header files.
5. Print the type of each recognized token.
6. Compile the FLEX program using FLEX and GCC.
7. Run the executable with a C source file.
8. Display the recognized tokens.
9. Stop.

## PROGRAM

File: `lexer.l`

```lex
%{
#include <stdio.h>
%}

KEYWORD int|float|char|double|void|for|while|if|else|return|struct|switch|case|break|do

%%

"#include"                   { printf("Preprocessor : %s\n", yytext); }
"<"[a-zA-Z.]+">"             { printf("Header File : %s\n", yytext); }
{KEYWORD}                    { printf("Keyword : %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*       { printf("Identifier : %s\n", yytext); }
[0-9]+                       { printf("Number : %s\n", yytext); }
"=="|"<="|">="               { printf("Operator : %s\n", yytext); }
"+"|"-"|"*"|"/"|"="|"<"|">" { printf("Operator : %s\n", yytext); }
[(){};,]                     { printf("Delimiter : %s\n", yytext); }
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
    printf("\nEnd of file\n");

    fclose(yyin);
    return 0;
}
```

## COMMANDS

```bash
flex lexer.l
gcc lex.yy.c -o lexer -lfl
./lexer iplex.c
```

## INPUT

File: `iplex.c`

```c
#include<stdio.h>

void main()
{
    int x;
    x = 10;
}
```

## OUTPUT

```text
Preprocessor : #include
Header File : <stdio.h>
Keyword : void
Identifier : main
Delimiter : (
Delimiter : )
Delimiter : {
Keyword : int
Identifier : x
Delimiter : ;
Identifier : x
Operator : =
Number : 10
Delimiter : ;
Delimiter : }

End of file
```

## RESULT

Thus, the FLEX program for implementing a lexical analyzer and identifying various C language tokens was executed and verified successfully.
