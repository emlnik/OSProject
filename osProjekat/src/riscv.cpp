
#include "../h/kodoviInstr.h"
#include "../h/riscv.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/printing.hpp"
#include "../h/MemoryAllocator.hpp"

void Riscv::popSppSpie() {

    __asm__ volatile ("csrw sepc, ra");
    __asm__ volatile ("sret");
}

void Riscv::handleSupervisorTrap() {
    uint64 scause = r_scause();
    uint64 kod;

    __asm__ volatile("mv %0, a0" : "=r" (kod)); //koji je sistemski poziv
    if(kod==0x200 && scause==0x0000000000000009UL){
        uint64 sepc = r_sepc() + 4;
        uint64 sstatus = r_sstatus();

        sstatus=50;
        w_sepc(sepc);
        w_sstatus(sstatus);
    }


 else
    if(kod==0x201 && scause==0x0000000000000008UL){
        uint64 sepc = r_sepc() + 4;
        uint64 sstatus = r_sstatus();

        sstatus=51;
        w_sepc(sepc);
        w_sstatus(sstatus);
    }


    else if ((scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)) {
        // interrupt: no; cause code: environment call from U-mode(8)
        uint64 sepc = r_sepc() + 4;
        uint64 sstatus = r_sstatus();


        if (kod == MEMALLOC) {
            size_t size;
            void *ptr;
           __asm__ volatile("mv %0,a1" : "=r"(size)); //pokupi argument iz a1
           ptr= MemoryAllocator::memAlloc(size); //uzmi povratnu vrednost
            //ptr= __mem_alloc(size);
          __asm__ volatile("mv a0,%0"::"r"(ptr));


        } else if(kod==0x500){
            int id;
            id=TCB::running->getId();
            __asm__ volatile("mv a0,%0"::"r"(id));
        }else if(kod==0x501){
            thread_t t;
            __asm__ volatile("mv %0,a1":"=r"(t));
            t->setFinished(true);
        }else if(kod==0x61){
            thread_t  t;
            __asm__ volatile("mv %0,a1":"=r"(t));
            t->join();
        }else if (kod == MEMFREE) {
            void *ptr1;
            // int ret;
            __asm__ volatile("mv %0,a1": "=r"(ptr1));

            MemoryAllocator::memFree(ptr1); //stavlja odmah u a0


        } else if (kod == THRCRT) {
            TCB **handle;
            TCB::Body start_routine;
            void *arg;

            void* stack=MemoryAllocator::memAlloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
//nece da radi sa mv
            __asm__ volatile ("ld %0, 11 * 8(s0)":  "=r"(handle));
            __asm__ volatile ("ld %0, 12 * 8(s0)":  "=r"(start_routine));
            __asm__ volatile ("ld %0, 13 * 8(s0)":  "=r"(arg));


            //treba da zove create thread iz tcb
            *handle = TCB::createThread(start_routine, arg,stack);


        } else if (kod == THREXIT) {

            TCB::running->setFinished(true);

        } else if (kod == THRDSP) {

        } else if(kod==EXIT){
           // Riscv::mc_sstatus(Riscv::SSTATUS_SIE);
            delete TCB::running;
            __asm__ volatile("mv a0,%0"::"r"(0x201));
            __asm__ volatile("ecall");
        }else if (kod == SEMOPEN) {
            SCB **semHandle;
            unsigned semInit;
            __asm__ volatile ("ld %0, 11 * 8(s0)":  "=r"(semHandle));
            __asm__ volatile ("ld %0, 12 * 8(s0)":  "=r"(semInit));

            *semHandle = SCB::createSCB(semInit);
        } else if (kod == SEMCLOSE) {
            sem_t id;
            __asm__ volatile("mv %0, a1" : "=r" (id));

            id->closeSem();

            delete id;
        } else if (kod == SEMWAIT) {

            sem_t sem;
            __asm__ volatile("mv %0, a1" : "=r" (sem));

            sem->wait();

        } else if (kod == SEMSIGNAL) {

            sem_t sem;
            __asm__ volatile("mv %0,a1":"=r"(sem));

            sem->signal();

        } else if (kod == GETC) {
           // __getc();
           char c;
            c = __getc();
           __asm__ volatile("mv a0,%0"::"r"(c));

        } else if (kod == PUTC) {
            char c;
            __asm__ volatile("mv %0,a1":"=r"(c));
            __putc(c);
        }
     __asm__ volatile("sd a0,10*8(s0)");
        TCB::dispatch();
     w_sstatus(sstatus);
     w_sepc(sepc);

     return;
    }  else if (scause == 0x8000000000000001UL) {
        // interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)

        mc_sip(SIP_SSIP);
    } else if (scause == 0x8000000000000009UL) {
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        console_handler();
    }



}
void Riscv:: init() {
    w_stvec((uint64) &Riscv::supervisorTrap);
    ms_sstatus(Riscv::SSTATUS_SIE);
    __asm__ volatile("mv a0,%0"::"r"(0x200));
    __asm__ volatile("ecall");
    TCB* running;
    thread_create(&running, nullptr, nullptr);
 //   TCB::running = running;
   // ms_sstatus(Riscv::SSTATUS_SIE);
}



