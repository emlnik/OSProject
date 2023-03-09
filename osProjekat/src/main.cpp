

#include "../h/riscv.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/printing.hpp"
extern void userMain();
int main() {

    MemoryAllocator::memInit(); //inicijalizacija memorije

   Riscv::init();

    userMain();

  

    printString("Finished\n");
    exit();
    return 0;

}

