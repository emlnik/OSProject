
#ifndef PROJECT_BASE_V1_0_TCB_HPP
#define PROJECT_BASE_V1_0_TCB_HPP

#include "../lib/hw.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.hpp"
#include "SCB.hpp"
#include "../h/queue.hpp"

class Thread;
class SCB;
class TCB {

public:

        ~TCB() { if(stack) delete[]stack; }
        using Body = void (*)(void*);
        bool isFinished() const { return finished; }
        void setFinished(bool value) { finished = value; }
        void setBlocked(bool value){blocked=value;}
        bool isBlocked()const{return blocked;}
        bool isCreated()const{return created;}
        Body getBody()const{return body;}
        void* getArg()const{return arg;}
        int getId(){return id;}
        void setBody(void* arg){body(arg);}
        void start();
        static TCB *createThread(Body body, void *arg,void * stack);
        static void yield();
        static TCB *running;
        void join();

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
private:
        TCB(Body body,void *arg,uint64*stack);
        TCB(Body body,void* arg);
        friend class Riscv;
        friend class Thread;
        friend class SCB;
        struct Context { uint64 ra; uint64 sp; };
        Body body;
        void *arg;
        uint64 *stack;
        Context context;
        bool finished;
        bool blocked;
        bool created;
        int id;
        Queue<TCB> blockedThreads;




        static void threadWrapper();
        static void contextSwitch(Context *oldContext, Context *runningContext);
        static void dispatch();
        static void wrapper(void *arg);
        static bool checkBody();
        static bool checkArg();


        static uint64 constexpr STACK_SIZE = DEFAULT_STACK_SIZE;



};


#endif //PROJECT_BASE_V1_0_TCB_HPP
