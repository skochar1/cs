/* 
 * CS 240 Bits
 * 
 * bits.c - Source file with your solutions.
 */

#if 0
CODING RULES:
 
  Replace the "return" statement in each function with one
  or more lines of C code that implements the function. Your code 
  must conform to the following style:
 
  int puzzle(arg1, arg2, ...) {
      /* Brief description of how your implementation works */
      int var1 = Expr1;
      ...
      int varM = ExprM;

      // Inline comments explain specific steps if needed.
      varJ = ExprJ;
      ...
      varN = ExprN;
      return ExprR;
  }

  Each "Expr" is an expression using ONLY the following:
  1. Integer literals 0 through 255 (0xFF), inclusive. You are
      not allowed to use large literals such as 0xffffffff.
  2. Function arguments and local variables (no global variables).
  3. The list of "Legal ops" given in the function comment.
  
  Each "Expr" may consist of multiple operators. You are not restricted to
  one operator per line.

  Your solution to a puzzle should use no more than the number of "Max ops"
  listed for the fuction.

  You are expressly forbidden to:
  1. Use any control constructs such as if, do, while, for, switch, etc.
  2. Define or use any macros.
  3. Define any additional functions in this file.
  4. Call any functions.
  5. Use any other operations, such as &&, ||, -, or ?:, not listed in the
     the "Legal ops" list for each function.
  6. Use any form of casting.
  7. Use any data type other than int.  This implies that you
     cannot use arrays, structs, or unions.
 
  Assume that your machine:
  1. Uses 2s complement, 32-bit representations of integers.
  2. Performs right shifts (>>) arithmetically on ints.
  3. Has unpredictable behavior when shifting an integer by more
     than the word size.

EXAMPLES OF ACCEPTABLE CODING STYLE:
  /*
   * pow2plus1 - returns 2^x + 1, where 0 <= x <= 31
   * Legal ops: ! ~ & ^ | + << >>
   */
  int pow2plus1(int x) {
     /* Shifting left by n bits multiplies by 2^n. */
     return (1 << x) + 1;
  }
  int pow2plus1(int x) {
     /* Exploit ability of shifts to compute powers of 2. */
     int result = (1 << x);
     result = result + 1;
     return result;
  }
#endif


/* 
 * bitAnd: x&y using only ~ and | 
 *   Example: bitAnd(6, 5) = 4
 *   Legal ops: ~ |
 *   Max ops: 8
 *   Rating: 1
 */
int bitAnd(int x, int y) {

  /* Takes inputs x and y, and takes the OR of their NOT versions, which will give us the 
  exact opposite of what the AND of x and y gives us. To correct it, the function NOTs the 
  entire value, which altogether is equivalent to the AND of x and y */

  return ~(~x | ~y) ;
}

/* [INDEPENDENT PROBLEM]
 * bitXor: x^y using only ~ and & 
 *   Example: bitXor(4, 5) = 1
 *   Legal ops: ~ &
 *   Max ops: 14
 *   Rating: 1
 */
int bitXor(int x, int y) {

  /* Takes inputs x and y, takes the AND of (NOT y and x) as well as the AND of (NOT x and y) in 
  order to check if they differ; x and y differ, either (NOT y and x) or (NOT x and y) will 
  yield a 1. If they are the same, both (NOT y and x) and (NOT x and y) will yield a 0. Now, we 
  take the NOT of both (NOT y and x) and of (NOT x and y) and AND them. If x and y are the same, 
  this process will yield a 1, and taking the NOT of 1 will yield a 0 in the end. If x and y are 
  different, this process will yield a 0, and taking the final NOT of that will make the function
  return a 1. In this manner, this function fulfills the requirements of the XOR function. */

  return ~(~(x & ~y) & ~(~x & y));
}

/* 
 * thirdBits: return int with every third bit (including LSB) set to 1
 *            and all other bits set to 0.  This function always returns
 *            the same result.
 *   Example: thirdBits() = (in binary:) ...001001001
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 8
 *   Rating: 1
 */
