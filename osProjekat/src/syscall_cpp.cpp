
#include "../h/syscall_cpp.hpp"
#include "../h/scheduler.hpp"

void *operator new(uint64 n) {
    return mem_alloc(n);
}

void operator delete(void *ptr) {
    mem_free(ptr);
}

void *operator new[](uint64 n) {
    return mem_alloc(n);
}

void operator delete[](void *ptr) noexcept {
    mem_free(ptr);
}

Thread::Thread(void (*body)(void *), void *arg) {
    myHandle=new TCB(body,arg);

}
Thread::Thread() {
    myHandle=new TCB(TCB::wrapper,this);
}

void Thread::dispatch() {
    thread_dispatch();
}
Thread::~Thread() noexcept {
        if (myHandle->isFinished()==true) {
            delete myHandle;
        }
    }



int Thread::start() {
    thread_create(&myHandle,myHandle->getBody(),myHandle->getArg());
    return 1;
}
Semaphore::Semaphore(unsigned int init) {

    sem_open(&myHandle, init);

}
Semaphore::~Semaphore() {
    sem_close(myHandle);
}

int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
}
