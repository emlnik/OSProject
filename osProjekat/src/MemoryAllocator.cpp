//
// Created by os on 7/3/22.
//


#include "../h/MemoryAllocator.hpp"

MemoryAllocator::Mem* MemoryAllocator::fmem_head;


void MemoryAllocator::memInit() {
    fmem_head=(MemoryAllocator::Mem*)HEAP_START_ADDR;
    fmem_head->next=nullptr;
    fmem_head->size=((size_t)HEAP_END_ADDR-((size_t)HEAP_START_ADDR));
    fmem_head->addr=(char*)HEAP_START_ADDR;
    fmem_head->free=1;

}

MemoryAllocator::Mem* getBF(size_t size) {

    uint64 min = 1000000000000000000;
   MemoryAllocator::Mem* tmp=MemoryAllocator::fmem_head;
   MemoryAllocator::Mem* bf= nullptr;
    while (tmp) {
        if (tmp->size == size && tmp->free==1) {
            return tmp;
        }
        if (tmp->size > size && tmp->free==1) {
            if ((tmp->size - size )< min) {
                min = tmp->size - size;
                bf = tmp;
            }
        }
        tmp = tmp->next;
    }
    return bf;
}

void *MemoryAllocator::memAlloc(size_t size) {
    if(fmem_head== nullptr|| size==0)
        return nullptr;
    void *res= nullptr;
    size_t size1=size+ sizeof(MemoryAllocator::Mem);
    MemoryAllocator::Mem* cur=fmem_head;

    if(size>MEM_BLOCK_SIZE)
        size1= (((size / MEM_BLOCK_SIZE) + 1) * MEM_BLOCK_SIZE) + sizeof(MemoryAllocator::Mem);
    else

        size1 = MEM_BLOCK_SIZE + sizeof(MemoryAllocator::Mem);

   while(((cur->size<size1)||(cur->free==0))&& cur->next!= nullptr){
        cur=cur->next;
  }

    if(cur->size>=size1){
        if(cur->size-size1<=sizeof(MemoryAllocator::Mem)){ //ako smanjenjem ovog fragmenta, ostane manje ili jednako od velicine zaglavlja, onda cu da
            //alociram ceo taj fragment
            cur->free=0;
            res=(void*)(cur->addr+sizeof (MemoryAllocator::Mem));
        }
        else {
            //delim blok na dva dela
            MemoryAllocator::Mem *newFrag= (MemoryAllocator::Mem *) (cur->addr+cur->size-size1);//postavim se nakon trenutnog koji sam nasla da je odgovarajuciS
            cur->size -= size1;
            cur->next = newFrag;
            newFrag->next = cur->next;
            newFrag->size = size1;
            newFrag->addr=(cur->addr+cur->size); //racuna i zaglavlje
            newFrag->free = 0;

            res = (void *) (newFrag->addr + sizeof(MemoryAllocator::Mem));
        }

   }

    return res;

}
void merge(MemoryAllocator::Mem* temp){

    if(temp== nullptr) return;
        if ((temp->free == 1) && (temp->next->free == 1) && temp->next && temp->addr + temp->size == temp->next->addr) {
            temp->size += (temp->next->size) + sizeof(MemoryAllocator::Mem);
            temp->next = temp->next->next;

        }

}

int MemoryAllocator::memFree(void *ptr)  {
    if(!ptr || !fmem_head || (char*)ptr<(char*)fmem_head)
        return -1;
    MemoryAllocator::Mem* cur=(MemoryAllocator::Mem*)((char*)ptr-sizeof(MemoryAllocator::Mem));
    if(cur==nullptr)
        return -10;
    cur->free=1;
    merge(cur);
    return 0;

}


