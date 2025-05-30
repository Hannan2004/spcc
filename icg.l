%{
#include "icg.tab.h"
#include <string.h>
%}

%%

[a-zA-Z_][a-zA-Z0-9_]*   { yylval.str = strdup(yytext); return ID; }
[0-9]+                   { yylval.str = strdup(yytext); return NUM; }
[ \t]+                   ;
\n                       ;

";"                      { return ';'; }
"="                      { return '='; }
"+"                      { return '+'; }
"-"                      { return '-'; }
"*"                      { return '*'; }
"/"                      { return '/'; }

.                        ;

%%

int yywrap() { return 1; }
