#include <stdlib.h>
#include <stdio.h>
#include "hexdump.h"

void copy(char* src, char* dst) {
  while (*src) {
    *dst = *src;
    src++;
    dst++;
  }
  *dst = '\0';
}

int main() {
  char* p;
  char a[8];
  int x = 19;
  char b[4];

  p = &a[4];

  // hexdump(b, 32);
  printf("\n");
  
  copy("Hello!", a);
  copy("Hi!", b);
  // hexdump(b, 32);
  printf("x = %d\n", x);
  printf("p = %p\n", p);
  printf("a = \"%s\"\n", a);
  printf("b = \"%s\"\n\n", b);

  copy("Hi, CS 240!", b);
  // hexdump(b, 32);
  printf("x = %d\n", x);
  printf("p = %p\n", p);
  printf("a = \"%s\"\n", a);
  printf("b = \"%s\"\n\n", b);

  copy("What happens if we use a really really long string?", b);
  // hexdump(b, 64);
  printf("x = %d\n", x);
  printf("p = %p\n", p);
  printf("a = \"%s\"\n", a);
  printf("b = \"%s\"\n\n", b);

  copy("Hi?", p);
  // hexdump(b, 64);
  printf("x = %d\n", x);
  printf("p = %p\n", p);
  printf("a = \"%s\"\n", a);
  printf("b = \"%s\"\n\n", b);

}
