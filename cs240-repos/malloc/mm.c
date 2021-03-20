/**********************************************************************\

  Wellesley CS 240 Malloc: mm.c starter code

  Completed code by Shreya Kochar and Julie Lely
  Starter code by Ben Wood, 2015-2016.
  Additional support files use CSAPP materials.
  NOTE: This is our Explicit Implementation - 
  -> Our implicit implementation is in mmIMPLICIT.c

\**********************************************************************/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>

#include "memlib.h"
#include "mm.h"

/* HEAP BLOCK LAYOUT ************************************************\

   The heap is divided into contiguous blocks.  Blocks are flexibly
   sized, subject to ALIGNMENT (2 words).  The initial word of a block
   is treated as a header status word at all times.  Free blocks use
   the last word as a footer to store SIZE ONLY (not tags).  The
   required header and footer words for free blocks fix the minimum
   block size at 2 words.  While allocated, the header is the only
   metadata needed in a block.

   Payloads must begin at addresses that are multiples of ALIGNMENT.
   Blocks begin at addresses A where A mod ALIGNMENT = (ALIGNMENT / 2)

                              ... lower addresses up
            HEAP BLOCK
      +--------------------+  <-- Start of block
      | header (size|tags) |
   ---+--------------------+  <-- Start of payload (when allocated)
    P |                    |      Address is multiple of ALIGNMENT
    A |                    |  
    Y |        ...         |  
    L |                    |  
    O |                    |  
    A +--------------------+
    D | footer (size)      |
   ---+--------------------+  <-- End of block, start following block.

                              ... higher addresses down
   
\*********************************************************************/


/* Type for words: word_t. */
typedef unsigned long word_t;

/* Block header stucture, each block is a node that consists of it's 
  status word (size, pred used, used), pointer to the next block, 
  and pointer to prev block */

struct BlockHeader {
  /*Status contains info on the size of the block, the block's alloc status,
    and the pred block's alloc status */
  word_t status;
  /* Pointers to the prev block in a free list */
  struct BlockHeader* prev;
  /* Pointers to the next block in a free list */
  struct BlockHeader* next;
};

typedef struct BlockHeader BlockHeader;

/* Size of a word on this architecture.
   All pointers and size_t values are one word in size. */
#define WORD_SIZE (sizeof(word_t))

/* Payloads returned by mm_malloc must be aligned to 2 words, as in
   the standard malloc implementation. */
#define ALIGNMENT ((size_t)(2*WORD_SIZE))

/* Minimum block size: header and footer [and prev and next pointers].
  This will be 32 bytes, [ BLOCKHEADER[status word(8) + pred/succ pointers(16)] + footer (8)] */
#define MIN_BLOCK_SIZE (WORD_SIZE + sizeof(BlockHeader))


/* POINTER ARITHMETIC ************************************************** \

   PADD and PSUB support easier unscaled pointer arithmetic.
   Casting the pointer argument to char* makes pointer arithmetic
   effectively unscaled, since sizeof(char) == 1.

\**********************************************************************/

/* Perform unscaled pointer addition. */
static word_t* PADD(void* address, long distance) {
  return ((word_t*)((char*)(address) + (distance)));
}

/* Perform unscaled pointer subtraction. */
static word_t* PSUB(void* address, long distance) {
  return ((word_t*)((char*)(address) - (distance)));
}


/* STATUS WORDS *******************************************************\

   Status words, used in block headers, store a block's size (measured
   in bytes) and two 1-bit tags indicating the allocated/free status
   of this block and the preceding block in memory order.

   Since ALIGNMENT >= 8 (8 on 32-bit machines, 16 on 64-bit machines),
   all valid block sizes are at leasts multiples of 8 and the
   low-order 3 bits of valid block sizes are always 000 (0000 for
   64-bit machines).  We use these status word bits as tag bits.

             STATUS WORD
      +-----------------------+
      | . . . | 3 | 2 | 1 | 0 |
      +-----------------------+

   Bits ...-4:        <size>
   Bits 3-2:          <unused>
   Bit  1 (2^1 == 2): PRED_USED_BIT tag    [For coalescing]
   Bit  0 (2^0 == 1): USED_BIT tag

   The size and two tags can be extracted separately by masking.  Use
   the provided functions status_size, status_pred, status_used.

   Block footers store block size only, not tags.

\**********************************************************************/

