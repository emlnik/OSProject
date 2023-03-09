
#include "../h/scheduler.hpp"

Queue<TCB>Scheduler::readyQueue;

TCB *Scheduler::get() {
    return readyQueue.izbrisiPrvi();
}

void Scheduler::put(TCB *tcb) {
    readyQueue.dodaj(tcb);
}