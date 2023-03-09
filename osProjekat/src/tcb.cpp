
#include "../h/printing.hpp"
#include "../h/scheduler.hpp"
#include "../h/riscv.hpp"

TCB *TCB::running = nullptr;
static int ID=0;

TCB::TCB(Body body,  void *arg,uint64*stack) {

    this->body=body;
    this->arg=arg;
    created=true;
    finished=false;
    blocked=false;
    id=++ID;

   this->stack=stack;
    if(body!= nullptr)
        Scheduler::put(this);
   context.ra=(uint64 ) &threadWrapper;
   context.sp= (uint64) &stack[STACK_SIZE];


}

TCB *TCB::createThread(Body body, void *arg,void*stack) {
    uint64* stackT=(uint64*)stack;
    TCB* temp=new TCB(body,arg,stackT);
    if(body== nullptr && arg== nullptr){
        TCB::running=temp;
    }

    return temp;
}
TCB::TCB(Body body,void* arg){
    this->body=body;
    this->arg=arg;
}

void TCB::start() {
    if(this->isCreated()==true){
        Scheduler::put(this);
    }
}

void TCB::dispatch() {
    TCB *old = running;
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
   running=Scheduler::get();
    while(running->isFinished()==true || running->isBlocked()==true){
        running=Scheduler::get();
    }

    TCB::contextSwitch(&old->context, &running->context);
}

void TCB::wrapper(void*arg){
    if(arg){
    ((Thread*)arg)->run();


}
}
bool TCB::checkBody() {
    if(running->getBody())
        return true;
    else return false;
}
bool TCB::checkArg() {
    if(running->getArg())
        return true;
    else return false;

}

void TCB::threadWrapper() {
    Riscv::popSppSpie();
    running->setBody(running->getArg());
 while(running->blockedThreads.getPrvi()){
      TCB* t=running->blockedThreads.izbrisiPrvi();
        t->setBlocked(false);
        Scheduler::put(t);
 }
thread_exit();

}
void TCB::join() {
    if(this==TCB::running|| this->isFinished()==true) {
        return;
    }

    TCB::running->setBlocked(true);
    blockedThreads.dodaj(TCB::running);

    TCB::dispatch();
}