int thirdBits() {

  /* Starts off with 1001 in binary and shifts it repeatedly, combined with ORs, to achieve
  solution. This process is done with ORs to make sure that wherever a 1 is desired, 
  it is copied into that place. Shifts it twice by 3 first and then combined those shifts with a 
  another version of itself that has been shifted 6 times, creating a larger sequence of 0s and 1s
  which will allow us to reduce the number of times we need to use the shift and OR operators.
  Finally, the variable is combined with a version of itself shifted 15 times, yielding the 
  correct result. */
  
  int starter = 9;
  int starter2 = starter << 3;
  int starter3 = starter2 << 3;
  int joint = (starter | starter2 | starter3);
  int starter4 =  (joint | (joint << 6));
  int starter5 = (starter4 | (starter4 << 15));

  return starter5;
}

/* 
 * fitsBits: return 1 if x can be represented as an n-bit, two's
 *           complement integer, where 1 <= n <= 32.
 *   Examples: fitsBits(5,3) = 0, fitsBits(-4,3) = 1
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 15
 *   Rating: 2
 *   Hint: think about sign extension
 */
int fitsBits(int x, int n) {

  /* Shift by 32 - n bits to the left, moving the bits into the most significant bit positions
  and losing anything that does not fit into n; then shift back to the right the same 
  amount, moving them back to the least significant bit positions so we can easily analyze them. 
  We do this to check whether of not the bits have changed; this is crucial to determining 
  whether or not the bits fit. The number of bits should remain unchanged after the 
  two shifts if the bits fit, and return a 1; otherwise, x does not fit in n bits, and so the 
  function returns a 0. */

  int shift = x << (32 + (~n + 1));

  // shift back to prepare for checking if there was a change
  int shift2 = shift >> (32 + (~n + 1));
  return !(x ^ shift2);
}

/* [INDEPENDENT PROBLEM]
 * sign: return 1 if positive, 0 if zero, -1 if negative
 *   Examples: sign(130) = 1
 *             sign(-23) = -1
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 10
 *   Rating: 2
 *   Hint: compute separate answers and combine
 */
int sign(int x) {

  /* Tells us the sign of the integer value by analyzing the most significant bit and 
  converting the values to just 0 or 1 to more easily allow for comparisons (see in 
  line comments for detailed explanations/reasoning for each step) */

  // shift to the most significant bit; this is the one we will analyze for sign. Should be 0 
  // if x is 0 or positive and 1 if x is negative
  int msb = x >> 31; 

  // allows us to display the given input as just true or false
  int fixX = !!x; 

  // take the OR of these two statements; will return -1 for negative, 0 for zero, and 1 for
  // positive
  return fixX | msb;
}

/* 
 * getByte: extract byte n from int x,
 *          where bytes numbered from 0 (LSB) to 3 (MSB)
 *   Examples: getByte(0x12345678,1) = 0x56
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 6
 *   Rating: 2
 */
int getByte(int x, int n) {

  /* Uses shifting to shift the values of x into a place where the wanted byte is now in the 
  position of the LSB. Then uses masking to get rid of everything that is not the LSB of the
  new value, returning only the wanted byte (more detailed explanations are provided for each
  step in the in-line comments) */
  
  // Use shifting to raise the power of n, thus allowing x to shift by the correct magnitude
  // then, implement the shift for x, making the desired byte the LSB
  int shift = x >> (n << 3); 

  // create a mask to get only the values within the desired byte
  int mask = 0xFF;
  
  // mask and return the wanted byte
  return shift & mask;
}

/* 
 * logicalShift: logical shift x to the right by n,
 *               where 0 <= n <= 31
 *   Examples: logicalShift(0x87654321,4) = 0x08765432
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 20
 *   Rating: 3 
 *   Hint: Shifting a 32-bit value by 32 is undefined.
 *         Think about splitting a potentially undefined shift into
 *         smaller defined shifts.
 */
