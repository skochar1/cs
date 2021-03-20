#include <stdlib.h>
#include <stdio.h>
#include "hexdump.h"

void mystery0(char* ps, char* pa) {
  while (*ps) {
    *pa = *ps;
    ps++;
    pa++;
  }
  *pa = '\0';
}

int main() {
  char a[7] = {'h', 'e', 'l', 'l', 'o', '!', '\0'};
  char b[7];

  // hexdump(b, 16);
  printf("\n");
  
  mystery0(a, b);
  // hexdump(b, 16);
  printf("a = \"%s\"\n", a);
  printf("b = \"%s\"\n\n", b);

  mystery0("cs 240", a);
  // hexdump(b, 16);
  printf("a = \"%s\"\n", a);
  printf("b = \"%s\"\n\n", b);

  mystery0("0xF", &a[2]);
  // hexdump(b, 16);
  printf("a = \"%s\"\n", a);
  printf("b = \"%s\"\n\n", b);

}
