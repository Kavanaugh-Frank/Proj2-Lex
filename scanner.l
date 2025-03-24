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

#define NODE 1
#define ROOT_NODE 2

%}

%%
[ \t\n]+                        { /* Ignore whitespace */ }
{/* "buildnode"[ \t\n]*"{"[ \t\n]*"name"[ \t\n]*=[ \t\n]*\"([a-zA-Z0-9_-]+)\"[ \t\n]*";"[ \t\n]*"weight"[ \t\n]*=[ \t\n]*([0-9]+)[ \t\n]*";"[ \t\n]*"}"[ \t\n]*";"  {
    char name[100];
    int weight;
    sscanf(yytext, "buildnode { name = \"%99[a-zA-Z0-9_-]\" ; weight = %d ; } ;", name, &weight);
    fprintf(yyout, "%03d Name: %s, Weight: %d\n", ROOT_NODE, name, weight);
}
"buildnode"[ \t\n]*"{"[ \t\n]*"name"[ \t\n]*=[ \t\n]*\"([a-zA-Z0-9_-]+)\"[ \t\n]*";"[ \t\n]*"weight"[ \t\n]*=[ \t\n]*([0-9]+)[ \t\n]*";"[ \t\n]*"isachildof"[ \t\n]*=[ \t\n]*\"([a-zA-Z0-9_-]+)\"[ \t\n]*";"[ \t\n]*"}"[ \t\n]*";"  {
    char name[100], parent[100];
    int weight;
    sscanf(yytext, "buildnode { name = \"%99[a-zA-Z0-9_-]\" ; weight = %d ; isachildof = \"%99[a-zA-Z0-9_-]\" ; } ;", name, &weight, parent);
    fprintf(yyout, "%03d Name: %s, Weight: %d, Parent: %s\n", NODE, name, weight, parent); }
*/}
.   {/* Ignore the rest */}


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
