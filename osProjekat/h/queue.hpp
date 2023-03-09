
#ifndef __QUEUE_H__
#define __QUEUE_H__
#include "../h/MemoryAllocator.hpp"

template<typename T>
class Queue{
private:
    struct Elem{
        T *tcb;
        Elem *sled;


        Elem(T *tcb){
            this->tcb=tcb;
            sled= nullptr;
        }
        void *operator new(uint64 n) {
           return MemoryAllocator::memAlloc(n);
        }

        void operator delete(void *ptr) {
            MemoryAllocator::memFree(ptr);
        }

        void *operator new[](uint64 n) {
            return MemoryAllocator::memAlloc(n);
        }

        void operator delete[](void *ptr) noexcept {
           MemoryAllocator::memFree(ptr);
        }

    };

    Elem *prvi, *posl;
    int vel;
public:
    Queue() : prvi(nullptr), posl(nullptr) {}

    Queue(const Queue<T> &) = delete;

    Queue<T> &operator=(const Queue<T> &) = delete;

    int getVel()const{return vel;}

    void dodajPrvi(T *tcb){
        Elem *elem = new Elem(tcb);
        vel++;
        prvi = elem;
        if(!posl){ posl=prvi;}
    }
    void dodaj(T *tcb){
        Elem* temp = 0;
        for (temp = prvi; temp; temp= temp->sled);
        if (temp != nullptr) return;
        if (prvi== nullptr) prvi= posl = new Elem(tcb);
        else posl = posl->sled = new Elem(tcb);
        vel++;

    }
    T *izbrisiPrvi(){
        T* ret = 0;
        if (prvi != nullptr) {

            Elem* temp = prvi;
            prvi=prvi->sled;
            if (prvi== nullptr)
                posl= nullptr;
            ret = temp->tcb;
            delete temp;
            vel--;

        }
        return ret;
    }
    T *getPrvi(){
        if(!prvi){ return nullptr; }
        return prvi->tcb;
    }
    T *rizbrisiPosl(){
        if(!prvi){ return nullptr; }

        Elem *prev = nullptr;
        for(Elem *curr = prvi; curr && curr != posl; curr = curr->sled){
            prev = curr;
        }

        Elem *elem = posl;
        if(prev){ prev->sled = nullptr; }
        else{ prvi = nullptr; }
        posl= prev;

        T *ret = elem->tcb;
        delete elem;
        vel--;
        return ret;
    }
    T *getPosl(){
        if(!posl){ return nullptr; }
        return posl->tcb;
    }
    T *izbrisiOdredjeni(T *tcb) {
        T *ret = 0;
        Elem *temp = prvi, *prev = nullptr;
        if (temp && temp->tcb == tcb) {

            prvi = prvi->sled;
            ret = temp->tcb;
            if (prvi == posl)
                posl = prvi = nullptr;
            vel--;
            delete temp;
            return ret;
        }
        while (temp && temp->tcb != tcb) {
            prev = temp;
            temp = temp->sled;
        }
        if (!temp) return nullptr;

        prev->sled = temp->sled;
        if (posl == temp)
            posl = prev;
        ret = temp->tcb;
        vel--;
        delete temp;

        return ret;
    }
};

#endif
