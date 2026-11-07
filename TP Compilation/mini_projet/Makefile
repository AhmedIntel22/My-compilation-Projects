CC = gcc
CFLAGS = -Wall -g
FLEX = flex
BISON = bison
LIBS = -lm

all: interpreteur

interpreteur: main.c interpreteur.tab.c lex.yy.c
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

interpreteur.tab.c interpreteur.tab.h: interpreteur.y
	$(BISON) -d interpreteur.y

lex.yy.c: lex.l interpreteur.tab.h
	$(FLEX) lex.l

clean:
	rm -f interpreteur interpreteur.tab.c interpreteur.tab.h lex.yy.c

run: interpreteur
	./interpreteur
