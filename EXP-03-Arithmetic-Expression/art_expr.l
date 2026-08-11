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