/* status_size(x) extracts the block size information from a status word, x,
   masking off the other status bits. */
#define SIZE_MASK (~(ALIGNMENT - 1))
static word_t status_size(word_t status_word) {
  return status_word & SIZE_MASK;
}

/* status_pred(x) extracts the predecessor status bit from a status
   word, x, masking off the other status bits. */
#define PRED_USED_BIT 2
static word_t status_pred(word_t status_word) {
  return status_word & PRED_USED_BIT;
}

/* status_used(x) extracts the allocation status bit from a status
   word, x, masking off the other status bits. */
#define USED_BIT 1
static word_t status_used(word_t status_word) {
  return status_word & USED_BIT;
}

/* make_status(s,p,u) makes a new status word by extracting the block
   size information from status word s, the predecessor status bit
   from word p, and the allocation status bit from word u. 
   
   WARNING: to set the predecessor or used bits explicitly, pass
   PRED_USED_BIT or USED_BIT, not 1.
*/
static word_t make_status(word_t size, word_t pred_used, word_t used) {
  return (size & SIZE_MASK) | (pred_used & PRED_USED_BIT) | (used & USED_BIT);
}

/* HEAP LAYOUT ********************************************************\

   The heap starts at an address that is a multiple of page size.  Due
   to payload alignment requirements, blocks begin at addresses that
   are (ALIGNMENT/2 == 1 word) off from aligned.  Thus, the initial
   heap block starts with the 2nd heap word and the initial heap word
   cannot be part of any well-aligned block.

                              ... lower addresses up
              HEAP        
     +--------------------+   <-- HEAP_BASE, HEAP_HEADER_ADDR
     |                    |   
     +--------------------+   <-- ORIGIN_BLOCK_ADDR
   B | header (size|tags) |
   L +--------------------+   <-- payload aligned @ 2 words
   O | payload            |
   C | ...                |
   K |                    |
     +--------------------+
     |                    |
     |   ... blocks ...   |
     |                    |
     +--------------------+   <-- HEAP_FOOTER_ADDR
     |  heap footer word  |       
     +--------------------+   <-- HEAP_BOUND
                              ... higher addresses down

\**********************************************************************/

/* EXPLICIT LIST HEAP LAYOUT ********************************************************\

   The heap starts at an address that is a multiple of page size.  Due
   to payload alignment requirements, blocks begin at addresses that
   are (ALIGNMENT/2 == 1 word) off from aligned.  Thus, the initial
   heap block starts with the 2nd heap word and the initial heap word
   cannot be part of any well-aligned block.

                              ... lower addresses up
              HEAP        
     +--------------------+   <-- HEAP_BASE, HEAP_HEADER_ADDR
     |                    |   
     +--------------------+   <-- ORIGIN_BLOCK_ADDR
   B | header (size|tags) |    
   L +--------------------+   <-- payload aligned @ 2 words
   O |    pred pointer    |   <-- pred pointer, 1 word
   C +--------------------+
   K |    succ pointer    |   <-- succ pointer, 1 word
     +--------------------+
     |                    |
     |   ... blocks ...   |
     |                    |
     +--------------------+   <-- HEAP_FOOTER_ADDR
     |  heap footer word  |       
     +--------------------+   <-- HEAP_BOUND
                              ... higher addresses down

\**********************************************************************/

/* Base address of the heap. */
#define HEAP_BASE ((word_t*)mem_heap_lo())

/* For explicit free list implementation, HEAP_BASE is now the
  FREE_LIST_HEAD, which is a pointer to a pointer */
#define FREE_LIST_HEAD *((BlockHeader**)mem_heap_lo())

/* Bound address of the heap (first address after the heap. */
#define HEAP_BOUND ((word_t*)PADD(mem_heap_hi(), 1))

