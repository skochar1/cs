#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main() {
  int i;

  for (i = 0; i < 2; i++)  {
    fork();
  }
  printf("hello\n");
  exit(0);
}
