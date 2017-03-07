%{
#include <y.tab.h>
#include <cstdio>
%}

d [0-9]

_ill_first_char [\*\\\/\[]
_first_char [^\*\\\/\[]
_char [^\\\/\[]
_class_char [^\\\/\[\]]
_flags [gimuy]
w [a-zA-Z_]
W [ \r\n\t]

%s __NEUTRALIZED
%x __REGEX
%x __REGEX_CLASS
%x __REGEX_FLAG

%%

const						{ return CONST; }

[/]/[^/]+[^/]                   {
                                fprintf(stderr, "Syntax Error: REGEX not closed (%s). (REGEX)\n", _strdup(yytext));
                                exit(0);
                            }
[/]{_ill_first_char}        {   // throw if _RegularExpressionFirstChar is invalid
								fprintf(stderr, "Syntax Error: %s is not allowed here. (REGEX_FIRST_CHARACTER)\n", _strdup(yytext));
								exit(0);
							}
[/]/[^/]+[/]				    {   // regex start
								yylval.regexStart = _strdup(yytext);
                                BEGIN(__REGEX);
                                return REGEX_START;
                            }
<__REGEX>[[]/{_class_char}*[^\]] {
                                fprintf(stderr, "Syntax Error: REGEX Class not closed. (REGEX_CLASS)\n");
                                exit(0);
                            }
<__REGEX>[[]/{_class_char}*[\]] {
                                yylval.regexClassStart = _strdup(yytext);
                                BEGIN(__REGEX_CLASS);
                                return REGEX_CLASS_START;
                            }
<__REGEX_CLASS>{_class_char}* {
                                yylval.regexClassBody = _strdup(yytext);
                                return REGEX_CLASS_BODY;
                            }
<__REGEX_CLASS>[\]]         {
                                yylval.regexClassEnd = _strdup(yytext);
                                BEGIN(__REGEX);
                                return REGEX_CLASS_END;
                            }
<__REGEX>[\\].              {
                                yylval.regexBackSeq = _strdup(yytext);
                                return REGEX_BACKSLASH_SEQ;
                            }

<__REGEX>{_char}+			{   // _RegularExpressionBody
                                yylval.regexBody = _strdup(yytext);
                                return REGEX_BODY;
                            }

<__REGEX>[/]/{_flags}+      {   // regex end with flags
                                yylval.regexEnd = _strdup(yytext);
                                BEGIN(__REGEX_FLAG); return REGEX_END;
                            }
<__REGEX>[/]                {   // regex end without flags
                                yylval.regexEnd = _strdup(yytext);
                                BEGIN(INITIAL);
                                return REGEX_END;
                            }
<__REGEX_FLAG>{_flags}+		{   // _RegularExpressionFlags
                                yylval.regexFlag = _strdup(yytext);
                                BEGIN(INITIAL);
                                return REGEX_FLAG;
                            }


{w}+						{ yylval.ident = _strdup(yytext); return IDENT; }
[=]							{ return '='; }
[;]                         { return ';'; }

{W}

.                           {
                                fprintf(stderr, "invalid character '%c'\n", *yytext);
                                exit(0);
                            }
%%

int yywrap() {
    return 1;
}
