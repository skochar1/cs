# This is a Makefile with recipes to compile the various parts of this
# assignment.

#### Variables ####

# C compiler
CC = gcc

# Flags to pass to C compiler
CFLAGS = -Wall -Wno-unused-function -g --std=c99

##### Recipes ####
all: command_test

# Command parser
command.o: command.c command.h
	$(CC) $(CFLAGS) -c $<

command_test: command_test.c command.o
	$(CC) $(CFLAGS) -o $@ $< command.o

# Clean up executables
clean:
	rm -f *.o command_test
	rm -rf *.dSYM