/* Address of the heap header word. */
#define HEAP_HEADER_ADDR ((word_t**)HEAP_BASE)

/* Address of the first block in the heap (in memory order). */
#define ORIGIN_BLOCK_ADDR ((word_t*)PADD(HEAP_BASE, WORD_SIZE))

/* Address of the heap footer word. */
#define HEAP_FOOTER_ADDR ((word_t*)PSUB(HEAP_BOUND, WORD_SIZE))


/* CHECKED ACCESSES ***************************************************\

   The functions LOAD, PLOAD, STORE, and PSTORE can be used in place
   of pointer operations in your code to help detect errors early and
   avoid casting and pointer noise.  In addition to loading and
   storing data words (LOAD/STORE) and pointer words (PLOAD/PSTORE) in
   memory, these functions verify that all pointers used, stored, and
   loaded point within the heap and are word-aligned.  The helper
   function check_address can be used to perform these assertions
   elsewhere as well.

\**********************************************************************/

/* Assert that address is well-formed address of some word within
   heap. */
static bool check_address(void* address) {
  return
    // Address must be in heap bounds.
    ((void*)HEAP_BASE <= address && address < (void*)HEAP_BOUND)
    // Address must be word-aligned.
    && (((word_t)address & (WORD_SIZE - 1)) == 0);
}

/* LOAD(a) loads a word from memory at address a. */
static word_t LOAD(word_t* address) {
  assert(check_address(address)
         && "LOAD must load from a word-aligned address within the heap");
  return *((word_t*)(address));
}

/* LOAD(a) loads a pointer word from memory at address a. */
static word_t* PLOAD(word_t** address) {
  assert(check_address(address)
         && "PLOAD must load from a word-aligned address within the heap");
  word_t* ptr = *((word_t**)(address));
  assert((!ptr || check_address(ptr))
         && "PLOAD must return a word-aligned address within the heap");
  return ptr;
}

/* STORE(a,w) stores word w into memory at address a. */
static void STORE(word_t* address, word_t word) {
  assert(check_address(address)
         && "STORE must store to a word aligned address within the heap");
  *((word_t*)address) = word;
}

/* STORE(a,w) stores pointer word w into memory at address a. */
static void PSTORE(word_t** address, void* ptr) {
  assert((!ptr || check_address(ptr))
         && "PSTORE must store a word-aligned address within the heap");
  assert(check_address(address)
         && "PSTORE must store to a word aligned address within the heap");
  *((word_t**)address) = ptr;
}

/* BLOCK FUNCTIONS ****************************************************\

   The functions block_{get,set}_header are provided for easy
   manipulation of block headers.  You may wish to add similar
   functions for accessing footers.  The functions block_succ and
   block_pred compute the addresses of a block's successor and
   predecessor blocks in memory order, respectively.

   If implementing explicit free lists, additional functions
   block_{get,set}_{next,prev} should be added here to support easy
   manipulation of blocks as doubly-linked list nodes.

   For next-fit or explicit free lists, you should add functions to
   get and set the free list head pointer, stored in the (otherwise
   empty) first word of the heap.

\**********************************************************************/

/* Get the header word of the given block. */
static word_t block_get_header(word_t* block) {
  return LOAD(block);
}

/* Set the header word of the given block. */
static void block_set_header(word_t* block, word_t header) {
  STORE(block, header);
}

/* Given a block address, calculate the address of the block's
   successor, using this block's header. */
static word_t* block_succ(word_t* block) {
  // Get this block's size from its header and add to its address.
  return PADD(block, status_size(LOAD(block)));
}

/* Given a block address, calculate the address of the block's
   predecessor, assuming its predecessor is free. */
static word_t* block_pred(word_t* block) {
  // Predecessor must be free.
  assert(!status_pred(LOAD(block))
         && "predecessor must be free");

  // Get predecessor size from predecessor footer and subtract from
  // this block's address.
  word_t footer = LOAD(PSUB(block, WORD_SIZE));

  // Footers must hold sizes.
  assert(status_size(footer) == footer
         && "footer must hold size only, no status bits");
  return PSUB(block, footer);
}

