

#ifndef SCB_HPP
#define SCB_HPP
#include "syscall_cpp.hpp"
#include "queue.hpp"
#include "tcb.hpp"

class TCB;
class Semaphore;
class SCB{

public:
    friend class Semaphore;
    friend class TCB;
    int wait();
    int signal();
    SCB(int init = 1);
    static SCB* createSCB(int init);
    ~SCB();
    int val() const;
    void *operator new(uint64 n) {
        return MemoryAllocator::memAlloc(n);
    }

    void operator delete(void *ptr) {
        MemoryAllocator::memFree(ptr);
    }

    void *operator new[](uint64 n) {
        return MemoryAllocator::memAlloc(n);
    }

    void operator delete[](void *ptr) noexcept {
        MemoryAllocator::memFree(ptr);
    }


    void closeSem();
    Queue<TCB> waiting; //lista niti koje cekaju na semaforu



private:
    int ret;
    int value;

};

#endif
