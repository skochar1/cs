#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

void foo(int n) {
    int i;

    for (i = 0; i < n; i++) {
      fork();
    }
    printf("hello\n");
    exit(0);
}

int main(int argc, char** argv) {
  if  (argc < 2) {
	printf("usage: %s <n>\n", argv[0]);
	exit(0);
  }
  foo(atoi(argv[1]));
  exit(0);
}
