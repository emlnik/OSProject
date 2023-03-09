

#ifndef PROJECT_BASE_V1_0_SCHEDULER_HPP
#define PROJECT_BASE_V1_0_SCHEDULER_HPP

#include "queue.hpp"


class TCB;
class Scheduler{
private:
    static Queue<TCB> readyQueue;
public:
    static TCB *get();

    static void put(TCB *tcb);
};

#endif //PROJECT_BASE_V1_0_SCHEDULER_HPP
