#include <stdlib.h>
#include <stdio.h>
#include "hexdump.h"

int main() {
  int a[4] = { 0x41424344, 0x45464748, 0x494a4b4c, 0x4d4e4f50 };
  char* p0 = (char*)(a + 3);
  printf("%c\n", *p0);
  char* p1 = ((char*)a) + 3;
  printf("%c\n", *p1);

  for (char* p2 = (char*)a; p2 < (char*)(a + 4); p2++) {
    printf("%c ", *p2);    
  }
  printf("\n");
}
