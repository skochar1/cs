/**
 * Write tests for your command parsing library here.
 * 
 * If you wish to call helper functions from command.c besides
 * command_parse, command_free, and command_print, you must add their
 * headers to command.h
 */
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "command.h"



// Sample command lines
static char* COMMAND_LINES[] = {
  "Hello world!  Please parse    me.",
  "Hi this is a test&", // should come out invalid
  "Hi this is a &test", // should come out invalid
  "&this is a test", // should come out invalid
  "this is a test & lol", // should come out invalid
  "uh& &oh", // should come out invalid
  "   emacs&   ", // background and valid
  "emacs&", // background and valid
  "cd pointers", // foreground and valid
  "ls -l cs240-pointers", // foreground and valid
  "ls       -l cs240-pointers",  // foreground and valid
  "this     is     a    test", // foreground and valid
  " ", // foreground and valid
  "            ", // foreground and valid
  "&", // background and valid
  "   &    ",
  "emacs &",
  NULL // Keep NULL to mark the end.
};

// Sample command arrays to test command_print and command_show.
static char* LS[] = { "ls", "-A", "filename.txt", NULL };
static char* EMACS[] = { "emacs", "command.c", "command.h", "Makefile", NULL };

// All sample command arrays
static char** COMMAND_ARRAYS[] = {
  LS,
  EMACS,
  NULL
};

// How long before we assume an infinite loop?
#define TIMEOUT 10
// Signal handler to run when timeout triggers.
void timeout() {
  fprintf(stderr, "[!] TIMEOUT\n");
  exit(SIGALRM);
}

/**
 * Test all command_ functions on the give command line.
 * line: command line input
 * alloc: true to do tests in the heap, false otherwise.
 */
void test_all(char* line, int alloc) {
  int foreground;
  char** c;
  fprintf(stderr, "# Parsing: \"%s\"\n", line);
  if (alloc) {
    // Allocate a fresh copy of line in the heap if requested.  This
    // helps valgrind detect more bounds errors compared using
    // statically allocated line directly.
    char* mline = (char*)malloc(sizeof(char)*(strlen(line)+1));
    strcpy(mline, line);
    line = mline;
  }
  // Parse the command line to a command array.
  c = command_parse(line, &foreground);
  fflush(stdout);
  if (alloc) {
    // Zero all bytes of the command line to prevent "getting lucky" in
    // future broken tests.
    // Free the heap copy of the line.
    for (char* ch = line; *ch; ch++) *ch = '\0';
    free(line);
  }
  if (c) {
    // If the parser indicated a valid command, show, print, and free.
    fprintf(stderr, "# Parsed %s command:\n", (foreground ? "foreground" : "background"));
    command_show(c);
    fflush(stdout);
    fprintf(stderr, "# As command line: \n");
    command_print(c);
    printf("\n");
    fflush(stdout);
    command_free(c);
    fflush(stdout);
    fprintf(stderr, "# Freed command array.\n");
  } else {
    // Else indicate command was invalid according to parser.
    fprintf(stderr, "# Invalid command.\n");
  }
}

/**
 * main is the top-level function that executes when the compiled
 * program is run.
 */
int main(int argc, char** argv) {

  // Set the timer.
  // signal(SIGALRM, timeout);
  // fprintf(stderr, "######## Setting timeout for %d seconds\n", TIMEOUT);
  // alarm(TIMEOUT);

  { // Print tests.
    // Count the print tests.
    int ntests;
    for (ntests = 0; COMMAND_ARRAYS[ntests]; ntests++);
    
    // Run command_print and command_show on all sample command arrays.
    fprintf(stderr, "######## Running %d print tests with heap sources\n", ntests);
    for (int i = 0; COMMAND_ARRAYS[i]; i++) {
      fprintf(stderr, "#### Test %d\n", i);
      fprintf(stderr, "# Command array %d:\n", i);
      command_show(COMMAND_ARRAYS[i]);
      fflush(stdout);
      fprintf(stderr, "# As command line: \n");
      command_print(COMMAND_ARRAYS[i]);
      printf("\n");
      fflush(stdout);
    }
  }

  { // Full tests.
    // Count the full tests.
    int ntests;
    for (ntests = 0; COMMAND_LINES[ntests]; ntests++);

    /*
    // Run tests with static lines.
    fprintf(stderr, "######## Running %d parser tests with static sources\n", ntests);
    for (int i = 0; COMMAND_LINES[i]; i++) {
      fprintf(stderr, "#### Test %d\n", i);
      test_all(COMMAND_LINES[i], 0);
    }
    */
    
    // Run tests with heap lines.
    fprintf(stderr, "######## Running %d parser tests with heap sources\n", ntests);
    for (int i = 0; COMMAND_LINES[i]; i++) {
      fprintf(stderr, "#### Test %d\n", i);
      test_all(COMMAND_LINES[i], 1);
    }
  }

  // success
  return 0;
}
