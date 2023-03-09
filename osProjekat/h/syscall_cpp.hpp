
#ifndef PROJECT_BASE_V1_0_SYSCALL_CPP_HPP
#define PROJECT_BASE_V1_0_SYSCALL_CPP_HPP

#include "syscall_c.hpp"
#include "tcb.hpp"

void* operator new (uint64 n);
void operator delete (void* p);


class SCB;
typedef SCB* sem_t;

class TCB;
typedef TCB* thread_t;

class Thread {
public:
    Thread (void (*body)(void*), void* arg);
    virtual ~Thread ();
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
private:
    thread_t myHandle;
    friend class TCB;
};
class Semaphore {
public:
    Semaphore (unsigned init = 1);
    virtual ~Semaphore ();
    int wait ();
    int signal ();

private:
    sem_t myHandle;
    friend class SCB;
};

class Console {
public:
    static char getc ();
    static void putc (char c);
};

#endif //PROJECT_BASE_V1_0_SYSCALL_CPP_HPP
