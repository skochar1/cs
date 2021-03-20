#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  int x = 3;
  pid_t pid = fork();
  if (pid > 0) {
    x++;
    printf("x = %d\n", x);
  }
  x--;
  printf("x = %d\n", x);
  exit(0);
}
