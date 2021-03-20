CC = gcc
CFLAGS = -Wall -Werror -g -std=c99 -O

connectfour: connectfour.o checkcol.o
	$(CC) $(CFLAGS) -o connectfour connectfour.o checkcol.o
connectfour.o: connectfour.c
	$(CC) $(CFLAGS) -c connectfour.c
checkcol.o: checkcol.s
	$(CC) $(CFLAGS) -c checkcol.s

clean:
	rm -f *.o connectfour
