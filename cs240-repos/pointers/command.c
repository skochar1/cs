/**
 * CS 240 Pointers: A simple command parsing library
 *
 * Assignment description:
 * https://cs.wellesley.edu/~cs240/assignments/pointers/
 */
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include "command.h"

/**
 * Helper functions below ---------------------------------------
 */

/**
 * Returns a pointer to a newly allocated string holding the characters
 * in line starting with the character at index start and ending
 * just before the character at index end.
 *
 * Preconditions:
 * - line is a valid pointer to a well-formed string.
 * - To begin, assume start and end respect the bounds of line:
 *    - start > 0
 *    - start < (length of string) - 1
 *    - end < (length of string) - 1
 *    - end - start >= 0
 */

char* substring(char* line, int start, int end) {

  // allocate space for each character from line and one additional space to add the null character
  int n = (end - start) + 1; 
  char* array = (char*)malloc(sizeof(char) * n);

  // cursor_line is moved to point at the wanted index of line (aka start)
  // this will be crucial to extract the correct characters to add to substring
  char* cursor_line = line + start; 

  // cursor_array points to the beginning of array to add the correct characters to the 
  // allocated spaces from malloc and store them
  char* cursor_array = array; 

  // iterate through line using pointer cursor_line to pick up the intended chars
  // store them into array using cursor_array
  for (int i = start; i < end; i++) {
      *cursor_array = *cursor_line;
      cursor_array++;
      cursor_line++;
  }
  
  // add null character to indicate end of substring
  *cursor_array= '\0';
  return array;
}

/**
 * Returns the number of substrings/words in a given line
 * If the line is invalid, numWords will return -1. If line is an empty background
 * command, we return -2; if it is an empty foreground command, we return -3. Else, we
 * return appropriate amount of words
 */

int numWords(char* line) {
  int num = 0; // number of words in line
  char* cursor = line; // points to location in line
  int inWord = 0; // value of 0 if we are not in a word and 1 if we are inside a word
  int saw_amp = 0; // value of 0 means no ampersand 1 means saw ampersand in line

  // while the cursor does not point to a null character, we iterate through
  // line and count the number of words
  while (*cursor) { 

    // to check if we are at the end of a word (marked by a space character)
    // we will increment num by 1 if we are at the end of a word to keep track
    // of our total number of words
    if (*cursor == ' ') {
      if (inWord) {
        num++;
      }
      
      // reset inWord to false because we aren't in a word anymore
      // allows us to prepare for next word and set inWord to 1 when we do enter a new word
      inWord = 0x00;
    }

    // check if the cursor currently points so an ampersand
    else if (*cursor == '&') {

      // if cursor points to an ampersand and we have already seen an ampersand before
      // the statement is invalid.
      if (inWord && saw_amp != 0) {
        return -1;
        }
      
      // otherwise, we need to set saw_amp to 1 to make sure it is recorded that we have
      // already seen an ampersand for our validity checks
      saw_amp = 1;
    }

    // this is the case for seeing a non-space char after seeing an '&', which is invalid
    else if (saw_amp) {
      return -1;
    }

    // if none of the other cases are met, then that means we are currently in a word
    // so we must set inWord to 1 for keeping track
    else {
      inWord = 1;
    }

    // move the pointer over to the next character in line
    cursor++;
  }

  // if, at the end of line, we end in a word (so nothing afterwards), we must be sure
  // to increment the number of words by 1 so that num is accurate 
  if (inWord) {
    num++;
  }
  
  // an empty foreground command (all spaces) or an empty background command (an ampersand
  // and any amount of spaces) is valid, so we must have different returned values to
  // indicate these, for use in command_parse. Thus, if it is an empty background command,
  // we return -2; if it is an empty foreground command, we return -3.
  if (num == 0) {
    if (saw_amp) {
      return -2;
    }
    return -3;
  } 
  // finally, return the number of words in the line (we are only able to reach this point
  // if the line was valid)
  return num;
}

/**
 * Helper functions above ---------------------------------------
 */

/**
 * command_parse:
 *
 * Parse a command-line string, report foreground/background status,
 * and return a command array.  Each element in the command array
 * corresponds to one word in the command string, in order.
 *
 * A command with '&' after the last word is a background command.
 * The '&' is not part of the resulting command array.  Repetitions or
 * other placements of '&' constitute invalid command lines.
 *
 * Parameters:
 *
 * - line: non-NULL pointer to a command-line string.
 *
 * - foreground: non-NULL pointer to an int where foreground (1)/
 *   background (0) status of the command line should be stored.
 * 
 * Return:
 *
 * - a pointer to a NULL-terminated array of strings (char**) if given
 *   a valid command-line string.
 *
 * - NULL if given a command-line string with invalid placement of '&'
 */

