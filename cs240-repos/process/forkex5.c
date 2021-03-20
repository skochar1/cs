#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void doit() {
  if (fork() == 0) {
    printf("hello\n");
    doit();
    exit(0);
  }
  return;
}

int main() {
  doit();
  printf("hello\n");
  exit(0);
}
