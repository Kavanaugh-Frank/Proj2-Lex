CC = g++

LEX = flex

SCANNER = scanner

LEX_SRC = scanner.l

LEX_GEN = lex.yy.c

all: $(SCANNER)

$(SCANNER): $(LEX_SRC)
	$(LEX) $(LEX_SRC)
	$(CC) $(LEX_GEN) -o $(SCANNER)

clean:
	rm -f $(SCANNER) $(LEX_GEN) tokens.txt PlagiarismReport.txt

.PHONY: all clean