#pragma once

enum yytokentype {
	REGEX_START = 258,
	REGEX_END,
	REGEX_BODY,
	REGEX_CLASS_START,
	REGEX_CLASS_BODY,
	REGEX_CLASS_END,
	REGEX_BACKSLASH_SEQ,
	REGEX_FLAG,
	CONST,
	IDENT,
};

union YYSTYPE {
	char *ident;
	char *regexStart;
	char *regexEnd;
	char *regexClassStart;
	char *regexClassBody;
	char *regexClassEnd;
	char *regexBackSeq;
	char *regexBody;
	char *regexFlag;
};

extern YYSTYPE yylval;
