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
