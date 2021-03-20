SRCS = $(shell find -name '*.c')
BINS = $(SRCS:%.c=%)
CC = gcc
CFLAGS = -Wall -g -std=c99

all: $(BINS)

%:	%.c
	$(CC) $(CFLAGS) $@.c -o $@

clean:
	rm -f $(BINS)
