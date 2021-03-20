#
# Makefile that builds btest and other helper programs
# 
CC = gcc
# Disable all optimizations, since newer GCCs exploit undefined
# overflow more aggressively.
CFLAGS = -O0 -g
LIBS = -lm
OBJS = btest.o decl.o tests.o

all: btest fshow ishow

%.o: %.c btest.h bits.h
	$(CC) $(CFLAGS) $(LIBS) -c $< -o $@

btest: bits.c $(OBJS)
	$(CC) -Wall $(CFLAGS) $(LIBS) -o btest $(OBJS) bits.c

fshow: fshow.c
	$(CC) $(CFLAGS) -o fshow fshow.c

ishow: ishow.c
	$(CC) $(CFLAGS) -o ishow ishow.c

# Forces a recompile. Used by the driver program. 
btestexplicit: clean
	make btest

clean:
	rm -rf *.o btest fshow ishow *~ *.dSYM

.PHONY: all btestexplicit clean