/**
   * Helper function: removeFree removes a given free block from the free list 
   * Takes in a BlockHeader* struct
   */

static void removeFree(BlockHeader* fblock) {
  // Initialize pointers to the blocks before and after the free block in the free list
  BlockHeader* nextFree = fblock->next;
  BlockHeader* prevFree = fblock->prev; 

  // If the next free block exists, the header will point to the block after what we removed 
  if (nextFree != NULL) {
    nextFree->prev = prevFree; 
  }

  // In the case that the block we're removing is the header of the list, 
  // we will update the header to point at the successor block 
  if (fblock == FREE_LIST_HEAD) {
    FREE_LIST_HEAD = nextFree;
  }
  // If the block we're removing is int he middle of the list, the previous block
  // points to the block after the one we removed
  else {
    prevFree->next = nextFree;
  }
}


/**
   * Helper function: addFree inserts a given free block into the front of the list
   * and updates the heap head in LIFO order
   */

static void addFree(BlockHeader* fblock) {
  // Save the original free block in the free list
  BlockHeader* origHead = FREE_LIST_HEAD;

  // Make our newly added block's next point to the first block in the list (it is now
  // the first block in the list)
  fblock->next = origHead; 

  // Update the prev pointer of the original first block to point at the new block, because 
  // now the original first free block is now after the new one
  if (origHead != NULL) {
    origHead->prev = fblock;
  }

  // Update prev pointer of our fblock to NULL, since it is the first item in the list
  fblock->prev = NULL;

  // Update the head of the free list to point at our new block
  FREE_LIST_HEAD = fblock;
}


/* ALLOCATOR INTERNALS ************************************************\

   The function check_heap is a basic heap consistency checker useful
   for debugging.  The functions {extend_heap, search, allocate,
   coalesce} encapsulate key heap maintenance operations within the
   allocator.  These functions will need to be updated as you
   implement more sophisticated allocation schemes.

\**********************************************************************/

/** Report a heap error.  Helper for check_heap. */
static void heap_error(unsigned long threshold, unsigned long* count) {
  (*count)++;
  if (threshold < *count) {
    fprintf(stderr, "\n[!] MALFORMED HEAP\n\n");
    assert(false && "heap error");
  }
}

/* Check the heap.  Iterate through blocks as implicit free list.
   ADD CODE to check for consistency.  */
static void check_heap(unsigned long fail_threshold) {
  // print to stderr so output is displayed immediately, not buffered

  unsigned long errors = 0;
  word_t expect = PRED_USED_BIT;

  // For each block in the heap...
  word_t* block= ORIGIN_BLOCK_ADDR;
  while (1) {
    word_t header = LOAD(block);

    // print out common block attributes...
    fprintf(stderr, "%p: %lu %s %s\t",
            (void *)block,
            status_size(header),
            status_pred(header) ? "PA" : "PF",
            status_used(header) ? "A" : "F");

    // Check consistency of PRED_USED_BIT.
    if (status_pred(LOAD(block)) != expect) {
      fprintf(stderr, "  [BAD PRED TAG]");
      heap_error(fail_threshold, &errors);
    }

    // Mark the predecessor bit expected in the next block header.
    expect = status_used(LOAD(block)) ? PRED_USED_BIT : 0;

    // Check allocated/free/footer status.
    if (status_size(header) == 0) {
      // Misplaced or malformed heap footer.
      if (block == HEAP_FOOTER_ADDR && status_used(header)) {
        fprintf(stderr, "  <-- HEAP FOOTER\n\n");
        return;
      } else if (status_used(header)) {
        fprintf(stderr,
                "  [PREMATURE HEAP FOOTER, should appear at %p]",
                HEAP_FOOTER_ADDR);
      } else if (block == HEAP_FOOTER_ADDR) {
        fprintf(stderr, "  [MALFORMED HEAP FOOTER]");
      } else {
        fprintf(stderr,
                "  [ZERO-SIZED BLOCK OR MALFORMED HEAP FOOTER, should not appear until %p]",
                HEAP_FOOTER_ADDR);
      }

      // Definitely exit.
      heap_error(errors, &errors);
      assert(false && "heap error");
    } else if (!status_used(header)) {
      size_t footer = LOAD(PADD(block, status_size(header) - WORD_SIZE));
      if (footer != status_size(header)) {
        fprintf(stderr, "  [BAD BLOCK FOOTER %ld expected %ld]",
                footer, status_size(header));
        heap_error(fail_threshold, &errors);
      }
    }

    // Check the size.
    word_t* succ_addr = PADD(block, status_size(header));

    // Is size large enough to wrap around?
    if (succ_addr < block) {
      fprintf(stderr, "\t  [BAD SIZE]");
      heap_error(errors, &errors);
      assert(false && "heap error");
    }

    // Is size too big to fit in the heap?
    if (HEAP_FOOTER_ADDR < succ_addr) {
      fprintf(stderr,
              "\t  [BAD SIZE: passes heap footer %p]",
              HEAP_FOOTER_ADDR);
      heap_error(errors, &errors);
      assert(false && "heap error");
    }
    fprintf(stderr, "\n");

    // Go to next block
    block = block_succ(block);
  }
  // Unreachable
  assert(false && "unreachable");
}


