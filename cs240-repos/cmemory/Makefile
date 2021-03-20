# This is a Makefile with recipes to compile the practice programming
# parts of this lab.

#### Variables ####

#### Variables ####
EXAMPLES = main0 main1 main2 main3 main4 main5 main6 main7 main8 main9 mystery0 mystery1
BUGS = fibloop fibloop2 matvec search strings strings2 strings3
EXECUTABLES = $(EXAMPLES) $(BUGS) practice

# C compiler
CC = gcc

# Flags to pass to C compiler
CFLAGS = -Wall -g --std=c99

##### Recipes ####
all: predictions practice bugs

# Output prediction mysteries
predictions: $(EXAMPLES)
%.o: %.c
	$(CC) $(CFLAGS) -c $<
mystery%: mystery%.o hexdump.o
	$(CC) $(CFLAGS) -o $@ $< hexdump.o
main%: main%.o hexdump.o
	$(CC) $(CFLAGS) -o $@ $< hexdump.o

# Debugging practice
bugs: $(BUGS)
%: %.o
	$(CC) $(CFLAGS) -o $@ $*.o

# Pointer programming
practice: practice.c
	$(CC) $(CFLAGS) -o practice practice.c

# Clean up executables
clean:
	rm -f $(EXECUTABLES)
	rm -rf *.o *.dSYM
