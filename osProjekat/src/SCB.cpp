
#include "../h/SCB.hpp"
#include "../h/scheduler.hpp"



SCB::SCB(int init) {

   // waiting=new Queue<TCB>;
    value = init;

}
int SCB::val()const {
    return value;
}
SCB *SCB::createSCB(int init) {

    return new SCB(init);

}
SCB::~SCB() {
  //  waiting= nullptr;

}
int SCB::wait() {
    int ret = 1;
        if (--value<0) {
          TCB::running->setBlocked(true);
          waiting.dodaj(TCB::running);
          ret=0;
        }
        if(ret == 0)
           // thread_dispatch();
           TCB::dispatch();
    return ret;

}
int SCB::signal() {
   ret=1;
   TCB*t=nullptr;
    if(++value<=0) {
        t=waiting.izbrisiPrvi();
            t->setBlocked(false);
            Scheduler::put(t);
        ret = 0;
    }

    return ret;
}

void SCB::closeSem() {
    TCB*t= nullptr;
for(int i=0;i<waiting.getVel();i++) {
    t = waiting.izbrisiPrvi();
    if(t== nullptr) {
        return;
    }
        t->setBlocked(false);
        Scheduler::put(t);
}
}