/* Find a free block of the requested ideal_block_size in the free list.  Returns
   NULL if no free block is large enough. */
static void* search(size_t ideal_block_size) {
  // ideal_block_size must be a legal block size.
  assert(ideal_block_size >= MIN_BLOCK_SIZE
         && "ideal block size must be no smaller than minimum block size");
  assert((ideal_block_size & (~SIZE_MASK)) == 0
         && "ideal block size must be 16-byte aligned");
  
  // Start our search at the first free block in the free list
  BlockHeader* free_block = FREE_LIST_HEAD;

  // Search the whole free list
  while (free_block != NULL) {
    // Get the block's allocation status and size for checking
    word_t used = status_used(free_block->status);
    word_t size = status_size(free_block->status);

    // If it's large enough, use it, otherwise, continue search at
    // following block in free list.
    if (!used && ideal_block_size <= size) {
      return free_block;
    } else  {
      // Continue on to the next block in the free list and check
      free_block = free_block->next;
    }
  } 

  // Return NULL if no suitable block found.
  return NULL;
}


/* Make all heap updates to mark the given free block allocated and
   split if reasonbale to target the given ideal block size. */
static void allocate(BlockHeader* block, size_t ideal_block_size) {
  // Get the size of the block to be allocated.
  word_t header = block->status;
  size_t block_size = status_size(block->status);

  // Get the successor block's location and status
  word_t* successor = PADD(block, block_size);
  word_t successor_header = LOAD(successor);

  // First, subtract block's size by the ideal_block_size to see if there
  // is any left over space
  size_t left_over = block_size - ideal_block_size;

  // Check if we need to split the block or not
    // If the difference is greater than the minimum block size (32), we split
    if (left_over >= MIN_BLOCK_SIZE) {
      // Resize the block we will be allocating and mark it as allocated
      block->status = make_status(ideal_block_size, header, USED_BIT);

      // Create newly split block
      BlockHeader* split_block = (BlockHeader*)PADD(block, ideal_block_size);

      // Update new block header
      split_block->status = make_status(left_over, PRED_USED_BIT, 0);

      // Create footer of newly split block w/ block size
      word_t* footer = PADD(split_block, left_over - WORD_SIZE);
      STORE(footer, left_over);

      // Add newly created split_block to the front of the free list
      addFree(split_block);

      // Remove allocated block from the free-list
      removeFree(block);

      // Update successor block in the heap
      STORE(successor,
           make_status(successor_header, 0, successor_header));
    }

    // In the case that the ideal_block_size matches the block size perfectly
    else {
      // Remove the "once" free block from the free list
      removeFree(block);

      // Update it's status to allocated
      block->status = make_status(header, header, USED_BIT);

      // Update successor's pred_bit
      STORE(successor,
            make_status(successor_header, PRED_USED_BIT, successor_header));
    }
}


/* Coalesce this block with its memory-order predecessor or successor
   where possible. */
