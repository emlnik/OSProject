#ifndef XV6_THREADS_CPP_API_TEST_HPP
#define XV6_THREADS_CPP_API_TEST_HPP

#include "../h/syscall_cpp.hpp"

#include "printing.hpp"

bool finishedA = false;
bool finishedB = false;
bool finishedC = false;

class WorkerA: public Thread {
    void workerBodyA(void* arg);
public:
    WorkerA():Thread() {}

    void run() override {
        workerBodyA(nullptr);
    }
};

class WorkerB: public Thread {
    void workerBodyB(void* arg);
public:
    WorkerB():Thread() {}

    void run() override {
        workerBodyB(nullptr);
    }
};

class WorkerC: public Thread {
    void workerBodyC(void* arg);
public:
    WorkerC():Thread() {}

    void run() override {
        workerBodyC(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    for (uint64 i = 0; i < 10; i++) {
        int id=getThreadId();
        printString("A: id="); printInt(id); printString("\n");
        for (uint64 j = 0; j < 5000; j++) {
            for (uint64 k = 0; k < 5000; k++) { /* busy wait */ }
           // thread_dispatch();
        }
    }
    printString("A finished!\n");
    finishedA = true;
}

void WorkerB::workerBodyB(void *arg) {
    for (uint64 i = 0; i < 10; i++) {
        int id=getThreadId();
        printString("B: id="); printInt(id); printString("\n");
        for (uint64 j = 0; j < 5000; j++) {
            for (uint64 k = 0; k < 5000; k++) { /* busy wait */ }
           // thread_dispatch();
        }
    }
    printString("B finished!\n");
    finishedB = true;
    //thread_dispatch();
}
void WorkerC::workerBodyC(void *arg) {
    for (uint64 i = 0; i < 10; i++) {
        int id=getThreadId();
        printString("C: id="); printInt(id); printString("\n");
        for (uint64 j = 0; j < 5000; j++) {
            for (uint64 k = 0; k < 5000; k++) { /* busy wait */ }
            // thread_dispatch();
        }
    }
    printString("C finished!\n");
    finishedC = true;
    //thread_dispatch();
}
void testID() {
    Thread* threads[3];
    threads[0] = new WorkerA();
    printString("ThreadA created\n");

    threads[1] = new WorkerB();
    printString("ThreadB created\n");

    threads[2] = new WorkerC();
    printString("ThreadC created\n");



    for(int i=0; i<3; i++) {
        threads[i]->start();
    }

    while (!(finishedA && finishedB && finishedC)) {
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }
}
#endif