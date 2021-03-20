/**
 * CS 240 Shell
 */

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>
#include <stdbool.h>

#include <readline/readline.h>
#include <readline/history.h>

#include "command.h"
#include "joblist.h"

/** Shell name: replace with something more creative. */
static char const * const NAME = "shell";

/** Command prompt: feel free to change. */
static char const * const PROMPT = "-> ";

/** Path to file to use for command history. */
static char const * const HIST_FILE =  ".shell_history";

/**
 * Exit (terminate) the shell.
 *
 * Arguments:
 * status - exit status code (0 for OK, nonzero for error)
 */
void shell_builtin_exit(int status) {
  // Save command history.
  write_history(HIST_FILE);
  
  // Exit this process with the given status.
  exit(status);
}

/**
 * If command is a builtin feature of the shell, do it directly.
 *
 * Arguments:
 * jobs    - job list (used only in Part 2+)
 * command - command to run
 *
 * Return:
 * 1 if the command is built in
 * 0 if the command is not built in
 */
int shell_run_builtin(JobList* jobs, char** command) {
  if (!strncmp(command[0], "exit", 5) && command[1] == NULL) {
    // Command is "exit".
    // Free the command array.
    command_free(command);
    // Run the builtin exit function.
    shell_builtin_exit(0);
    // This was a builtin command.
    return 1;
  } 
  else if (!strncmp(command[0], "help", 5)){
    // Command is "help".
    // Free the command array.
    // Run the builtin exit function.
    if (!strncmp(command[1], "help", 5)){
      printf("help: help [-s] [pattern ...\nDisplay helpful information about builtin commands\n");
    }
    else if (!strncmp(command[1], "cd", 3)){
      printf("cd: cd [-L|-P] [dir]\nChange the shell working directory.\n");
    }
    else if (!strncmp(command[1], "exit", 5)){
      printf("exit: exit [n]\nExit the shell with a status of N.\n");
    }
    command_free(command);
    // This was a builtin command.
    return 1;
  }
  else if (!strncmp(command[0], "cd", 3)) {
    // Command is "cd"
    // Get the given directory
    if (command[1] != NULL){
      char* dir = command[1];
      chdir(getenv(dir));
    }
    else {
      chdir(getenv("HOME"));
    }
    command_free(command);
    return 1;
  }
    else {
    // FIXME: replace the body of this `else` by implementing the
    // remaining builtin commands.
    assert(false && "Unimplemented");
    return 0;
  }
}

/**
 * Fork and exec the requested executable command in the foreground (Part 1)
 * or background (Part 2).
 *
 * Exit the shell in error if an error occurs while forking (Part 1).
 *
 * Arguments:
 * jobs       - job list for saving or deleting jobs (Part 2+)
 * command    - command array of executable and arguments
 * foreground - indicates foreground (1) vs. background (0)
 */
void shell_run_executable(JobList* jobs, char** command, int foreground) {

  JobList* list;
  pid_t pid = fork();

  if (pid == 0) {
    char* exe = command[0];
    execvp(exe, command);
    printf("execvp() has returned; an error has occurred");
    exit(0);
  }
  else if (pid < 0) {
    // Fork system call failed.
  perror("fork");
  exit(-1);
  }
  waitpid(pid, NULL, 0);
  return;
}

/** Fake stand-in for starter code. */
void shell_run_fake(char** command) {
  command_print(command);
  printf("\n");
  command_free(command);
}

/**
 * Run the given builtin or executable command.
 *
 * Arguments:
 * jobs       - job list for savining or deleting jobs (Part 2+)
 * command    - command array of executable and arguments
 * foreground - indicates foreground (1/true) vs. background (0/false).
 */
void shell_run_command(JobList* jobs, char** command, int foreground) {
  // shell_run_builtin(jobs, command); // FIXME: replace this line (and delete shell_run_fake).
  shell_run_executable(jobs, command, foreground);
}

/**
 * Main shell loop: read, parse, execute.
 *
 * Arguments:
 * argc - number of command-line arguments for the shell.
 * argv - array of command-line arguments for the shell.
 *
 * Return:
 * exit status - 0 for normal, non-zero for error.
 */
int main(int argc, char** argv) {
  // Initialize a job list (used only in Part 2+).
  JobList* jobs = joblist_create();
  
  // Load history if available.
  using_history();
  read_history(HIST_FILE);

  // Shell loop
  while (true) {
    // Read a command line. Supports command history, emacs key
    // bindings, etc. Calls malloc internally.
    char* line = readline(PROMPT);

    if (line == NULL) {
      // Readline returns NULL if it receives EOF (end of file, typed Control-D).
      // Treat this the same as the builtin exit command.
      shell_builtin_exit(0);
    }

    // Add line to command history.
    add_history(line);

    // Parse command line: this is Pointer Potions.
    // It allocates a command array.
    int fg = -1;
    char** command = command_parse(line, &fg);
    
    if (command == NULL) {
      // Command syntax is invalid. Complain.
      printf("Invalid command syntax: %s\n", line);
    } else {
      // Command syntax is valid. Try to run the command.
      shell_run_command(jobs, command, fg);
    }
    
    // Free command line.
    free(line);
  }
}

