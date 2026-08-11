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