static void coalesce(BlockHeader* block) {
  // Coalesce should be called on free, non-empty blocks only.
  word_t header = block->status;
  assert(!status_used(header)
         && "coalesce accepts only free blocks");
  assert(0 < status_size(header)
         && "coalesce accepts only nonempty blocks");

  // Get the size of the block
  size_t size = status_size(block->status);

  // This will be the updated size of the block, if coal. occurs
  size_t total_size = size;

  // Represents the head of the coalesce block, default at the block
  // if the pred block is allocated
  BlockHeader* header_block = block;

  // Coalesce if pred block is free
  if (status_pred(header_block->status) == 0) {
    // Access previous block size through block footer
    size_t pred_size = (LOAD(PSUB(header_block, WORD_SIZE)));

    // Move back block size to get to the header of the pred block
    BlockHeader* pred_block = (BlockHeader*) PSUB(header_block, pred_size);
    
    // Remove from the free-list so we can coalesce with block
    removeFree(pred_block);
    
    // Increment size of pred block to total size
    total_size += pred_size;

    // Update our header_block to be the head of the pred block
    header_block = pred_block;
  }

  // Initialize the end_block, which is the succ block
  BlockHeader* end_block = (BlockHeader*) PADD(block, size);

  // If the successor block is free, coalesce with our current block
  if (status_used(end_block->status) == 0) {
    // Get the size of the succ block
    size_t succ_size = status_size(end_block->status);

    // Remove the succ block from the free list so we can coalesce and then add later
    removeFree(end_block);

    // Increase total size by succ block size
    total_size += succ_size;

    // Update "end_block" with the next succ block, this will be useful when 
    // want to access the footer block at the end of coal.
    end_block = (BlockHeader*) PADD(end_block, succ_size);
  }
  
  // If we were able to coalesce a block
  if (total_size != size) {
    // Remove our input block from the free list - time to coalesce!
    removeFree(block);
    // Get a hold of the orginal header for the head_block, so we can
    // get a hold of its pred block status
    word_t new_header = header_block->status;

    // Update the status of the head block to reflect new size
    header_block->status = make_status(total_size, new_header, 0);

    // Update the footer of the new block, which is basically one next to
    // current succ block we left of on (either the block footer if
    // succ is allocated or the succ footer of it is free)
    word_t* footer = PSUB(end_block, WORD_SIZE);
    STORE(footer, total_size);
    
    // Add newly coalesced block to the front of the list
    addFree(header_block); 
  }
}

/* Attempt to grow the heap by at least req_size additional bytes. 
   Return 1 if success, 0 if ran out of memory. */
static int extend_heap(size_t req_size) {

  // Initialize the new space as a block starting at the old heap footer.
  BlockHeader* addBlock = (BlockHeader*)HEAP_FOOTER_ADDR;

  // Align the required size to page alignment in total_size.
  size_t pagesize = mem_pagesize();
  size_t num_pages = (req_size + pagesize - 1) / pagesize;
  size_t total_size = num_pages * pagesize;

  // Attempt to grow the heap by total_size.
  void* mem_sbrk_result = mem_sbrk(total_size);
  if ((long)mem_sbrk_result == -1) {
    return 0;
  }

  // Update status of additional block to reflect the newly added size
  addBlock->status = make_status(total_size, LOAD((word_t*)addBlock), 0);

  // Initialize block footer: block size.
  word_t* footer = PADD(addBlock, total_size - WORD_SIZE);
  STORE(footer, total_size);

  // Initialize the new heap footer.
  STORE(PADD(addBlock, total_size), make_status(0, 0, USED_BIT));

  // Add the newly add block to free list and coalesce
  addFree(addBlock);

  // Coalesce in the case we left off on a free block
  coalesce(addBlock);

  // Success.
  return 1;
}


/* ALLOCATOR INTERFACE ************************************************\

   The functions {mm_init, mm_malloc, mm_free} constitute the
   interface to the memory allocator.

\**********************************************************************/