int logicalShift(int x, int n) {

  /* Uses shifting and masking in order to implement the desired changes logical
  shift in the inputted number. Shifts x to the right by n and creats a mask to get rid
  of all other unnecessary bits. Masks them and then shifts the masked value by n again.
  Aligns the new value by shifting it 1 to the left and then takes the XOR of the initial
  shift and the final alignment to finish the shifting process (more detailed explanations are 
  provided for each step in the in-line comments) */

  // shift x to the right by a value of n and create a mask using shifting on 1
  int shift = x >> n;
  int maskVal = 1 << 31;

  // use the mask value for the process of masking and obtaining the desired bits
  int masking = x & maskVal;

  // shift the maskVal down by a value of n to move the bits back into place
  int toTheRight = masking >> n;

  // shift the entire sequence to the left by a value of 1 to fix alignment
  int align = toTheRight << 1;
  return shift ^ align;
}

/* 
 * addOK: determine if x+y succeeds without overflow
 *   Example: addOK(0x80000000,0x80000000) = 0,
 *            addOK(0x80000000,0x70000000) = 1, 
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 20
 *   Rating: 3
 */
int addOK(int x, int y) {

  /* Checks if adding x and y will cause overflow by checking the most significant bits (MSBs)
  on both x and y, as well as the MSB on their sum; also checks to see if the MSB of x and y
  are different (in which case overflow would not occur) or if they are the same (and checks
  for overflow accordingly). */
  
  // shift all the values to show the most significant bit and then mask it with a 1 to 
  // avoid negatives
  int sign_x = (x >> 31) & 1;
  int sign_y = (y >> 31) & 1;
  int sign_add = ((x + y) >> 31) & 1;

  // check to make sure that the signs are the same in the case that x and y are the same sign
  int check1 = !(sign_x ^ sign_add);
  int check2 = !(sign_y ^ sign_add);

  // an OR statement in case x and y differ in signs
  return (sign_x ^ sign_y) | (check1 & check2);
}

/* [INDEPENDENT PROBLEM]
 * bang: compute !x without using !
 *   Examples: bang(3) = 0, bang(0) = 1
 *   Legal ops: ~ & ^ | + << >>
 *   Max ops: 12
 *   Rating: 4 
 *   Hint: 0 is the only int x for which both x >= 0 and -x >= 0
 */

int bang(int x) {

 /* compares x's negated value to the original input and shifts their OR to the right 31 bits;
  we do this to see the most significant bit after the OR comparison, which essentially 
  decides the sign. This also accounts for the special case that the input is 0, 
  where overflow will allow our MSB to be 0. By adding 1 on top of that, we manipulate the 
  return value appropriately for to match the wanted output (ex. if val = 0, then that means 
  the input was 0, and so the output should be 1) */

  // negate x using two's complements identity
  int neg = ~x + 1;
  int val = (neg | x) >> 31;
  return val + 1;
}


/* 
 * conditional: same as x ? y : z 
 *   Example: conditional(2,4,5) = 4
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 16
 *   Rating: 3
 */
int conditional(int x, int y, int z) {

  /* Uses the ! operator to generate the opposite of x; gives us a true or false value (0 or 1) 
  (reverses the current state of x and saves it). Then takes the opposite of 0 and saves an OR
  with it, which is used to finally check y and z. (more detailed explanations are provided 
  for each step in the in-line comments) */

  // first, we will start off by saving the value of !x, as we will use it several times
  int oppX = !x;

  // we will need a mask in this case; using the idea of "NOT 0" will work best for us here
  int constant = ~0;
  int constantVersion = oppX + constant;

  // We now need to check how this masked version affects y and z. If either the maskedVersion 
  // and y or the NOT masked version and z hold true, the condition is considered to be met
  return (constantVersion & y) | (~constantVersion & z);
}

