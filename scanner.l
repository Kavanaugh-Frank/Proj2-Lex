/*Created by Kavanaugh Frank and Alec Martell for Project 2*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

extern FILE *yyout;

void yyerror(const char *s,...);
void yywarn(const char *s,...);

extern "C" int yywrap(void) {
    return 1;
}


%}

ALPHANUMERIC_LITERAL \"[a-zA-Z0-9_-]+\"
ALPHANUMERIC_VARIABLE [a-zA-Z0-9_-]+
NUMERIC [0-9]+

%{
#define BUILDNODE "buildnode"
#define NAME "name"
#define WEIGHT "weight"
#define ISACHILDOF "isachildof"
#define EQUALS "="
#define ALPHANUMERIC_LITERAL "ALPHANUMERIC_LITERAL"
#define ALPHANUMERIC_VARIABLE "ALPHANUMERIC_VARIABLE"
#define NUMERIC "NUMERIC"
#define OPEN_BRACE "{"
#define CLOSE_BRACE "}"
#define SEMI_COLON ";"
#define PLUS "+"
#define FOR_LOOP "for"
#define OPEN_BRACKET "["
#define CLOSE_BRACKET "]"
#define COLON ":"
#define IN "in"
#define COMMA ","

%}

%%
[ \t\n]+                    { /*Ignore*/ }
"buildnode"                 { fprintf(yyout, "%s\n", BUILDNODE); }
"name"                      { fprintf(yyout, "%s\n", NAME); }
"weight"                    { fprintf(yyout, "%s\n", WEIGHT); }
"isachildof"                { fprintf(yyout, "%s\n", ISACHILDOF); }
"for"                       { fprintf(yyout, "%s\n", FOR_LOOP); }
"in"                        { fprintf(yyout, "%s\n", IN);}
{NUMERIC}                   { fprintf(yyout, "%s: %s\n", NUMERIC, yytext); }
{ALPHANUMERIC_VARIABLE}     { fprintf(yyout, "%s: %s\n", ALPHANUMERIC_VARIABLE, yytext); }
{ALPHANUMERIC_LITERAL}      { fprintf(yyout, "%s: %s\n", ALPHANUMERIC_LITERAL, yytext); }
"="                         { fprintf(yyout, "%s\n", EQUALS); }
"{"                         { fprintf(yyout, "%s\n", OPEN_BRACE); }
"}"                         { fprintf(yyout, "%s\n", CLOSE_BRACE); }
"["                         { fprintf(yyout, "%s\n", OPEN_BRACKET);}
"]"                         { fprintf(yyout, "%s\n", CLOSE_BRACKET);}
":"                         { fprintf(yyout, "%s\n", COLON);}
";"                         { fprintf(yyout, "%s\n", SEMI_COLON); }
"+"                         { fprintf(yyout, "%s\n", PLUS); }
","                         { fprintf(yyout, "%s\n", COMMA);}
.                           {/* Ignore the rest */}


%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <source_file>\n", argv[0]);
        return EXIT_FAILURE;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        return EXIT_FAILURE;
    }

    yyin = file;
    yyout = stdout;  // Set yyout to stdout to output to the terminal
    yylex();
    fclose(file);

    return 0;
}
