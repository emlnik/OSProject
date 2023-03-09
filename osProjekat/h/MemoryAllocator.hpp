
#ifndef PROJECT_BASE_V1_1_MEMORYALLOCATOR_H
#define PROJECT_BASE_V1_1_MEMORYALLOCATOR_H

#include "../lib/hw.h"

class MemoryAllocator {

public:
    struct Mem{
        Mem* next;
        size_t size;
        char* addr;
        int free;
    };

    static Mem* fmem_head; //glava slobodnih

    static void* memAlloc(size_t n);
    static int memFree(void* p);
    static void memInit();


};







#endif