/*
 * isPower2 - returns 1 if x is a power of 2, and 0 otherwise
 *   Examples: isPower2(5) = 0, isPower2(8) = 1, isPower2(0) = 0
 *   Note that no negative number is a power of 2.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 20
 *   Rating: 4
 *
 * SAMPLE DESCRIPTION AND SOLUTION:
 * This description is on the detailed side. Explains the properties
 * extensively and includes quick connections with the operators.
 * 
 * Use the property that, if x is a power of two, x has exactly one 1
 * bit, followed by n zeros if x is the nth power of 2.  For example,
 * 8 = 0...01000. The predecessor of the nth power of 2 has exactly n
 * ones, all in the n least significant bits; all other bits are 0.
 * For example, 7 = 0...00111. Any other pair of x and x-1 has at
 * least one 1 bit in common. Example: 6 (0...0110) and 5 (0...0101).
 * There are actually two other values that are *not* powers of two
 * that also satisfy the property "x and x-1 share no 1 bits." Zero
 * (=0...0 vs -1 = 1...1) and the minimum twos complement value
 * (=10...0 vs the maximum twos complement value 01...1). In fact, no
 * negative is a power of, so we filter out all negatives, capturing
 * the twos complement minimum.
 */
int isPower2(int x) {
  return !(x & (x + ~0)) // x and its predecessor share no 1 bits
    & !!x               // AND x is nonzero
    & !(x >> 31);       // AND x is non-negative
}



#if 0
/* 
 * SAMPLE ALTERNATIVE DESCRIPTION:
 * This description reorganizes the ideas more incrementally. It
 * explains more about the connection to operators and mechanics,
 * making it a more comprehensive description.
 */
int isPower2_alt1(int x) {
  // A power of 2 has exactly one 1 bit among all its bits and shares
  // no 1 bits in common with the next smallest value (the predecessor).
  // This expression yields the value 1 if this property holds and 0
  // otherwise.
  int shares_no_ones_with_pred = !(x & (x + ~0));
  // But two other values share this property with powers of 2:
  //   A. zero also satisfies this property, so we must check for it.
  //      !! transforms 0 to 0 and transforms any nonzero number to 1.
  int nonzero = !!x;
  //   B. The most negative number, the twos complement minimum, also
  //      satisfies the same 1-sharing property. Since no power of 1
  //      is negative, isolate the sign bit and use Boolean NOT to
  //      yield 1 if x is non-negative.
  int nonnegative = !(x >> 31);
  // Overall, x is a power if two if and only if it shares no ones
  // with its predecessor and it is nonzero and it is non-negative.
  return shares_no_ones_with_pred & nonzero & nonnegative;
}

/* 
 * ALTERNATIVE SHORTER SOLUTION:
 * This version is reorganized vs alt1 to use fewer operators. It
 * still uses the same insights.
 */
int isPower2_alt2(int x) {
  // A power of 2 has exactly one 1 bit among all its bits and shares
  // no 1 bits in common with the next smallest value (the predecessor).
  // This expression yields the value 0 if this property holds and nonzero
  // otherwise.
  int shares_ones_with_pred = x & (x + ~0);
  // But two other values share this property with powers of 2:
  //   A. zero also satisfies this property, so we must check for it.
  //      ! transforms 0 to 1 and transforms any nonzero number to 0.
  int iszero = !x;
  //   B. The most negative number, the twos complement minimum, also
  //      satisfies the same 1-sharing property. Since no power of 1
  //      is negative, duplicate the sign bit to produce -1 or all
  //      negative x and 0 for all non-negative x.
  int negative = x >> 31;
  // Overall, x is a power if two if and only if it shares no ones
  // with its predecessor and it is nonzero and it is non-negative.
  // If any one of these three values carries any 1 bit, x is not a
  // power of 2.
  return !( shares_ones_with_pred | iszero | negative);
}
#endif
