#ifndef XV6_THREADS_C_API_TEST_HPP
#define XV6_THREADS_C_API_TEST_HPP

#include "../h/syscall_c.hpp"

#include "printing.hpp"
bool flag=false;

void workerBodyA(void* arg) {
    for (uint64 i = 0; i < 10; i++) {
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
        }
    }
    printString("A finished!\n");

}
void workerBodyB(void* arg) {
    for (uint64 i = 0; i < 10; i++) {
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();


        }
        if(i==5) {

            flag = true;

            thread_dispatch();
        }
    }
    printString("b finished!\n");

}
void workerBodyC(void* arg) {
    for (uint64 i = 0; i < 10; i++) {
        printString("C: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
        }
    }
    printString("c finished!\n");

}

void testKill() {
    thread_t threads[3];
    thread_create(&threads[0], workerBodyA, nullptr);
    printString("ThreadA created\n");

    thread_create(&threads[1], workerBodyB, nullptr);
    printString("ThreadB created\n");

    thread_create(&threads[2], workerBodyC, nullptr);
    printString("ThreadC created\n");


    while (threads[0]->isFinished()==false || threads[1]->isFinished()==false || threads[2]->isFinished()==false) {
       // int i=0;

if(flag==true) {
    kill(threads[1]);
    thread_dispatch();
}
        thread_dispatch();

    }

}

#endif