char** command_parse(char* line, int* foreground) {
  
  assert(line);
  assert(foreground);

  int wordCount = numWords(line);

  // if our line is invalid, numWords returns -1, so our command_parse should return NULL.
  // note: we check for validity WITHOUT setting foreground/background
  char** empty_array = (char**) malloc(sizeof(char*) * 1);
  if (wordCount == -1) {
      return NULL;
  }

  // if we receive the empty background command, we must set foreground to 0 and
  // return an empty array
  if (wordCount == -2) {
    *empty_array = NULL;
    *foreground = 0;
    return empty_array;
  }

  // if we receive the empty foreground command, we must set foreground to 1 and
  // return an empty array
  if (wordCount == -3) {
    *empty_array = NULL;
    *foreground = 1;
    return empty_array;
  }
  
  // now, we can write the rest of command parse only for valid cases
  // we set the cursor as a pointer to the first character in the line and allocate
  // space for every word and an additional space for the final NULL in the final command array.
  char* cursor = line;
  char** words = (char**) malloc(sizeof(char*) * (wordCount + 1));
  char** word_index = words; // word_index points to words[0]

  int inWord = 0x00;   // inWord checks for whether we are in a word or not
  int start = 0; // starting index of a substring to add to words
  int end = 0; // ending index of a substring to add to words
  *foreground = 1; // will be 0 if ampersand is found; otherwise, will stay 1

  // iterate until null char found in line
  while (*cursor) {

    // if we find a space after being in a word, we need to create a substring of the 
    // word to store in words, increment word_index by 1, and reset inWord to 0 to allow
    // us to keep record of where in the line we are
    if(*cursor == ' ') { 
      if(inWord) {
        *word_index = substring(line, start, end);
        word_index++;
      }
      inWord = 0x00;
    }

    // case for if we are not at a space
    else {

      // if we were not previously in a word, that means we are starting a new word 
      // so we should adjust indices to use later in substring() accordingly 
      if(!inWord) {
        start = end;
      }
      inWord = 0x01; // set inWord to true
    }
    
    // if the cursor is pointing at an ampersand, we set foreground and break from the loop
    // to 0
    if (*cursor == '&'){
      *foreground = 0;
      break;
    }

    // increment the value of the ending index and move the cursor to the next character
    end++;
    cursor++;
  }

  // if we are still in a word by the end of the line, substring the last word
  // and increment the word_index so that the last word_index can be stored with
  // a value of NULL
  if (inWord){
      *word_index = substring(line, start, end);
      word_index++;
  }
  *word_index = NULL;
  
  // return the final array words
  return words;
}

/**
 * command_show:
 *
 * Print the structure of a command array.
 *
 * Parameters:
 *
 * - command: a non-NULL pointer to the command array to print.
 */
void command_show(char** command) {
  // Check argument: must be non-NULL pointer.
  assert(command);
  
  // Create cursor that points to larger array (that holds each string)
  char** cursor = command;

  // If the array only consists of the NULL pointer, there is nothing to
  // iterate through, so we print null char to indicate this.
  printf("command array:\n");
  if (*cursor == NULL) {

    // Added quotes to show stripped spacing
    printf("    - \"%c\"\n", '\0');
    printf("end\n");
    return;
  }

  // Iterate through command array until it hits the NULL pointer 
  // Note: We are iterating through the larger array, not the arrays holding
  // each char in one word
  while(*cursor != NULL) {

    // Added quotes to show stripped spacing
    printf("    - \"%s\"\n", *cursor); 
    cursor++;
  }
  printf("end\n");
}

/**
 * command_print:
 *
 * Print a command array in the form of a command-line string
 * **without a new line at the end **.
 *
 * Parameters:
 *
 * - command: non-NULL pointer to the command array to print.
 */
void command_print(char** command) {
  // Check argument: must be non-NULL pointer.
  assert(command);
  // Create cursor that points to larger array (that holds each string)

  char** cursor = command;

  // If command is an empty array, print null char and return nothing
  if (*cursor == NULL) {
    printf("%c", '\0');
    return;
  }

  // Check if cursor is not pointing at a null address and if not, print.
  // This “if” statement makes sure an extra space isn’t printed when
  // iterating through the array (as shown in the while loop below)
  if (*cursor != NULL) {
    printf("%s", *cursor);
  }

  cursor++;

  // Iterate through the array and print each substring (array of chars) until 
  // we reach the end of the array (NULL pointer)
  while(*cursor != NULL) {
    printf(" %s", *cursor);
    cursor++;
  }
}

/**
 * command_free:
 *
 * Free all parts of a command array created by command_parse.
 *
 * Parameters:
 *
 * - command: non-NULL pointer to the command array to free.
 */
void command_free(char** command) {
  // Check argument: must be non-NULL pointer.
  assert(command);

  // Create cursor that points to larger array (that holds each string)
  char** cursor = command;

  // Iterate through the command array until we reach the end
  while (*cursor != NULL) {

      // Free the contents at cursor (which is an array of chars, aka a string)
      // this is to free the smaller arrays first
      free(*cursor);
      cursor++;
  }

   // Free the command array, or the “larger” array holding the array of strings
   // After this, all parts of command array will be freed.
  free(command);
}