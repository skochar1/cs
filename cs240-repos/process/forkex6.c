#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int counter = 1;

int main() {
  pid_t pid = fork();
  if (pid == 0) {
	counter--;  
	exit(0);
  } else {
	waitpid(pid, NULL, 0); 
	printf("counter = %d\n", ++counter);
  }
  exit(0);
}
