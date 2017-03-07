%{
#include <y.tab.h>
#include <cstdio>
%}

d [0-9]
w [a-zA-Z_]
W [ \r\n\t]

%%

if                          { return IF; }
else                        { return ELSE; }
var                         { return VAR; }
const                       { return CONST; }
let                         { return LET; }

{w}({w}|{d})*               { yylval.var = _strdup(yytext); return IDENT; }
(({d}+(\.{d}*)?)|(\.{d}+))  { yylval.num = atof(yytext); return NUMBER; }

"="                         { return '='; }
"+"                         { return '+'; }
"-"                         { return '-'; }
"*"                         { return '*'; }
"/"                         { return '/'; }
"<"                         { return '<'; }
">"                         { return '>'; }
"("                         { return '('; }
")"                         { return ')'; }
"{"                         { return '{'; }
"}"                         { return '}'; }
";"                         { return ';'; }

{W}                   /* skip whitespace */

.                           { 
                                fprintf(stderr, "invalid character '%c'\n", *yytext);
                                exit(0);
                            }
%%

int yywrap() {
    return 1;
}
