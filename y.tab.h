#pragma once

enum yytokentype {
	REGEX_START = 258,
	REGEX_END,
	REGEX_BODY,
	REGEX_FLAG,
	CONST,
	IDENT,
};

union YYSTYPE {
	char *ident;
	char *regexStart;
	char *regexEnd;
	char *regexBody;
	char *regexFlag;
};

extern YYSTYPE yylval;
