
#ifndef PROJECT_BASE_V1_0_SYSCALL_C_HPP
#define PROJECT_BASE_V1_0_SYSCALL_C_HPP

#include "../h/tcb.hpp"
#include "../lib/hw.h"
#include "SCB.hpp"

void* mem_alloc (size_t size);

int mem_free (void* addr);

class TCB;
typedef TCB* thread_t;
int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg);

int thread_exit ();

int getThreadId();
void kill(thread_t T);

void thread_dispatch ();

void exit();

void init();

void join(thread_t t);

const int EOF = -1;
char getc ();

void putc (char c);

class SCB;
typedef SCB* sem_t;
int sem_open (sem_t* handle, unsigned init);

int sem_close (sem_t handle);

int sem_wait (sem_t id);

int sem_signal (sem_t id);




#endif //PROJECT_BASE_V1_0_SYSCALL_C_HPP
