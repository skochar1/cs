
/**
 * CS 240 Zero: make zero without zero.
 */
#include <stdlib.h>
#include <stdio.h>

/**
 * We know `char` as a 1-byte type for representing character values.
 * But C allows to flip back and forth at will between thinking of it
 * as a character and thinking of it as the 8-bit number that
 * represents that character. In fact, it is perfectly legal to
 * perform number operations like `+` or bitwise operations like `&`
 * on `char` values. After all, they're just bytes!
 *
 * `unsigned char` is just like `char`, but when the bits are
 * interpreted as a number, they are interpreted as a non-negative
 * number: a number that is zero or greater.
 *
 * This `typedef` introduces a new name for an existing type.
 * Anywhere we write `byte` it is interpreted to mean `unsigned
 * char`. This just a convenience for us that will make the code a bit
 * more readable.
 */
typedef unsigned char byte;


/**
 * EXAMPLE: zero_minus
 *
 * Goal: take an unknown byte value `x` and return the byte value 0x00
 * no matter what `x` is.
 *
 * The body of the function may use only parentheses, `return`, `;`, `x`,
 * and the MINUS operator `-`.
 *
 * No other C features are allowed.
 */
byte zero_minus(byte x) {
  return x - x;
}



/**
 * TASK: zero_xor
 *
 * Goal: take an unknown byte value `x` and return the byte value 0x00
 * no matter what `x` is.
 *
 * The body of the function may use only parentheses, `return`, `;`, `x`,
 * bitwise XOR `^`.
 *
 * No other C features are allowed. You may not write number literals
 * (e.g, 0).
 */
byte zero_xor(byte x) {
  return x ^ x;
}

/**
 * TASK: zero_and_not
 *
 * Goal: take an unknown byte value `x` and return the byte value 0x00
 * no matter what `x` is.
 *
 * The body of the function may use only parentheses, `return`, `;`, `x`,
 * bitwise AND `&`, and bitwise NOT `~`.
 *
 * No other C features are allowed. You may not write number literals
 * (e.g, 0).
 */
byte zero_and_not(byte x) {
  return x & ~x;
}

/**
 * TASK: zero_or_not
 *
 * Goal: take an unknown byte value `x` and return the byte value 0x00
 * no matter what `x` is.
 *
 * The body of the function may use only parentheses, `return`, `;`, `x`,
 * bitwise OR `|`, and bitwise NOT `~`.
 *
 * No other C features are allowed. You may not write number literals
 * (e.g, 0).
 */
byte zero_or_not(byte x) {
  // FIXME: replace the body of this function.
  return ~(x | ~x);
}

/**
 * +CHALLENGE TASK: zero_plus_not
 *
 * Goal: take an unknown byte value `x` and return the byte value 0x00
 * no matter what `x` is.
 *
 * The body of the function may use only parentheses, `return`, `;`, `x`,
 * ADDITION `+`, and bitwise NOT `~`.
 *
 * No other C features are allowed. You may not write number literals
 * (e.g, 0).
 */
byte zero_plus_not(byte x) {
  return ~(~x + x);
}


/**
 * The main function runs when the program is executed.
 * It tests your functions on all possible byte values.
 *
 * Do not change this code.
 */
int main(int argc, char** argv) {
  byte expected = 0x00;
  
  for (unsigned i = 0; i <= 0xFF; i++) {
    byte actual = zero_minus(i);
    if (actual != expected) {
      printf("zero_minus(0x%02x) returned 0x%02x.\n", i, actual);
      return 1;
    }
  }
  printf("zero_minus passed all tests!\n");

  for (unsigned i = 0; i <= 0xFF; i++) {
    byte actual = zero_xor(i);
    if (actual != expected) {
      printf("zero_xor(0x%02x) returned 0x%02x.\n", i, actual);
      return 1;
    }
  }
  printf("zero_xor passed all tests!\n");

  for (unsigned i = 0; i <= 0xFF; i++) {
    byte actual = zero_and_not(i);
    if (actual != expected) {
      printf("zero_and_not(0x%02x) returned 0x%02x.\n", i, actual);
      return 1;
    }
  }
  printf("zero_and_not passed all tests!\n");

  for (unsigned i = 0; i <= 0xFF; i++) {
    byte actual = zero_or_not(i);
    if (actual != expected) {
      printf("zero_or_not(0x%02x) returned 0x%02x.\n", i, actual);
      return 1;
    }
  }
  printf("zero_or_not passed all tests!\n");

  for (unsigned i = 0; i <= 0xFF; i++) {
    byte actual = zero_plus_not(i);
    if (actual != expected) {
      printf("+ zero_plus_not(0x%02x) returned 0x%02x.\n", i, actual);
      return 1;
    }
  }
  printf("+ zero_plus_not passed all tests!\n");

  printf("ALL TESTS PASSED.\n");
  return 0;
}
