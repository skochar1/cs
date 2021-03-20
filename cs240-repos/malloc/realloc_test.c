/**
 * Changes the size of the memory block pointed to by
   ptr to size bytes
  >> If ptr is NULL, then the call is equivalent to malloc(size), for all values of 
      size
  >> If size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr). 
   Unless ptr is NULL, it must have been returned by an earlier call to malloc(), calloc()
   or realloc(). 
  >> If the area pointed to was moved, a free(ptr) is done.
 */

void* mm_realloc(void* ptr, size_t size) {
  size_t size_org;
  void* final;
  word_t* cursor_final;
  word_t* cursor_ptr; 

  // Case 1: size is 0 so block is free and we return 0
  if (size == 0) {
    mm_free(ptr);
    return 0;
  }
  
  // if the original pointer is NULL, then we can use malloc to make space for the block
  if (ptr == NULL) {
  return mm_malloc(size);
  }
  
  // return 0 in the case that mm_malloc does nothing useful
  final = mm_malloc(size);
  if (!final) {
    return 0;
  }
  
  size_org = status_size(LOAD(ptr));
  if (size < size_org) {
    size_org = size;
  }
  
  cursor_final = final;
  cursor_ptr = ptr;

  // memcpy(final, ptr, size_org);
  // let our new pointer point to what the old pointer pointed to 
  for (int i = 0; i < size_org; i++) {
    STORE(cursor_final, LOAD(cursor_ptr));
    cursor_ptr = PADD(cursor_ptr, WORD_SIZE);
    cursor_final = PADD(cursor_final, WORD_SIZE);
  }
  
  // and finally, free the original pointer because we are no longer using it
  mm_free(ptr);
  return final;
}