/* Initialize the memory allocator and heap. */
int mm_init() {
  // Initial heap size is one page.

  // Request min block size, which is: heap header/footer and min_block_size:
  //size_t minSize = WORD_SIZE*2 + MIN_BLOCK_SIZE;
  void* mem_sbrk_result = mem_sbrk(mem_pagesize());
  if ((long)mem_sbrk_result == -1) {
    fprintf(stderr, "       in mm_init, returning\n");
    return 1;
  }

  // Size of block = heap size - header word - footer word
  size_t block_size = ((char*)HEAP_FOOTER_ADDR) - ((char*)ORIGIN_BLOCK_ADDR);
  
  // Initialize our first free block
  BlockHeader *first_block = (BlockHeader*)ORIGIN_BLOCK_ADDR;
  
  // Block header: indicate that predecessor is used to avoid
  // coalescing beyond start of heap.
  first_block->status = make_status(block_size, PRED_USED_BIT, 0);
  // Set succ and pred block pointers to null, since nothing is there yet
  first_block->next = NULL;
  first_block->prev = NULL;

  // Block footer: store only size.
  STORE(PADD(ORIGIN_BLOCK_ADDR, block_size - WORD_SIZE), block_size);

  // Heap footer: masquerade as 0-size allocated block.
  STORE(HEAP_FOOTER_ADDR, make_status(0, 0, USED_BIT));

  // Head is now pointing to the first block we intialized
  FREE_LIST_HEAD = first_block;
  
  return 0;
}


/* Allocate a block of size bytes and return a pointer to its payload. */
void* mm_malloc(size_t payload_size) {
  // Empty payloads not allowed.
  if (payload_size == 0) {
    return NULL;
  }

  // Minimum block size to support the requested payload.
  // Best case: payload + header.
  size_t ideal_block_size = payload_size + WORD_SIZE;
  if (ideal_block_size <= MIN_BLOCK_SIZE) {
    // Block must be at least minimum size.
    ideal_block_size = MIN_BLOCK_SIZE;
  } else {
    // Block size must be aligned. Round up as needed.
    ideal_block_size = ALIGNMENT * ((ideal_block_size + ALIGNMENT - 1) / ALIGNMENT);
  }

  // Search for a suitable free block.
  BlockHeader* block = search(ideal_block_size);
  // If none found, extend the heap and search again.
  if (block == NULL) {
    if (extend_heap(ideal_block_size)) {
      block = search(ideal_block_size);
      assert(block != NULL
             && "search must yield a (non-NULL) block in this case");
    } else {
      // Ran out of memory.
      return NULL;
    }
  }

  // Allocate the selected free block, targeting the ideal size.
  allocate(block, ideal_block_size);

  // Return the block's payload address.
  return PADD(block, WORD_SIZE);
}


/* Free the allocated-but-not-yet-freed block whose payload is
   referenced by payload_pointer. */
void mm_free(void* payload_pointer) {

  // Move the pointer back one so that we go from payload to header
    BlockHeader* block = (BlockHeader*)PSUB(payload_pointer, WORD_SIZE);
  // Get the size of the header and save in variable
    size_t size = status_size(block->status);
  // Get footer
    word_t* footer = PADD(block, size - WORD_SIZE);

  // Deallocate the block by changing last bit of header to 0, which is free and
    word_t header = block->status;
    block->status = make_status(size, header, 0);

  // Update footer with size of block, since it the footer isn't there when allocated
    STORE(footer, size);

  // Change the pred. alloc status of the succ block to free (b/c current block will be free)
    word_t* successor = PADD(block, size);
    word_t successor_header = LOAD(successor);
        STORE(successor,
              make_status(successor_header, 0, successor_header));

  // Add our newly free block to the free list
  addFree(block);

  // Coalesce if necessary
  coalesce(block);
}

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
  if ((size == 0) && (ptr != NULL)) {
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
    cursor_ptr = PADD(cursor_ptr, WORD_SIZE);
    cursor_final = PADD(cursor_final, WORD_SIZE);
    STORE(cursor_final, LOAD(cursor_ptr));
  }
  // and finally, free the original pointer because we are no longer using it
  mm_free(ptr);
  return final;
}

