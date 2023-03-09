
#include "../h/syscall_c.hpp"
#include "../h/kodoviInstr.h"
#include "../h/printing.hpp"
#include "../h/riscv.hpp"

void* mem_alloc (size_t size){

    void* ret;

    //u c sloju argumenti od a0
   __asm__ volatile("mv a1,%0"::"r"(size)); //ubacim u a1 zbog abi dela
  // __asm__ volatile ("mv a1,a0"); //pokupim argument size i upisem u a1 za abi sloj

    __asm__ volatile ("mv a0,%0" : : "r"(MEMALLOC)); //upisi kod sistemskog poziva u reg a0

    __asm__ volatile("ecall"); //prelazak u sistemski rezim

    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret)); //pokupim povratnu vrednost

    return ret;


}

void kill(thread_t t){
if(t==TCB::running){
    return;
}
    __asm__ volatile("mv a1,a0");
    __asm__ volatile("mv a0,%0"::"r"(0x501));
    __asm__ volatile("ecall");
}

int getThreadId(){
    __asm__ volatile("mv a0,%0"::"r"(0x500));
    __asm__ volatile("ecall");
    int id;
    __asm__ volatile("mv %0,a0":"=r"(id));
    return id;
}

void join(thread_t t){
    __asm__ volatile("mv a1,a0");
    __asm__ volatile("mv a0,%0"::"r"(0x61));
    __asm__ volatile("ecall");
}

int mem_free (void* addr){


    int ret;

  // __asm__ volatile("mv a1,%0"::"r"(addr)); //ubacim argument u a1 zbog abi dela
  __asm__ volatile("mv a1,a0"); //pokupim argument i upisem u a1 za abi deo

    __asm__ volatile ("mv a0,%0": : "r"(MEMFREE)); //kod sistemskog poziva u a0

    __asm__ volatile ("ecall");

    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret)); //povratna vrednost

    return ret;

}
int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg){

    int ret;
    asm volatile("mv a3, a2");
    asm volatile("mv a2, a1");
    asm volatile("mv a1, a0");
    asm volatile("mv a0, %0" : :  "r" (THRCRT));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    return ret;
}
void thread_dispatch (){

    __asm__ volatile("mv a0, %0" : : "r"(THRDSP)); //kod sistemskog poziva
    __asm__ volatile("ecall");
}
int thread_exit (){
    int ret;
    asm volatile("mv a0, %0" : :  "r" (THREXIT));
    __asm__ volatile ("ecall");
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    return ret;

}

void init(){
    __asm__ volatile("mv a0,%0"::"r"(INIT));
    __asm__ volatile("ecall");
}

void exit(){
    __asm__ volatile("mv a0,%0"::"r"(EXIT));
    __asm__ volatile("ecall");
}
char getc(){

   char c;
    __asm__ volatile("mv a0,%0": :"r"(GETC));
    __asm__ volatile("ecall");
    __asm__ volatile ("mv %[c], a0" : [c] "=r"(c));
    return c;


}
void putc(char c){

    __asm__ volatile("mv a1,a0");
    __asm__ volatile("mv a0,%0": : "r"(PUTC));
    __asm__ volatile("ecall");


}

int sem_open (sem_t* handle, unsigned init){


    int ret;

    __asm__ volatile("mv a2,a1"); //uzimanje argumenata
    __asm__ volatile("mv a1,a0");
    __asm__ volatile("mv a0, %0": : "r"(SEMOPEN));

    __asm__ volatile("ecall");

    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    return ret;

}
int sem_close (sem_t handle) {

    int ret;
    __asm__ volatile("mv a1,a0");
    __asm__ volatile("mv a0,%0": : "r"(SEMCLOSE));
    __asm__ volatile("ecall");
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    return ret;

}
int sem_wait (sem_t id) {

    int ret;
    __asm__ volatile("mv a1,a0");
    __asm__ volatile("mv a0,%0": : "r"(SEMWAIT));
    __asm__ volatile("ecall");
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    return ret;
}
int sem_signal (sem_t id) {

    int ret;
    __asm__ volatile("mv a1,a0");
    __asm__ volatile("mv a0,%0": : "r"(SEMSIGNAL));
    __asm__ volatile("ecall");
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    return ret;
}

