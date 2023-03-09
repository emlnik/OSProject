
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	2f813103          	ld	sp,760(sp) # 800072f8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	498030ef          	jal	ra,800034b4 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleSupervisorTrapEv
    800010a4:	6a0010ef          	jal	ra,80002744 <_ZN5Riscv20handleSupervisorTrapEv>
  
    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010a8:	00013003          	ld	zero,0(sp)
    800010ac:	00813083          	ld	ra,8(sp)
    800010b0:	01013103          	ld	sp,16(sp)
    800010b4:	01813183          	ld	gp,24(sp)
    800010b8:	02013203          	ld	tp,32(sp)
    800010bc:	02813283          	ld	t0,40(sp)
    800010c0:	03013303          	ld	t1,48(sp)
    800010c4:	03813383          	ld	t2,56(sp)
    800010c8:	04013403          	ld	s0,64(sp)
    800010cc:	04813483          	ld	s1,72(sp)
    800010d0:	05013503          	ld	a0,80(sp)
    800010d4:	05813583          	ld	a1,88(sp)
    800010d8:	06013603          	ld	a2,96(sp)
    800010dc:	06813683          	ld	a3,104(sp)
    800010e0:	07013703          	ld	a4,112(sp)
    800010e4:	07813783          	ld	a5,120(sp)
    800010e8:	08013803          	ld	a6,128(sp)
    800010ec:	08813883          	ld	a7,136(sp)
    800010f0:	09013903          	ld	s2,144(sp)
    800010f4:	09813983          	ld	s3,152(sp)
    800010f8:	0a013a03          	ld	s4,160(sp)
    800010fc:	0a813a83          	ld	s5,168(sp)
    80001100:	0b013b03          	ld	s6,176(sp)
    80001104:	0b813b83          	ld	s7,184(sp)
    80001108:	0c013c03          	ld	s8,192(sp)
    8000110c:	0c813c83          	ld	s9,200(sp)
    80001110:	0d013d03          	ld	s10,208(sp)
    80001114:	0d813d83          	ld	s11,216(sp)
    80001118:	0e013e03          	ld	t3,224(sp)
    8000111c:	0e813e83          	ld	t4,232(sp)
    80001120:	0f013f03          	ld	t5,240(sp)
    80001124:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001128:	10010113          	addi	sp,sp,256

    sret
    8000112c:	10200073          	sret

0000000080001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001130:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001134:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001138:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000113c:	0085b103          	ld	sp,8(a1)

    ret
    80001140:	00008067          	ret

0000000080001144 <_Z9mem_allocm>:
#include "../h/syscall_c.hpp"
#include "../h/kodoviInstr.h"
#include "../h/printing.hpp"
#include "../h/riscv.hpp"

void* mem_alloc (size_t size){
    80001144:	ff010113          	addi	sp,sp,-16
    80001148:	00813423          	sd	s0,8(sp)
    8000114c:	01010413          	addi	s0,sp,16

    void* ret;

    //u c sloju argumenti od a0
   __asm__ volatile("mv a1,%0"::"r"(size)); //ubacim u a1 zbog abi dela
    80001150:	00050593          	mv	a1,a0
  // __asm__ volatile ("mv a1,a0"); //pokupim argument size i upisem u a1 za abi sloj

    __asm__ volatile ("mv a0,%0" : : "r"(MEMALLOC)); //upisi kod sistemskog poziva u reg a0
    80001154:	00100793          	li	a5,1
    80001158:	00078513          	mv	a0,a5

    __asm__ volatile("ecall"); //prelazak u sistemski rezim
    8000115c:	00000073          	ecall

    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret)); //pokupim povratnu vrednost
    80001160:	00050513          	mv	a0,a0

    return ret;


}
    80001164:	00813403          	ld	s0,8(sp)
    80001168:	01010113          	addi	sp,sp,16
    8000116c:	00008067          	ret

0000000080001170 <_Z4killP3TCB>:

void kill(thread_t t){
    80001170:	ff010113          	addi	sp,sp,-16
    80001174:	00813423          	sd	s0,8(sp)
    80001178:	01010413          	addi	s0,sp,16
if(t==TCB::running){
    8000117c:	00006797          	auipc	a5,0x6
    80001180:	1847b783          	ld	a5,388(a5) # 80007300 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001184:	0007b783          	ld	a5,0(a5)
    80001188:	00a78a63          	beq	a5,a0,8000119c <_Z4killP3TCB+0x2c>
    return;
}
    __asm__ volatile("mv a1,a0");
    8000118c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0,%0"::"r"(0x501));
    80001190:	50100793          	li	a5,1281
    80001194:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001198:	00000073          	ecall
}
    8000119c:	00813403          	ld	s0,8(sp)
    800011a0:	01010113          	addi	sp,sp,16
    800011a4:	00008067          	ret

00000000800011a8 <_Z11getThreadIdv>:

int getThreadId(){
    800011a8:	ff010113          	addi	sp,sp,-16
    800011ac:	00813423          	sd	s0,8(sp)
    800011b0:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a0,%0"::"r"(0x500));
    800011b4:	50000793          	li	a5,1280
    800011b8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800011bc:	00000073          	ecall
    int id;
    __asm__ volatile("mv %0,a0":"=r"(id));
    800011c0:	00050513          	mv	a0,a0
    return id;
}
    800011c4:	0005051b          	sext.w	a0,a0
    800011c8:	00813403          	ld	s0,8(sp)
    800011cc:	01010113          	addi	sp,sp,16
    800011d0:	00008067          	ret

00000000800011d4 <_Z4joinP3TCB>:

void join(thread_t t){
    800011d4:	ff010113          	addi	sp,sp,-16
    800011d8:	00813423          	sd	s0,8(sp)
    800011dc:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a1,a0");
    800011e0:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0,%0"::"r"(0x61));
    800011e4:	06100793          	li	a5,97
    800011e8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800011ec:	00000073          	ecall
}
    800011f0:	00813403          	ld	s0,8(sp)
    800011f4:	01010113          	addi	sp,sp,16
    800011f8:	00008067          	ret

00000000800011fc <_Z8mem_freePv>:

int mem_free (void* addr){
    800011fc:	ff010113          	addi	sp,sp,-16
    80001200:	00813423          	sd	s0,8(sp)
    80001204:	01010413          	addi	s0,sp,16


    int ret;

  // __asm__ volatile("mv a1,%0"::"r"(addr)); //ubacim argument u a1 zbog abi dela
  __asm__ volatile("mv a1,a0"); //pokupim argument i upisem u a1 za abi deo
    80001208:	00050593          	mv	a1,a0

    __asm__ volatile ("mv a0,%0": : "r"(MEMFREE)); //kod sistemskog poziva u a0
    8000120c:	00200793          	li	a5,2
    80001210:	00078513          	mv	a0,a5

    __asm__ volatile ("ecall");
    80001214:	00000073          	ecall

    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret)); //povratna vrednost
    80001218:	00050513          	mv	a0,a0

    return ret;

}
    8000121c:	0005051b          	sext.w	a0,a0
    80001220:	00813403          	ld	s0,8(sp)
    80001224:	01010113          	addi	sp,sp,16
    80001228:	00008067          	ret

000000008000122c <_Z13thread_createPP3TCBPFvPvES2_>:
int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg){
    8000122c:	ff010113          	addi	sp,sp,-16
    80001230:	00813423          	sd	s0,8(sp)
    80001234:	01010413          	addi	s0,sp,16

    int ret;
    asm volatile("mv a3, a2");
    80001238:	00060693          	mv	a3,a2
    asm volatile("mv a2, a1");
    8000123c:	00058613          	mv	a2,a1
    asm volatile("mv a1, a0");
    80001240:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : :  "r" (THRCRT));
    80001244:	00b00793          	li	a5,11
    80001248:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    8000124c:	00000073          	ecall
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    80001250:	00050513          	mv	a0,a0
    return ret;
}
    80001254:	0005051b          	sext.w	a0,a0
    80001258:	00813403          	ld	s0,8(sp)
    8000125c:	01010113          	addi	sp,sp,16
    80001260:	00008067          	ret

0000000080001264 <_Z15thread_dispatchv>:
void thread_dispatch (){
    80001264:	ff010113          	addi	sp,sp,-16
    80001268:	00813423          	sd	s0,8(sp)
    8000126c:	01010413          	addi	s0,sp,16

    __asm__ volatile("mv a0, %0" : : "r"(THRDSP)); //kod sistemskog poziva
    80001270:	00d00793          	li	a5,13
    80001274:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001278:	00000073          	ecall
}
    8000127c:	00813403          	ld	s0,8(sp)
    80001280:	01010113          	addi	sp,sp,16
    80001284:	00008067          	ret

0000000080001288 <_Z11thread_exitv>:
int thread_exit (){
    80001288:	ff010113          	addi	sp,sp,-16
    8000128c:	00813423          	sd	s0,8(sp)
    80001290:	01010413          	addi	s0,sp,16
    int ret;
    asm volatile("mv a0, %0" : :  "r" (THREXIT));
    80001294:	00c00793          	li	a5,12
    80001298:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    8000129c:	00000073          	ecall
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    800012a0:	00050513          	mv	a0,a0
    return ret;

}
    800012a4:	0005051b          	sext.w	a0,a0
    800012a8:	00813403          	ld	s0,8(sp)
    800012ac:	01010113          	addi	sp,sp,16
    800012b0:	00008067          	ret

00000000800012b4 <_Z4initv>:

void init(){
    800012b4:	ff010113          	addi	sp,sp,-16
    800012b8:	00813423          	sd	s0,8(sp)
    800012bc:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a0,%0"::"r"(INIT));
    800012c0:	03c00793          	li	a5,60
    800012c4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800012c8:	00000073          	ecall
}
    800012cc:	00813403          	ld	s0,8(sp)
    800012d0:	01010113          	addi	sp,sp,16
    800012d4:	00008067          	ret

00000000800012d8 <_Z4exitv>:

void exit(){
    800012d8:	ff010113          	addi	sp,sp,-16
    800012dc:	00813423          	sd	s0,8(sp)
    800012e0:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a0,%0"::"r"(EXIT));
    800012e4:	04600793          	li	a5,70
    800012e8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800012ec:	00000073          	ecall
}
    800012f0:	00813403          	ld	s0,8(sp)
    800012f4:	01010113          	addi	sp,sp,16
    800012f8:	00008067          	ret

00000000800012fc <_Z4getcv>:
char getc(){
    800012fc:	ff010113          	addi	sp,sp,-16
    80001300:	00813423          	sd	s0,8(sp)
    80001304:	01010413          	addi	s0,sp,16

   char c;
    __asm__ volatile("mv a0,%0": :"r"(GETC));
    80001308:	02900793          	li	a5,41
    8000130c:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001310:	00000073          	ecall
    __asm__ volatile ("mv %[c], a0" : [c] "=r"(c));
    80001314:	00050513          	mv	a0,a0
    return c;


}
    80001318:	0ff57513          	andi	a0,a0,255
    8000131c:	00813403          	ld	s0,8(sp)
    80001320:	01010113          	addi	sp,sp,16
    80001324:	00008067          	ret

0000000080001328 <_Z4putcc>:
void putc(char c){
    80001328:	ff010113          	addi	sp,sp,-16
    8000132c:	00813423          	sd	s0,8(sp)
    80001330:	01010413          	addi	s0,sp,16

    __asm__ volatile("mv a1,a0");
    80001334:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0,%0": : "r"(PUTC));
    80001338:	02a00793          	li	a5,42
    8000133c:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001340:	00000073          	ecall


}
    80001344:	00813403          	ld	s0,8(sp)
    80001348:	01010113          	addi	sp,sp,16
    8000134c:	00008067          	ret

0000000080001350 <_Z8sem_openPP3SCBj>:

int sem_open (sem_t* handle, unsigned init){
    80001350:	ff010113          	addi	sp,sp,-16
    80001354:	00813423          	sd	s0,8(sp)
    80001358:	01010413          	addi	s0,sp,16


    int ret;

    __asm__ volatile("mv a2,a1"); //uzimanje argumenata
    8000135c:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1,a0");
    80001360:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0": : "r"(SEMOPEN));
    80001364:	01500793          	li	a5,21
    80001368:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    8000136c:	00000073          	ecall

    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    80001370:	00050513          	mv	a0,a0
    return ret;

}
    80001374:	0005051b          	sext.w	a0,a0
    80001378:	00813403          	ld	s0,8(sp)
    8000137c:	01010113          	addi	sp,sp,16
    80001380:	00008067          	ret

0000000080001384 <_Z9sem_closeP3SCB>:
int sem_close (sem_t handle) {
    80001384:	ff010113          	addi	sp,sp,-16
    80001388:	00813423          	sd	s0,8(sp)
    8000138c:	01010413          	addi	s0,sp,16

    int ret;
    __asm__ volatile("mv a1,a0");
    80001390:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0,%0": : "r"(SEMCLOSE));
    80001394:	01600793          	li	a5,22
    80001398:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    8000139c:	00000073          	ecall
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    800013a0:	00050513          	mv	a0,a0
    return ret;

}
    800013a4:	0005051b          	sext.w	a0,a0
    800013a8:	00813403          	ld	s0,8(sp)
    800013ac:	01010113          	addi	sp,sp,16
    800013b0:	00008067          	ret

00000000800013b4 <_Z8sem_waitP3SCB>:
int sem_wait (sem_t id) {
    800013b4:	ff010113          	addi	sp,sp,-16
    800013b8:	00813423          	sd	s0,8(sp)
    800013bc:	01010413          	addi	s0,sp,16

    int ret;
    __asm__ volatile("mv a1,a0");
    800013c0:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0,%0": : "r"(SEMWAIT));
    800013c4:	01700793          	li	a5,23
    800013c8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800013cc:	00000073          	ecall
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    800013d0:	00050513          	mv	a0,a0
    return ret;
}
    800013d4:	0005051b          	sext.w	a0,a0
    800013d8:	00813403          	ld	s0,8(sp)
    800013dc:	01010113          	addi	sp,sp,16
    800013e0:	00008067          	ret

00000000800013e4 <_Z10sem_signalP3SCB>:
int sem_signal (sem_t id) {
    800013e4:	ff010113          	addi	sp,sp,-16
    800013e8:	00813423          	sd	s0,8(sp)
    800013ec:	01010413          	addi	s0,sp,16

    int ret;
    __asm__ volatile("mv a1,a0");
    800013f0:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0,%0": : "r"(SEMSIGNAL));
    800013f4:	01800793          	li	a5,24
    800013f8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800013fc:	00000073          	ecall
    __asm__ volatile ("mv %[ret], a0" : [ret] "=r"(ret));
    80001400:	00050513          	mv	a0,a0
    return ret;
}
    80001404:	0005051b          	sext.w	a0,a0
    80001408:	00813403          	ld	s0,8(sp)
    8000140c:	01010113          	addi	sp,sp,16
    80001410:	00008067          	ret

0000000080001414 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)){thread_dispatch();}
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0)){thread_dispatch();}

void printString(char const *string)
{
    80001414:	fe010113          	addi	sp,sp,-32
    80001418:	00113c23          	sd	ra,24(sp)
    8000141c:	00813823          	sd	s0,16(sp)
    80001420:	00913423          	sd	s1,8(sp)
    80001424:	02010413          	addi	s0,sp,32
    80001428:	00050493          	mv	s1,a0
    LOCK();
    8000142c:	00100613          	li	a2,1
    80001430:	00000593          	li	a1,0
    80001434:	00006517          	auipc	a0,0x6
    80001438:	f2c50513          	addi	a0,a0,-212 # 80007360 <lockPrint>
    8000143c:	00000097          	auipc	ra,0x0
    80001440:	bc4080e7          	jalr	-1084(ra) # 80001000 <copy_and_swap>
    80001444:	00050863          	beqz	a0,80001454 <_Z11printStringPKc+0x40>
    80001448:	00000097          	auipc	ra,0x0
    8000144c:	e1c080e7          	jalr	-484(ra) # 80001264 <_Z15thread_dispatchv>
    80001450:	fddff06f          	j	8000142c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80001454:	0004c503          	lbu	a0,0(s1)
    80001458:	00050a63          	beqz	a0,8000146c <_Z11printStringPKc+0x58>
    {
        putc(*string);
    8000145c:	00000097          	auipc	ra,0x0
    80001460:	ecc080e7          	jalr	-308(ra) # 80001328 <_Z4putcc>
        string++;
    80001464:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001468:	fedff06f          	j	80001454 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    8000146c:	00000613          	li	a2,0
    80001470:	00100593          	li	a1,1
    80001474:	00006517          	auipc	a0,0x6
    80001478:	eec50513          	addi	a0,a0,-276 # 80007360 <lockPrint>
    8000147c:	00000097          	auipc	ra,0x0
    80001480:	b84080e7          	jalr	-1148(ra) # 80001000 <copy_and_swap>
    80001484:	00050863          	beqz	a0,80001494 <_Z11printStringPKc+0x80>
    80001488:	00000097          	auipc	ra,0x0
    8000148c:	ddc080e7          	jalr	-548(ra) # 80001264 <_Z15thread_dispatchv>
    80001490:	fddff06f          	j	8000146c <_Z11printStringPKc+0x58>
}
    80001494:	01813083          	ld	ra,24(sp)
    80001498:	01013403          	ld	s0,16(sp)
    8000149c:	00813483          	ld	s1,8(sp)
    800014a0:	02010113          	addi	sp,sp,32
    800014a4:	00008067          	ret

00000000800014a8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800014a8:	fd010113          	addi	sp,sp,-48
    800014ac:	02113423          	sd	ra,40(sp)
    800014b0:	02813023          	sd	s0,32(sp)
    800014b4:	00913c23          	sd	s1,24(sp)
    800014b8:	01213823          	sd	s2,16(sp)
    800014bc:	01313423          	sd	s3,8(sp)
    800014c0:	01413023          	sd	s4,0(sp)
    800014c4:	03010413          	addi	s0,sp,48
    800014c8:	00050993          	mv	s3,a0
    800014cc:	00058a13          	mv	s4,a1
    LOCK();
    800014d0:	00100613          	li	a2,1
    800014d4:	00000593          	li	a1,0
    800014d8:	00006517          	auipc	a0,0x6
    800014dc:	e8850513          	addi	a0,a0,-376 # 80007360 <lockPrint>
    800014e0:	00000097          	auipc	ra,0x0
    800014e4:	b20080e7          	jalr	-1248(ra) # 80001000 <copy_and_swap>
    800014e8:	00050863          	beqz	a0,800014f8 <_Z9getStringPci+0x50>
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	d78080e7          	jalr	-648(ra) # 80001264 <_Z15thread_dispatchv>
    800014f4:	fddff06f          	j	800014d0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800014f8:	00000913          	li	s2,0
    800014fc:	00090493          	mv	s1,s2
    80001500:	0019091b          	addiw	s2,s2,1
    80001504:	03495a63          	bge	s2,s4,80001538 <_Z9getStringPci+0x90>
        cc = getc();
    80001508:	00000097          	auipc	ra,0x0
    8000150c:	df4080e7          	jalr	-524(ra) # 800012fc <_Z4getcv>
        if(cc < 1)
    80001510:	02050463          	beqz	a0,80001538 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80001514:	009984b3          	add	s1,s3,s1
    80001518:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000151c:	00a00793          	li	a5,10
    80001520:	00f50a63          	beq	a0,a5,80001534 <_Z9getStringPci+0x8c>
    80001524:	00d00793          	li	a5,13
    80001528:	fcf51ae3          	bne	a0,a5,800014fc <_Z9getStringPci+0x54>
        buf[i++] = c;
    8000152c:	00090493          	mv	s1,s2
    80001530:	0080006f          	j	80001538 <_Z9getStringPci+0x90>
    80001534:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80001538:	009984b3          	add	s1,s3,s1
    8000153c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80001540:	00000613          	li	a2,0
    80001544:	00100593          	li	a1,1
    80001548:	00006517          	auipc	a0,0x6
    8000154c:	e1850513          	addi	a0,a0,-488 # 80007360 <lockPrint>
    80001550:	00000097          	auipc	ra,0x0
    80001554:	ab0080e7          	jalr	-1360(ra) # 80001000 <copy_and_swap>
    80001558:	00050863          	beqz	a0,80001568 <_Z9getStringPci+0xc0>
    8000155c:	00000097          	auipc	ra,0x0
    80001560:	d08080e7          	jalr	-760(ra) # 80001264 <_Z15thread_dispatchv>
    80001564:	fddff06f          	j	80001540 <_Z9getStringPci+0x98>
    return buf;
}
    80001568:	00098513          	mv	a0,s3
    8000156c:	02813083          	ld	ra,40(sp)
    80001570:	02013403          	ld	s0,32(sp)
    80001574:	01813483          	ld	s1,24(sp)
    80001578:	01013903          	ld	s2,16(sp)
    8000157c:	00813983          	ld	s3,8(sp)
    80001580:	00013a03          	ld	s4,0(sp)
    80001584:	03010113          	addi	sp,sp,48
    80001588:	00008067          	ret

000000008000158c <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000158c:	ff010113          	addi	sp,sp,-16
    80001590:	00813423          	sd	s0,8(sp)
    80001594:	01010413          	addi	s0,sp,16
    80001598:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000159c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800015a0:	0006c603          	lbu	a2,0(a3)
    800015a4:	fd06071b          	addiw	a4,a2,-48
    800015a8:	0ff77713          	andi	a4,a4,255
    800015ac:	00900793          	li	a5,9
    800015b0:	02e7e063          	bltu	a5,a4,800015d0 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800015b4:	0025179b          	slliw	a5,a0,0x2
    800015b8:	00a787bb          	addw	a5,a5,a0
    800015bc:	0017979b          	slliw	a5,a5,0x1
    800015c0:	00168693          	addi	a3,a3,1
    800015c4:	00c787bb          	addw	a5,a5,a2
    800015c8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800015cc:	fd5ff06f          	j	800015a0 <_Z11stringToIntPKc+0x14>
    return n;
}
    800015d0:	00813403          	ld	s0,8(sp)
    800015d4:	01010113          	addi	sp,sp,16
    800015d8:	00008067          	ret

00000000800015dc <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800015dc:	fc010113          	addi	sp,sp,-64
    800015e0:	02113c23          	sd	ra,56(sp)
    800015e4:	02813823          	sd	s0,48(sp)
    800015e8:	02913423          	sd	s1,40(sp)
    800015ec:	03213023          	sd	s2,32(sp)
    800015f0:	01313c23          	sd	s3,24(sp)
    800015f4:	04010413          	addi	s0,sp,64
    800015f8:	00050493          	mv	s1,a0
    800015fc:	00058913          	mv	s2,a1
    80001600:	00060993          	mv	s3,a2
    LOCK();
    80001604:	00100613          	li	a2,1
    80001608:	00000593          	li	a1,0
    8000160c:	00006517          	auipc	a0,0x6
    80001610:	d5450513          	addi	a0,a0,-684 # 80007360 <lockPrint>
    80001614:	00000097          	auipc	ra,0x0
    80001618:	9ec080e7          	jalr	-1556(ra) # 80001000 <copy_and_swap>
    8000161c:	00050863          	beqz	a0,8000162c <_Z8printIntiii+0x50>
    80001620:	00000097          	auipc	ra,0x0
    80001624:	c44080e7          	jalr	-956(ra) # 80001264 <_Z15thread_dispatchv>
    80001628:	fddff06f          	j	80001604 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000162c:	00098463          	beqz	s3,80001634 <_Z8printIntiii+0x58>
    80001630:	0804c463          	bltz	s1,800016b8 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001634:	0004851b          	sext.w	a0,s1
    neg = 0;
    80001638:	00000593          	li	a1,0
    }

    i = 0;
    8000163c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001640:	0009079b          	sext.w	a5,s2
    80001644:	0325773b          	remuw	a4,a0,s2
    80001648:	00048613          	mv	a2,s1
    8000164c:	0014849b          	addiw	s1,s1,1
    80001650:	02071693          	slli	a3,a4,0x20
    80001654:	0206d693          	srli	a3,a3,0x20
    80001658:	00006717          	auipc	a4,0x6
    8000165c:	c1870713          	addi	a4,a4,-1000 # 80007270 <digits>
    80001660:	00d70733          	add	a4,a4,a3
    80001664:	00074683          	lbu	a3,0(a4)
    80001668:	fd040713          	addi	a4,s0,-48
    8000166c:	00c70733          	add	a4,a4,a2
    80001670:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80001674:	0005071b          	sext.w	a4,a0
    80001678:	0325553b          	divuw	a0,a0,s2
    8000167c:	fcf772e3          	bgeu	a4,a5,80001640 <_Z8printIntiii+0x64>
    if(neg)
    80001680:	00058c63          	beqz	a1,80001698 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80001684:	fd040793          	addi	a5,s0,-48
    80001688:	009784b3          	add	s1,a5,s1
    8000168c:	02d00793          	li	a5,45
    80001690:	fef48823          	sb	a5,-16(s1)
    80001694:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001698:	fff4849b          	addiw	s1,s1,-1
    8000169c:	0204c863          	bltz	s1,800016cc <_Z8printIntiii+0xf0>
        putc(buf[i]);
    800016a0:	fd040793          	addi	a5,s0,-48
    800016a4:	009787b3          	add	a5,a5,s1
    800016a8:	ff07c503          	lbu	a0,-16(a5)
    800016ac:	00000097          	auipc	ra,0x0
    800016b0:	c7c080e7          	jalr	-900(ra) # 80001328 <_Z4putcc>
    800016b4:	fe5ff06f          	j	80001698 <_Z8printIntiii+0xbc>
        x = -xx;
    800016b8:	4090053b          	negw	a0,s1
        neg = 1;
    800016bc:	00100593          	li	a1,1
        x = -xx;
    800016c0:	f7dff06f          	j	8000163c <_Z8printIntiii+0x60>

    UNLOCK();
    800016c4:	00000097          	auipc	ra,0x0
    800016c8:	ba0080e7          	jalr	-1120(ra) # 80001264 <_Z15thread_dispatchv>
    800016cc:	00000613          	li	a2,0
    800016d0:	00100593          	li	a1,1
    800016d4:	00006517          	auipc	a0,0x6
    800016d8:	c8c50513          	addi	a0,a0,-884 # 80007360 <lockPrint>
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	924080e7          	jalr	-1756(ra) # 80001000 <copy_and_swap>
    800016e4:	fe0510e3          	bnez	a0,800016c4 <_Z8printIntiii+0xe8>
    800016e8:	03813083          	ld	ra,56(sp)
    800016ec:	03013403          	ld	s0,48(sp)
    800016f0:	02813483          	ld	s1,40(sp)
    800016f4:	02013903          	ld	s2,32(sp)
    800016f8:	01813983          	ld	s3,24(sp)
    800016fc:	04010113          	addi	sp,sp,64
    80001700:	00008067          	ret

0000000080001704 <_ZN9BufferCPPC1Ei>:
#include "../h/buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80001704:	fd010113          	addi	sp,sp,-48
    80001708:	02113423          	sd	ra,40(sp)
    8000170c:	02813023          	sd	s0,32(sp)
    80001710:	00913c23          	sd	s1,24(sp)
    80001714:	01213823          	sd	s2,16(sp)
    80001718:	01313423          	sd	s3,8(sp)
    8000171c:	03010413          	addi	s0,sp,48
    80001720:	00050493          	mv	s1,a0
    80001724:	00058913          	mv	s2,a1
    80001728:	0015879b          	addiw	a5,a1,1
    8000172c:	0007851b          	sext.w	a0,a5
    80001730:	00f4a023          	sw	a5,0(s1)
    80001734:	0004a823          	sw	zero,16(s1)
    80001738:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000173c:	00251513          	slli	a0,a0,0x2
    80001740:	00000097          	auipc	ra,0x0
    80001744:	a04080e7          	jalr	-1532(ra) # 80001144 <_Z9mem_allocm>
    80001748:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    8000174c:	01000513          	li	a0,16
    80001750:	00001097          	auipc	ra,0x1
    80001754:	bdc080e7          	jalr	-1060(ra) # 8000232c <_Znwm>
    80001758:	00050993          	mv	s3,a0
    8000175c:	00000593          	li	a1,0
    80001760:	00001097          	auipc	ra,0x1
    80001764:	ecc080e7          	jalr	-308(ra) # 8000262c <_ZN9SemaphoreC1Ej>
    80001768:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000176c:	01000513          	li	a0,16
    80001770:	00001097          	auipc	ra,0x1
    80001774:	bbc080e7          	jalr	-1092(ra) # 8000232c <_Znwm>
    80001778:	00050993          	mv	s3,a0
    8000177c:	00090593          	mv	a1,s2
    80001780:	00001097          	auipc	ra,0x1
    80001784:	eac080e7          	jalr	-340(ra) # 8000262c <_ZN9SemaphoreC1Ej>
    80001788:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    8000178c:	01000513          	li	a0,16
    80001790:	00001097          	auipc	ra,0x1
    80001794:	b9c080e7          	jalr	-1124(ra) # 8000232c <_Znwm>
    80001798:	00050913          	mv	s2,a0
    8000179c:	00100593          	li	a1,1
    800017a0:	00001097          	auipc	ra,0x1
    800017a4:	e8c080e7          	jalr	-372(ra) # 8000262c <_ZN9SemaphoreC1Ej>
    800017a8:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800017ac:	01000513          	li	a0,16
    800017b0:	00001097          	auipc	ra,0x1
    800017b4:	b7c080e7          	jalr	-1156(ra) # 8000232c <_Znwm>
    800017b8:	00050913          	mv	s2,a0
    800017bc:	00100593          	li	a1,1
    800017c0:	00001097          	auipc	ra,0x1
    800017c4:	e6c080e7          	jalr	-404(ra) # 8000262c <_ZN9SemaphoreC1Ej>
    800017c8:	0324b823          	sd	s2,48(s1)
}
    800017cc:	02813083          	ld	ra,40(sp)
    800017d0:	02013403          	ld	s0,32(sp)
    800017d4:	01813483          	ld	s1,24(sp)
    800017d8:	01013903          	ld	s2,16(sp)
    800017dc:	00813983          	ld	s3,8(sp)
    800017e0:	03010113          	addi	sp,sp,48
    800017e4:	00008067          	ret
    800017e8:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800017ec:	00098513          	mv	a0,s3
    800017f0:	00001097          	auipc	ra,0x1
    800017f4:	b64080e7          	jalr	-1180(ra) # 80002354 <_ZdlPv>
    800017f8:	00048513          	mv	a0,s1
    800017fc:	00007097          	auipc	ra,0x7
    80001800:	c7c080e7          	jalr	-900(ra) # 80008478 <_Unwind_Resume>
    80001804:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80001808:	00098513          	mv	a0,s3
    8000180c:	00001097          	auipc	ra,0x1
    80001810:	b48080e7          	jalr	-1208(ra) # 80002354 <_ZdlPv>
    80001814:	00048513          	mv	a0,s1
    80001818:	00007097          	auipc	ra,0x7
    8000181c:	c60080e7          	jalr	-928(ra) # 80008478 <_Unwind_Resume>
    80001820:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80001824:	00090513          	mv	a0,s2
    80001828:	00001097          	auipc	ra,0x1
    8000182c:	b2c080e7          	jalr	-1236(ra) # 80002354 <_ZdlPv>
    80001830:	00048513          	mv	a0,s1
    80001834:	00007097          	auipc	ra,0x7
    80001838:	c44080e7          	jalr	-956(ra) # 80008478 <_Unwind_Resume>
    8000183c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80001840:	00090513          	mv	a0,s2
    80001844:	00001097          	auipc	ra,0x1
    80001848:	b10080e7          	jalr	-1264(ra) # 80002354 <_ZdlPv>
    8000184c:	00048513          	mv	a0,s1
    80001850:	00007097          	auipc	ra,0x7
    80001854:	c28080e7          	jalr	-984(ra) # 80008478 <_Unwind_Resume>

0000000080001858 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80001858:	fe010113          	addi	sp,sp,-32
    8000185c:	00113c23          	sd	ra,24(sp)
    80001860:	00813823          	sd	s0,16(sp)
    80001864:	00913423          	sd	s1,8(sp)
    80001868:	01213023          	sd	s2,0(sp)
    8000186c:	02010413          	addi	s0,sp,32
    80001870:	00050493          	mv	s1,a0
    80001874:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80001878:	01853503          	ld	a0,24(a0)
    8000187c:	00001097          	auipc	ra,0x1
    80001880:	de8080e7          	jalr	-536(ra) # 80002664 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80001884:	0304b503          	ld	a0,48(s1)
    80001888:	00001097          	auipc	ra,0x1
    8000188c:	ddc080e7          	jalr	-548(ra) # 80002664 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80001890:	0084b783          	ld	a5,8(s1)
    80001894:	0144a703          	lw	a4,20(s1)
    80001898:	00271713          	slli	a4,a4,0x2
    8000189c:	00e787b3          	add	a5,a5,a4
    800018a0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800018a4:	0144a783          	lw	a5,20(s1)
    800018a8:	0017879b          	addiw	a5,a5,1
    800018ac:	0004a703          	lw	a4,0(s1)
    800018b0:	02e7e7bb          	remw	a5,a5,a4
    800018b4:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800018b8:	0304b503          	ld	a0,48(s1)
    800018bc:	00001097          	auipc	ra,0x1
    800018c0:	dd4080e7          	jalr	-556(ra) # 80002690 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800018c4:	0204b503          	ld	a0,32(s1)
    800018c8:	00001097          	auipc	ra,0x1
    800018cc:	dc8080e7          	jalr	-568(ra) # 80002690 <_ZN9Semaphore6signalEv>

}
    800018d0:	01813083          	ld	ra,24(sp)
    800018d4:	01013403          	ld	s0,16(sp)
    800018d8:	00813483          	ld	s1,8(sp)
    800018dc:	00013903          	ld	s2,0(sp)
    800018e0:	02010113          	addi	sp,sp,32
    800018e4:	00008067          	ret

00000000800018e8 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800018e8:	fe010113          	addi	sp,sp,-32
    800018ec:	00113c23          	sd	ra,24(sp)
    800018f0:	00813823          	sd	s0,16(sp)
    800018f4:	00913423          	sd	s1,8(sp)
    800018f8:	01213023          	sd	s2,0(sp)
    800018fc:	02010413          	addi	s0,sp,32
    80001900:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80001904:	02053503          	ld	a0,32(a0)
    80001908:	00001097          	auipc	ra,0x1
    8000190c:	d5c080e7          	jalr	-676(ra) # 80002664 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80001910:	0284b503          	ld	a0,40(s1)
    80001914:	00001097          	auipc	ra,0x1
    80001918:	d50080e7          	jalr	-688(ra) # 80002664 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000191c:	0084b703          	ld	a4,8(s1)
    80001920:	0104a783          	lw	a5,16(s1)
    80001924:	00279693          	slli	a3,a5,0x2
    80001928:	00d70733          	add	a4,a4,a3
    8000192c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80001930:	0017879b          	addiw	a5,a5,1
    80001934:	0004a703          	lw	a4,0(s1)
    80001938:	02e7e7bb          	remw	a5,a5,a4
    8000193c:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80001940:	0284b503          	ld	a0,40(s1)
    80001944:	00001097          	auipc	ra,0x1
    80001948:	d4c080e7          	jalr	-692(ra) # 80002690 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000194c:	0184b503          	ld	a0,24(s1)
    80001950:	00001097          	auipc	ra,0x1
    80001954:	d40080e7          	jalr	-704(ra) # 80002690 <_ZN9Semaphore6signalEv>

    return ret;
}
    80001958:	00090513          	mv	a0,s2
    8000195c:	01813083          	ld	ra,24(sp)
    80001960:	01013403          	ld	s0,16(sp)
    80001964:	00813483          	ld	s1,8(sp)
    80001968:	00013903          	ld	s2,0(sp)
    8000196c:	02010113          	addi	sp,sp,32
    80001970:	00008067          	ret

0000000080001974 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80001974:	fe010113          	addi	sp,sp,-32
    80001978:	00113c23          	sd	ra,24(sp)
    8000197c:	00813823          	sd	s0,16(sp)
    80001980:	00913423          	sd	s1,8(sp)
    80001984:	01213023          	sd	s2,0(sp)
    80001988:	02010413          	addi	s0,sp,32
    8000198c:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80001990:	02853503          	ld	a0,40(a0)
    80001994:	00001097          	auipc	ra,0x1
    80001998:	cd0080e7          	jalr	-816(ra) # 80002664 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000199c:	0304b503          	ld	a0,48(s1)
    800019a0:	00001097          	auipc	ra,0x1
    800019a4:	cc4080e7          	jalr	-828(ra) # 80002664 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800019a8:	0144a783          	lw	a5,20(s1)
    800019ac:	0104a903          	lw	s2,16(s1)
    800019b0:	0327ce63          	blt	a5,s2,800019ec <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800019b4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800019b8:	0304b503          	ld	a0,48(s1)
    800019bc:	00001097          	auipc	ra,0x1
    800019c0:	cd4080e7          	jalr	-812(ra) # 80002690 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800019c4:	0284b503          	ld	a0,40(s1)
    800019c8:	00001097          	auipc	ra,0x1
    800019cc:	cc8080e7          	jalr	-824(ra) # 80002690 <_ZN9Semaphore6signalEv>

    return ret;
}
    800019d0:	00090513          	mv	a0,s2
    800019d4:	01813083          	ld	ra,24(sp)
    800019d8:	01013403          	ld	s0,16(sp)
    800019dc:	00813483          	ld	s1,8(sp)
    800019e0:	00013903          	ld	s2,0(sp)
    800019e4:	02010113          	addi	sp,sp,32
    800019e8:	00008067          	ret
        ret = cap - head + tail;
    800019ec:	0004a703          	lw	a4,0(s1)
    800019f0:	4127093b          	subw	s2,a4,s2
    800019f4:	00f9093b          	addw	s2,s2,a5
    800019f8:	fc1ff06f          	j	800019b8 <_ZN9BufferCPP6getCntEv+0x44>

00000000800019fc <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800019fc:	fe010113          	addi	sp,sp,-32
    80001a00:	00113c23          	sd	ra,24(sp)
    80001a04:	00813823          	sd	s0,16(sp)
    80001a08:	00913423          	sd	s1,8(sp)
    80001a0c:	02010413          	addi	s0,sp,32
    80001a10:	00050493          	mv	s1,a0
    Console::putc('\n');
    80001a14:	00a00513          	li	a0,10
    80001a18:	00001097          	auipc	ra,0x1
    80001a1c:	ccc080e7          	jalr	-820(ra) # 800026e4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80001a20:	00004517          	auipc	a0,0x4
    80001a24:	60050513          	addi	a0,a0,1536 # 80006020 <CONSOLE_STATUS+0x10>
    80001a28:	00000097          	auipc	ra,0x0
    80001a2c:	9ec080e7          	jalr	-1556(ra) # 80001414 <_Z11printStringPKc>
    while (getCnt()) {
    80001a30:	00048513          	mv	a0,s1
    80001a34:	00000097          	auipc	ra,0x0
    80001a38:	f40080e7          	jalr	-192(ra) # 80001974 <_ZN9BufferCPP6getCntEv>
    80001a3c:	02050c63          	beqz	a0,80001a74 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80001a40:	0084b783          	ld	a5,8(s1)
    80001a44:	0104a703          	lw	a4,16(s1)
    80001a48:	00271713          	slli	a4,a4,0x2
    80001a4c:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80001a50:	0007c503          	lbu	a0,0(a5)
    80001a54:	00001097          	auipc	ra,0x1
    80001a58:	c90080e7          	jalr	-880(ra) # 800026e4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80001a5c:	0104a783          	lw	a5,16(s1)
    80001a60:	0017879b          	addiw	a5,a5,1
    80001a64:	0004a703          	lw	a4,0(s1)
    80001a68:	02e7e7bb          	remw	a5,a5,a4
    80001a6c:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80001a70:	fc1ff06f          	j	80001a30 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80001a74:	02100513          	li	a0,33
    80001a78:	00001097          	auipc	ra,0x1
    80001a7c:	c6c080e7          	jalr	-916(ra) # 800026e4 <_ZN7Console4putcEc>
    Console::putc('\n');
    80001a80:	00a00513          	li	a0,10
    80001a84:	00001097          	auipc	ra,0x1
    80001a88:	c60080e7          	jalr	-928(ra) # 800026e4 <_ZN7Console4putcEc>
    mem_free(buffer);
    80001a8c:	0084b503          	ld	a0,8(s1)
    80001a90:	fffff097          	auipc	ra,0xfffff
    80001a94:	76c080e7          	jalr	1900(ra) # 800011fc <_Z8mem_freePv>
    delete itemAvailable;
    80001a98:	0204b503          	ld	a0,32(s1)
    80001a9c:	00050863          	beqz	a0,80001aac <_ZN9BufferCPPD1Ev+0xb0>
    80001aa0:	00053783          	ld	a5,0(a0)
    80001aa4:	0087b783          	ld	a5,8(a5)
    80001aa8:	000780e7          	jalr	a5
    delete spaceAvailable;
    80001aac:	0184b503          	ld	a0,24(s1)
    80001ab0:	00050863          	beqz	a0,80001ac0 <_ZN9BufferCPPD1Ev+0xc4>
    80001ab4:	00053783          	ld	a5,0(a0)
    80001ab8:	0087b783          	ld	a5,8(a5)
    80001abc:	000780e7          	jalr	a5
    delete mutexTail;
    80001ac0:	0304b503          	ld	a0,48(s1)
    80001ac4:	00050863          	beqz	a0,80001ad4 <_ZN9BufferCPPD1Ev+0xd8>
    80001ac8:	00053783          	ld	a5,0(a0)
    80001acc:	0087b783          	ld	a5,8(a5)
    80001ad0:	000780e7          	jalr	a5
    delete mutexHead;
    80001ad4:	0284b503          	ld	a0,40(s1)
    80001ad8:	00050863          	beqz	a0,80001ae8 <_ZN9BufferCPPD1Ev+0xec>
    80001adc:	00053783          	ld	a5,0(a0)
    80001ae0:	0087b783          	ld	a5,8(a5)
    80001ae4:	000780e7          	jalr	a5
}
    80001ae8:	01813083          	ld	ra,24(sp)
    80001aec:	01013403          	ld	s0,16(sp)
    80001af0:	00813483          	ld	s1,8(sp)
    80001af4:	02010113          	addi	sp,sp,32
    80001af8:	00008067          	ret

0000000080001afc <_Z11workerBodyAPv>:
#include "../h/syscall_c.hpp"

#include "printing.hpp"
thread_t threads[3];

void workerBodyA(void* arg) {
    80001afc:	fe010113          	addi	sp,sp,-32
    80001b00:	00113c23          	sd	ra,24(sp)
    80001b04:	00813823          	sd	s0,16(sp)
    80001b08:	00913423          	sd	s1,8(sp)
    80001b0c:	01213023          	sd	s2,0(sp)
    80001b10:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001b14:	00000913          	li	s2,0
    80001b18:	0380006f          	j	80001b50 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
             thread_dispatch();
    80001b1c:	fffff097          	auipc	ra,0xfffff
    80001b20:	748080e7          	jalr	1864(ra) # 80001264 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001b24:	00148493          	addi	s1,s1,1
    80001b28:	000027b7          	lui	a5,0x2
    80001b2c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001b30:	0097ee63          	bltu	a5,s1,80001b4c <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001b34:	00000713          	li	a4,0
    80001b38:	000077b7          	lui	a5,0x7
    80001b3c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001b40:	fce7eee3          	bltu	a5,a4,80001b1c <_Z11workerBodyAPv+0x20>
    80001b44:	00170713          	addi	a4,a4,1
    80001b48:	ff1ff06f          	j	80001b38 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001b4c:	00190913          	addi	s2,s2,1
    80001b50:	00900793          	li	a5,9
    80001b54:	0527e063          	bltu	a5,s2,80001b94 <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80001b58:	00004517          	auipc	a0,0x4
    80001b5c:	4e050513          	addi	a0,a0,1248 # 80006038 <CONSOLE_STATUS+0x28>
    80001b60:	00000097          	auipc	ra,0x0
    80001b64:	8b4080e7          	jalr	-1868(ra) # 80001414 <_Z11printStringPKc>
    80001b68:	00000613          	li	a2,0
    80001b6c:	00a00593          	li	a1,10
    80001b70:	0009051b          	sext.w	a0,s2
    80001b74:	00000097          	auipc	ra,0x0
    80001b78:	a68080e7          	jalr	-1432(ra) # 800015dc <_Z8printIntiii>
    80001b7c:	00004517          	auipc	a0,0x4
    80001b80:	55450513          	addi	a0,a0,1364 # 800060d0 <CONSOLE_STATUS+0xc0>
    80001b84:	00000097          	auipc	ra,0x0
    80001b88:	890080e7          	jalr	-1904(ra) # 80001414 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001b8c:	00000493          	li	s1,0
    80001b90:	f99ff06f          	j	80001b28 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    80001b94:	00004517          	auipc	a0,0x4
    80001b98:	4ac50513          	addi	a0,a0,1196 # 80006040 <CONSOLE_STATUS+0x30>
    80001b9c:	00000097          	auipc	ra,0x0
    80001ba0:	878080e7          	jalr	-1928(ra) # 80001414 <_Z11printStringPKc>


}
    80001ba4:	01813083          	ld	ra,24(sp)
    80001ba8:	01013403          	ld	s0,16(sp)
    80001bac:	00813483          	ld	s1,8(sp)
    80001bb0:	00013903          	ld	s2,0(sp)
    80001bb4:	02010113          	addi	sp,sp,32
    80001bb8:	00008067          	ret

0000000080001bbc <_Z11workerBodyCPv>:
        }
    }
    printString("b finished!\n");

}
void workerBodyC(void* arg) {
    80001bbc:	fe010113          	addi	sp,sp,-32
    80001bc0:	00113c23          	sd	ra,24(sp)
    80001bc4:	00813823          	sd	s0,16(sp)
    80001bc8:	00913423          	sd	s1,8(sp)
    80001bcc:	01213023          	sd	s2,0(sp)
    80001bd0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001bd4:	00000913          	li	s2,0
    80001bd8:	0380006f          	j	80001c10 <_Z11workerBodyCPv+0x54>
        printString("C: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
             thread_dispatch();
    80001bdc:	fffff097          	auipc	ra,0xfffff
    80001be0:	688080e7          	jalr	1672(ra) # 80001264 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001be4:	00148493          	addi	s1,s1,1
    80001be8:	000027b7          	lui	a5,0x2
    80001bec:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001bf0:	0097ee63          	bltu	a5,s1,80001c0c <_Z11workerBodyCPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001bf4:	00000713          	li	a4,0
    80001bf8:	000077b7          	lui	a5,0x7
    80001bfc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001c00:	fce7eee3          	bltu	a5,a4,80001bdc <_Z11workerBodyCPv+0x20>
    80001c04:	00170713          	addi	a4,a4,1
    80001c08:	ff1ff06f          	j	80001bf8 <_Z11workerBodyCPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001c0c:	00190913          	addi	s2,s2,1
    80001c10:	00900793          	li	a5,9
    80001c14:	0527e063          	bltu	a5,s2,80001c54 <_Z11workerBodyCPv+0x98>
        printString("C: i="); printInt(i); printString("\n");
    80001c18:	00004517          	auipc	a0,0x4
    80001c1c:	43850513          	addi	a0,a0,1080 # 80006050 <CONSOLE_STATUS+0x40>
    80001c20:	fffff097          	auipc	ra,0xfffff
    80001c24:	7f4080e7          	jalr	2036(ra) # 80001414 <_Z11printStringPKc>
    80001c28:	00000613          	li	a2,0
    80001c2c:	00a00593          	li	a1,10
    80001c30:	0009051b          	sext.w	a0,s2
    80001c34:	00000097          	auipc	ra,0x0
    80001c38:	9a8080e7          	jalr	-1624(ra) # 800015dc <_Z8printIntiii>
    80001c3c:	00004517          	auipc	a0,0x4
    80001c40:	49450513          	addi	a0,a0,1172 # 800060d0 <CONSOLE_STATUS+0xc0>
    80001c44:	fffff097          	auipc	ra,0xfffff
    80001c48:	7d0080e7          	jalr	2000(ra) # 80001414 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001c4c:	00000493          	li	s1,0
    80001c50:	f99ff06f          	j	80001be8 <_Z11workerBodyCPv+0x2c>
        }
    }
    printString("c finished!\n");
    80001c54:	00004517          	auipc	a0,0x4
    80001c58:	40450513          	addi	a0,a0,1028 # 80006058 <CONSOLE_STATUS+0x48>
    80001c5c:	fffff097          	auipc	ra,0xfffff
    80001c60:	7b8080e7          	jalr	1976(ra) # 80001414 <_Z11printStringPKc>

}
    80001c64:	01813083          	ld	ra,24(sp)
    80001c68:	01013403          	ld	s0,16(sp)
    80001c6c:	00813483          	ld	s1,8(sp)
    80001c70:	00013903          	ld	s2,0(sp)
    80001c74:	02010113          	addi	sp,sp,32
    80001c78:	00008067          	ret

0000000080001c7c <_Z11workerBodyBPv>:
void workerBodyB(void* arg) {
    80001c7c:	fe010113          	addi	sp,sp,-32
    80001c80:	00113c23          	sd	ra,24(sp)
    80001c84:	00813823          	sd	s0,16(sp)
    80001c88:	00913423          	sd	s1,8(sp)
    80001c8c:	02010413          	addi	s0,sp,32
    join(threads[0]);
    80001c90:	00005497          	auipc	s1,0x5
    80001c94:	6d848493          	addi	s1,s1,1752 # 80007368 <threads>
    80001c98:	0004b503          	ld	a0,0(s1)
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	538080e7          	jalr	1336(ra) # 800011d4 <_Z4joinP3TCB>
    join(threads[2]);
    80001ca4:	0104b503          	ld	a0,16(s1)
    80001ca8:	fffff097          	auipc	ra,0xfffff
    80001cac:	52c080e7          	jalr	1324(ra) # 800011d4 <_Z4joinP3TCB>
    __asm__ volatile("csrw sstatus,%0"::"r"(1<<8));
    80001cb0:	10000793          	li	a5,256
    80001cb4:	10079073          	csrw	sstatus,a5
    for (uint64 i = 0; i < 10; i++) {
    80001cb8:	00000493          	li	s1,0
    80001cbc:	0300006f          	j	80001cec <_Z11workerBodyBPv+0x70>
        for (uint64 j = 0; j < 10000; j++) {
    80001cc0:	00168693          	addi	a3,a3,1
    80001cc4:	000027b7          	lui	a5,0x2
    80001cc8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001ccc:	00d7ee63          	bltu	a5,a3,80001ce8 <_Z11workerBodyBPv+0x6c>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001cd0:	00000713          	li	a4,0
    80001cd4:	000077b7          	lui	a5,0x7
    80001cd8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001cdc:	fee7e2e3          	bltu	a5,a4,80001cc0 <_Z11workerBodyBPv+0x44>
    80001ce0:	00170713          	addi	a4,a4,1
    80001ce4:	ff1ff06f          	j	80001cd4 <_Z11workerBodyBPv+0x58>
    for (uint64 i = 0; i < 10; i++) {
    80001ce8:	00148493          	addi	s1,s1,1
    80001cec:	00900793          	li	a5,9
    80001cf0:	0497e063          	bltu	a5,s1,80001d30 <_Z11workerBodyBPv+0xb4>
        printString("B: i="); printInt(i); printString("\n");
    80001cf4:	00004517          	auipc	a0,0x4
    80001cf8:	37450513          	addi	a0,a0,884 # 80006068 <CONSOLE_STATUS+0x58>
    80001cfc:	fffff097          	auipc	ra,0xfffff
    80001d00:	718080e7          	jalr	1816(ra) # 80001414 <_Z11printStringPKc>
    80001d04:	00000613          	li	a2,0
    80001d08:	00a00593          	li	a1,10
    80001d0c:	0004851b          	sext.w	a0,s1
    80001d10:	00000097          	auipc	ra,0x0
    80001d14:	8cc080e7          	jalr	-1844(ra) # 800015dc <_Z8printIntiii>
    80001d18:	00004517          	auipc	a0,0x4
    80001d1c:	3b850513          	addi	a0,a0,952 # 800060d0 <CONSOLE_STATUS+0xc0>
    80001d20:	fffff097          	auipc	ra,0xfffff
    80001d24:	6f4080e7          	jalr	1780(ra) # 80001414 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001d28:	00000693          	li	a3,0
    80001d2c:	f99ff06f          	j	80001cc4 <_Z11workerBodyBPv+0x48>
    printString("b finished!\n");
    80001d30:	00004517          	auipc	a0,0x4
    80001d34:	34050513          	addi	a0,a0,832 # 80006070 <CONSOLE_STATUS+0x60>
    80001d38:	fffff097          	auipc	ra,0xfffff
    80001d3c:	6dc080e7          	jalr	1756(ra) # 80001414 <_Z11printStringPKc>
}
    80001d40:	01813083          	ld	ra,24(sp)
    80001d44:	01013403          	ld	s0,16(sp)
    80001d48:	00813483          	ld	s1,8(sp)
    80001d4c:	02010113          	addi	sp,sp,32
    80001d50:	00008067          	ret

0000000080001d54 <_Z8testJOINv>:

void testJOIN() {
    80001d54:	fe010113          	addi	sp,sp,-32
    80001d58:	00113c23          	sd	ra,24(sp)
    80001d5c:	00813823          	sd	s0,16(sp)
    80001d60:	00913423          	sd	s1,8(sp)
    80001d64:	02010413          	addi	s0,sp,32

    thread_create(&threads[0], workerBodyA, nullptr);
    80001d68:	00005497          	auipc	s1,0x5
    80001d6c:	60048493          	addi	s1,s1,1536 # 80007368 <threads>
    80001d70:	00000613          	li	a2,0
    80001d74:	00000597          	auipc	a1,0x0
    80001d78:	d8858593          	addi	a1,a1,-632 # 80001afc <_Z11workerBodyAPv>
    80001d7c:	00048513          	mv	a0,s1
    80001d80:	fffff097          	auipc	ra,0xfffff
    80001d84:	4ac080e7          	jalr	1196(ra) # 8000122c <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80001d88:	00004517          	auipc	a0,0x4
    80001d8c:	2f850513          	addi	a0,a0,760 # 80006080 <CONSOLE_STATUS+0x70>
    80001d90:	fffff097          	auipc	ra,0xfffff
    80001d94:	684080e7          	jalr	1668(ra) # 80001414 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80001d98:	00000613          	li	a2,0
    80001d9c:	00000597          	auipc	a1,0x0
    80001da0:	ee058593          	addi	a1,a1,-288 # 80001c7c <_Z11workerBodyBPv>
    80001da4:	00005517          	auipc	a0,0x5
    80001da8:	5cc50513          	addi	a0,a0,1484 # 80007370 <threads+0x8>
    80001dac:	fffff097          	auipc	ra,0xfffff
    80001db0:	480080e7          	jalr	1152(ra) # 8000122c <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80001db4:	00004517          	auipc	a0,0x4
    80001db8:	2e450513          	addi	a0,a0,740 # 80006098 <CONSOLE_STATUS+0x88>
    80001dbc:	fffff097          	auipc	ra,0xfffff
    80001dc0:	658080e7          	jalr	1624(ra) # 80001414 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80001dc4:	00000613          	li	a2,0
    80001dc8:	00000597          	auipc	a1,0x0
    80001dcc:	df458593          	addi	a1,a1,-524 # 80001bbc <_Z11workerBodyCPv>
    80001dd0:	00005517          	auipc	a0,0x5
    80001dd4:	5a850513          	addi	a0,a0,1448 # 80007378 <threads+0x10>
    80001dd8:	fffff097          	auipc	ra,0xfffff
    80001ddc:	454080e7          	jalr	1108(ra) # 8000122c <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80001de0:	00004517          	auipc	a0,0x4
    80001de4:	2d050513          	addi	a0,a0,720 # 800060b0 <CONSOLE_STATUS+0xa0>
    80001de8:	fffff097          	auipc	ra,0xfffff
    80001dec:	62c080e7          	jalr	1580(ra) # 80001414 <_Z11printStringPKc>


    join(threads[0]);
    80001df0:	0004b503          	ld	a0,0(s1)
    80001df4:	fffff097          	auipc	ra,0xfffff
    80001df8:	3e0080e7          	jalr	992(ra) # 800011d4 <_Z4joinP3TCB>
    join(threads[2]);
    80001dfc:	0104b503          	ld	a0,16(s1)
    80001e00:	fffff097          	auipc	ra,0xfffff
    80001e04:	3d4080e7          	jalr	980(ra) # 800011d4 <_Z4joinP3TCB>


}
    80001e08:	01813083          	ld	ra,24(sp)
    80001e0c:	01013403          	ld	s0,16(sp)
    80001e10:	00813483          	ld	s1,8(sp)
    80001e14:	02010113          	addi	sp,sp,32
    80001e18:	00008067          	ret

0000000080001e1c <_Z8userMainv>:
//#include "../h/ThreadSleep_C_API_test.hpp" // thread_sleep test C API
//#include "../h/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta
//#include "../h/testID.hpp"
//#include "../h/testKIll.hpp"
#include "../h/join.hpp"
void userMain() {
    80001e1c:	ff010113          	addi	sp,sp,-16
    80001e20:	00113423          	sd	ra,8(sp)
    80001e24:	00813023          	sd	s0,0(sp)
    80001e28:	01010413          	addi	s0,sp,16
    //__asm__ volatile("csrw sstatus,%0"::"r"(1<<8));
//Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
//Threads_CPP_API_test(); // zadatak 2., niti CPP API i sinhrona promena konteksta
//testID();
//testKill();
testJOIN();
    80001e2c:	00000097          	auipc	ra,0x0
    80001e30:	f28080e7          	jalr	-216(ra) # 80001d54 <_Z8testJOINv>
//producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    //ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

}
    80001e34:	00813083          	ld	ra,8(sp)
    80001e38:	00013403          	ld	s0,0(sp)
    80001e3c:	01010113          	addi	sp,sp,16
    80001e40:	00008067          	ret

0000000080001e44 <main>:

#include "../h/riscv.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/printing.hpp"
extern void userMain();
int main() {
    80001e44:	ff010113          	addi	sp,sp,-16
    80001e48:	00113423          	sd	ra,8(sp)
    80001e4c:	00813023          	sd	s0,0(sp)
    80001e50:	01010413          	addi	s0,sp,16

    MemoryAllocator::memInit(); //inicijalizacija memorije
    80001e54:	00001097          	auipc	ra,0x1
    80001e58:	0c0080e7          	jalr	192(ra) # 80002f14 <_ZN15MemoryAllocator7memInitEv>

   Riscv::init();
    80001e5c:	00001097          	auipc	ra,0x1
    80001e60:	c00080e7          	jalr	-1024(ra) # 80002a5c <_ZN5Riscv4initEv>

    userMain();
    80001e64:	00000097          	auipc	ra,0x0
    80001e68:	fb8080e7          	jalr	-72(ra) # 80001e1c <_Z8userMainv>

  

    printString("Finished\n");
    80001e6c:	00004517          	auipc	a0,0x4
    80001e70:	25c50513          	addi	a0,a0,604 # 800060c8 <CONSOLE_STATUS+0xb8>
    80001e74:	fffff097          	auipc	ra,0xfffff
    80001e78:	5a0080e7          	jalr	1440(ra) # 80001414 <_Z11printStringPKc>
    exit();
    80001e7c:	fffff097          	auipc	ra,0xfffff
    80001e80:	45c080e7          	jalr	1116(ra) # 800012d8 <_Z4exitv>
    return 0;

}
    80001e84:	00000513          	li	a0,0
    80001e88:	00813083          	ld	ra,8(sp)
    80001e8c:	00013403          	ld	s0,0(sp)
    80001e90:	01010113          	addi	sp,sp,16
    80001e94:	00008067          	ret

0000000080001e98 <_ZN3TCB13threadWrapperEv>:
        return true;
    else return false;

}

void TCB::threadWrapper() {
    80001e98:	fe010113          	addi	sp,sp,-32
    80001e9c:	00113c23          	sd	ra,24(sp)
    80001ea0:	00813823          	sd	s0,16(sp)
    80001ea4:	00913423          	sd	s1,8(sp)
    80001ea8:	01213023          	sd	s2,0(sp)
    80001eac:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    80001eb0:	00001097          	auipc	ra,0x1
    80001eb4:	874080e7          	jalr	-1932(ra) # 80002724 <_ZN5Riscv10popSppSpieEv>
    running->setBody(running->getArg());
    80001eb8:	00005797          	auipc	a5,0x5
    80001ebc:	4c87b783          	ld	a5,1224(a5) # 80007380 <_ZN3TCB7runningE>
        bool isBlocked()const{return blocked;}
        bool isCreated()const{return created;}
        Body getBody()const{return body;}
        void* getArg()const{return arg;}
        int getId(){return id;}
        void setBody(void* arg){body(arg);}
    80001ec0:	0007b703          	ld	a4,0(a5)
    80001ec4:	0087b503          	ld	a0,8(a5)
    80001ec8:	000700e7          	jalr	a4
    80001ecc:	0300006f          	j	80001efc <_ZN3TCB13threadWrapperEv+0x64>
        if (prvi != nullptr) {

            Elem* temp = prvi;
            prvi=prvi->sled;
            if (prvi== nullptr)
                posl= nullptr;
    80001ed0:	00093423          	sd	zero,8(s2)
            ret = temp->tcb;
    80001ed4:	00053483          	ld	s1,0(a0)
            MemoryAllocator::memFree(ptr);
    80001ed8:	00001097          	auipc	ra,0x1
    80001edc:	248080e7          	jalr	584(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
            delete temp;
            vel--;
    80001ee0:	01092783          	lw	a5,16(s2)
    80001ee4:	fff7879b          	addiw	a5,a5,-1
    80001ee8:	00f92823          	sw	a5,16(s2)
        void setBlocked(bool value){blocked=value;}
    80001eec:	020484a3          	sb	zero,41(s1)
 while(running->blockedThreads.getPrvi()){
      TCB* t=running->blockedThreads.izbrisiPrvi();
        t->setBlocked(false);
        Scheduler::put(t);
    80001ef0:	00048513          	mv	a0,s1
    80001ef4:	00001097          	auipc	ra,0x1
    80001ef8:	f40080e7          	jalr	-192(ra) # 80002e34 <_ZN9Scheduler3putEP3TCB>
 while(running->blockedThreads.getPrvi()){
    80001efc:	00005797          	auipc	a5,0x5
    80001f00:	4847b783          	ld	a5,1156(a5) # 80007380 <_ZN3TCB7runningE>

        }
        return ret;
    }
    T *getPrvi(){
        if(!prvi){ return nullptr; }
    80001f04:	0307b703          	ld	a4,48(a5)
    80001f08:	02070863          	beqz	a4,80001f38 <_ZN3TCB13threadWrapperEv+0xa0>
        return prvi->tcb;
    80001f0c:	00073703          	ld	a4,0(a4)
    80001f10:	02070463          	beqz	a4,80001f38 <_ZN3TCB13threadWrapperEv+0xa0>
      TCB* t=running->blockedThreads.izbrisiPrvi();
    80001f14:	03078913          	addi	s2,a5,48
        if (prvi != nullptr) {
    80001f18:	0307b503          	ld	a0,48(a5)
    80001f1c:	00050a63          	beqz	a0,80001f30 <_ZN3TCB13threadWrapperEv+0x98>
            prvi=prvi->sled;
    80001f20:	00853703          	ld	a4,8(a0)
    80001f24:	02e7b823          	sd	a4,48(a5)
            if (prvi== nullptr)
    80001f28:	fa0716e3          	bnez	a4,80001ed4 <_ZN3TCB13threadWrapperEv+0x3c>
    80001f2c:	fa5ff06f          	j	80001ed0 <_ZN3TCB13threadWrapperEv+0x38>
        T* ret = 0;
    80001f30:	00050493          	mv	s1,a0
    80001f34:	fb9ff06f          	j	80001eec <_ZN3TCB13threadWrapperEv+0x54>
 }
thread_exit();
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	350080e7          	jalr	848(ra) # 80001288 <_Z11thread_exitv>

}
    80001f40:	01813083          	ld	ra,24(sp)
    80001f44:	01013403          	ld	s0,16(sp)
    80001f48:	00813483          	ld	s1,8(sp)
    80001f4c:	00013903          	ld	s2,0(sp)
    80001f50:	02010113          	addi	sp,sp,32
    80001f54:	00008067          	ret

0000000080001f58 <_ZN3TCBC1EPFvPvES0_Pm>:
TCB::TCB(Body body,  void *arg,uint64*stack) {
    80001f58:	fe010113          	addi	sp,sp,-32
    80001f5c:	00113c23          	sd	ra,24(sp)
    80001f60:	00813823          	sd	s0,16(sp)
    80001f64:	00913423          	sd	s1,8(sp)
    80001f68:	01213023          	sd	s2,0(sp)
    80001f6c:	02010413          	addi	s0,sp,32
    80001f70:	00050493          	mv	s1,a0
    80001f74:	00068913          	mv	s2,a3
    Queue() : prvi(nullptr), posl(nullptr) {}
    80001f78:	02053823          	sd	zero,48(a0)
    80001f7c:	02053c23          	sd	zero,56(a0)
    this->body=body;
    80001f80:	00b53023          	sd	a1,0(a0)
    this->arg=arg;
    80001f84:	00c53423          	sd	a2,8(a0)
    created=true;
    80001f88:	00100793          	li	a5,1
    80001f8c:	02f50523          	sb	a5,42(a0)
    finished=false;
    80001f90:	02050423          	sb	zero,40(a0)
    blocked=false;
    80001f94:	020504a3          	sb	zero,41(a0)
    id=++ID;
    80001f98:	00005717          	auipc	a4,0x5
    80001f9c:	3e870713          	addi	a4,a4,1000 # 80007380 <_ZN3TCB7runningE>
    80001fa0:	00872783          	lw	a5,8(a4)
    80001fa4:	0017879b          	addiw	a5,a5,1
    80001fa8:	00f72423          	sw	a5,8(a4)
    80001fac:	02f52623          	sw	a5,44(a0)
   this->stack=stack;
    80001fb0:	00d53823          	sd	a3,16(a0)
    if(body!= nullptr)
    80001fb4:	00058663          	beqz	a1,80001fc0 <_ZN3TCBC1EPFvPvES0_Pm+0x68>
        Scheduler::put(this);
    80001fb8:	00001097          	auipc	ra,0x1
    80001fbc:	e7c080e7          	jalr	-388(ra) # 80002e34 <_ZN9Scheduler3putEP3TCB>
   context.ra=(uint64 ) &threadWrapper;
    80001fc0:	00000797          	auipc	a5,0x0
    80001fc4:	ed878793          	addi	a5,a5,-296 # 80001e98 <_ZN3TCB13threadWrapperEv>
    80001fc8:	00f4bc23          	sd	a5,24(s1)
   context.sp= (uint64) &stack[STACK_SIZE];
    80001fcc:	000086b7          	lui	a3,0x8
    80001fd0:	00d90933          	add	s2,s2,a3
    80001fd4:	0324b023          	sd	s2,32(s1)
}
    80001fd8:	01813083          	ld	ra,24(sp)
    80001fdc:	01013403          	ld	s0,16(sp)
    80001fe0:	00813483          	ld	s1,8(sp)
    80001fe4:	00013903          	ld	s2,0(sp)
    80001fe8:	02010113          	addi	sp,sp,32
    80001fec:	00008067          	ret

0000000080001ff0 <_ZN3TCB12createThreadEPFvPvES0_S0_>:
TCB *TCB::createThread(Body body, void *arg,void*stack) {
    80001ff0:	fd010113          	addi	sp,sp,-48
    80001ff4:	02113423          	sd	ra,40(sp)
    80001ff8:	02813023          	sd	s0,32(sp)
    80001ffc:	00913c23          	sd	s1,24(sp)
    80002000:	01213823          	sd	s2,16(sp)
    80002004:	01313423          	sd	s3,8(sp)
    80002008:	01413023          	sd	s4,0(sp)
    8000200c:	03010413          	addi	s0,sp,48
    80002010:	00050493          	mv	s1,a0
    80002014:	00058913          	mv	s2,a1
    80002018:	00060a13          	mv	s4,a2
        static void yield();
        static TCB *running;
        void join();

    void *operator new(uint64 n) {
        return MemoryAllocator::memAlloc(n);
    8000201c:	04800513          	li	a0,72
    80002020:	00001097          	auipc	ra,0x1
    80002024:	fc8080e7          	jalr	-56(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
    80002028:	00050993          	mv	s3,a0
    TCB* temp=new TCB(body,arg,stackT);
    8000202c:	000a0693          	mv	a3,s4
    80002030:	00090613          	mv	a2,s2
    80002034:	00048593          	mv	a1,s1
    80002038:	00000097          	auipc	ra,0x0
    8000203c:	f20080e7          	jalr	-224(ra) # 80001f58 <_ZN3TCBC1EPFvPvES0_Pm>
    if(body== nullptr && arg== nullptr){
    80002040:	02048463          	beqz	s1,80002068 <_ZN3TCB12createThreadEPFvPvES0_S0_+0x78>
}
    80002044:	00098513          	mv	a0,s3
    80002048:	02813083          	ld	ra,40(sp)
    8000204c:	02013403          	ld	s0,32(sp)
    80002050:	01813483          	ld	s1,24(sp)
    80002054:	01013903          	ld	s2,16(sp)
    80002058:	00813983          	ld	s3,8(sp)
    8000205c:	00013a03          	ld	s4,0(sp)
    80002060:	03010113          	addi	sp,sp,48
    80002064:	00008067          	ret
    if(body== nullptr && arg== nullptr){
    80002068:	fc091ee3          	bnez	s2,80002044 <_ZN3TCB12createThreadEPFvPvES0_S0_+0x54>
        TCB::running=temp;
    8000206c:	00005797          	auipc	a5,0x5
    80002070:	3137ba23          	sd	s3,788(a5) # 80007380 <_ZN3TCB7runningE>
    return temp;
    80002074:	fd1ff06f          	j	80002044 <_ZN3TCB12createThreadEPFvPvES0_S0_+0x54>
    80002078:	00050493          	mv	s1,a0
    }


    void operator delete(void *ptr) {
        MemoryAllocator::memFree(ptr);
    8000207c:	00098513          	mv	a0,s3
    80002080:	00001097          	auipc	ra,0x1
    80002084:	0a0080e7          	jalr	160(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
    80002088:	00048513          	mv	a0,s1
    8000208c:	00006097          	auipc	ra,0x6
    80002090:	3ec080e7          	jalr	1004(ra) # 80008478 <_Unwind_Resume>

0000000080002094 <_ZN3TCBC1EPFvPvES0_>:
TCB::TCB(Body body,void* arg){
    80002094:	ff010113          	addi	sp,sp,-16
    80002098:	00813423          	sd	s0,8(sp)
    8000209c:	01010413          	addi	s0,sp,16
    800020a0:	02053823          	sd	zero,48(a0)
    800020a4:	02053c23          	sd	zero,56(a0)
    this->body=body;
    800020a8:	00b53023          	sd	a1,0(a0)
    this->arg=arg;
    800020ac:	00c53423          	sd	a2,8(a0)
}
    800020b0:	00813403          	ld	s0,8(sp)
    800020b4:	01010113          	addi	sp,sp,16
    800020b8:	00008067          	ret

00000000800020bc <_ZN3TCB5startEv>:
        bool isCreated()const{return created;}
    800020bc:	02a54783          	lbu	a5,42(a0)
    if(this->isCreated()==true){
    800020c0:	00079463          	bnez	a5,800020c8 <_ZN3TCB5startEv+0xc>
    800020c4:	00008067          	ret
void TCB::start() {
    800020c8:	ff010113          	addi	sp,sp,-16
    800020cc:	00113423          	sd	ra,8(sp)
    800020d0:	00813023          	sd	s0,0(sp)
    800020d4:	01010413          	addi	s0,sp,16
        Scheduler::put(this);
    800020d8:	00001097          	auipc	ra,0x1
    800020dc:	d5c080e7          	jalr	-676(ra) # 80002e34 <_ZN9Scheduler3putEP3TCB>
}
    800020e0:	00813083          	ld	ra,8(sp)
    800020e4:	00013403          	ld	s0,0(sp)
    800020e8:	01010113          	addi	sp,sp,16
    800020ec:	00008067          	ret

00000000800020f0 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    800020f0:	fe010113          	addi	sp,sp,-32
    800020f4:	00113c23          	sd	ra,24(sp)
    800020f8:	00813823          	sd	s0,16(sp)
    800020fc:	00913423          	sd	s1,8(sp)
    80002100:	02010413          	addi	s0,sp,32
    TCB *old = running;
    80002104:	00005497          	auipc	s1,0x5
    80002108:	27c4b483          	ld	s1,636(s1) # 80007380 <_ZN3TCB7runningE>
        bool isFinished() const { return finished; }
    8000210c:	0284c783          	lbu	a5,40(s1)
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    80002110:	00079663          	bnez	a5,8000211c <_ZN3TCB8dispatchEv+0x2c>
        bool isBlocked()const{return blocked;}
    80002114:	0294c783          	lbu	a5,41(s1)
    80002118:	00078c63          	beqz	a5,80002130 <_ZN3TCB8dispatchEv+0x40>
   running=Scheduler::get();
    8000211c:	00001097          	auipc	ra,0x1
    80002120:	c9c080e7          	jalr	-868(ra) # 80002db8 <_ZN9Scheduler3getEv>
    80002124:	00005797          	auipc	a5,0x5
    80002128:	24a7be23          	sd	a0,604(a5) # 80007380 <_ZN3TCB7runningE>
    8000212c:	0240006f          	j	80002150 <_ZN3TCB8dispatchEv+0x60>
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    80002130:	00048513          	mv	a0,s1
    80002134:	00001097          	auipc	ra,0x1
    80002138:	d00080e7          	jalr	-768(ra) # 80002e34 <_ZN9Scheduler3putEP3TCB>
    8000213c:	fe1ff06f          	j	8000211c <_ZN3TCB8dispatchEv+0x2c>
        running=Scheduler::get();
    80002140:	00001097          	auipc	ra,0x1
    80002144:	c78080e7          	jalr	-904(ra) # 80002db8 <_ZN9Scheduler3getEv>
    80002148:	00005797          	auipc	a5,0x5
    8000214c:	22a7bc23          	sd	a0,568(a5) # 80007380 <_ZN3TCB7runningE>
    while(running->isFinished()==true || running->isBlocked()==true){
    80002150:	00005597          	auipc	a1,0x5
    80002154:	2305b583          	ld	a1,560(a1) # 80007380 <_ZN3TCB7runningE>
        bool isFinished() const { return finished; }
    80002158:	0285c783          	lbu	a5,40(a1)
    8000215c:	fe0792e3          	bnez	a5,80002140 <_ZN3TCB8dispatchEv+0x50>
        bool isBlocked()const{return blocked;}
    80002160:	0295c783          	lbu	a5,41(a1)
    80002164:	fc079ee3          	bnez	a5,80002140 <_ZN3TCB8dispatchEv+0x50>
    TCB::contextSwitch(&old->context, &running->context);
    80002168:	01858593          	addi	a1,a1,24
    8000216c:	01848513          	addi	a0,s1,24
    80002170:	fffff097          	auipc	ra,0xfffff
    80002174:	fc0080e7          	jalr	-64(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002178:	01813083          	ld	ra,24(sp)
    8000217c:	01013403          	ld	s0,16(sp)
    80002180:	00813483          	ld	s1,8(sp)
    80002184:	02010113          	addi	sp,sp,32
    80002188:	00008067          	ret

000000008000218c <_ZN3TCB7wrapperEPv>:
    if(arg){
    8000218c:	02050863          	beqz	a0,800021bc <_ZN3TCB7wrapperEPv+0x30>
void TCB::wrapper(void*arg){
    80002190:	ff010113          	addi	sp,sp,-16
    80002194:	00113423          	sd	ra,8(sp)
    80002198:	00813023          	sd	s0,0(sp)
    8000219c:	01010413          	addi	s0,sp,16
    ((Thread*)arg)->run();
    800021a0:	00053783          	ld	a5,0(a0)
    800021a4:	0107b783          	ld	a5,16(a5)
    800021a8:	000780e7          	jalr	a5
}
    800021ac:	00813083          	ld	ra,8(sp)
    800021b0:	00013403          	ld	s0,0(sp)
    800021b4:	01010113          	addi	sp,sp,16
    800021b8:	00008067          	ret
    800021bc:	00008067          	ret

00000000800021c0 <_ZN3TCB9checkBodyEv>:
bool TCB::checkBody() {
    800021c0:	ff010113          	addi	sp,sp,-16
    800021c4:	00813423          	sd	s0,8(sp)
    800021c8:	01010413          	addi	s0,sp,16
    if(running->getBody())
    800021cc:	00005797          	auipc	a5,0x5
    800021d0:	1b47b783          	ld	a5,436(a5) # 80007380 <_ZN3TCB7runningE>
        Body getBody()const{return body;}
    800021d4:	0007b783          	ld	a5,0(a5)
    800021d8:	00078a63          	beqz	a5,800021ec <_ZN3TCB9checkBodyEv+0x2c>
        return true;
    800021dc:	00100513          	li	a0,1
}
    800021e0:	00813403          	ld	s0,8(sp)
    800021e4:	01010113          	addi	sp,sp,16
    800021e8:	00008067          	ret
    else return false;
    800021ec:	00000513          	li	a0,0
    800021f0:	ff1ff06f          	j	800021e0 <_ZN3TCB9checkBodyEv+0x20>

00000000800021f4 <_ZN3TCB8checkArgEv>:
bool TCB::checkArg() {
    800021f4:	ff010113          	addi	sp,sp,-16
    800021f8:	00813423          	sd	s0,8(sp)
    800021fc:	01010413          	addi	s0,sp,16
    if(running->getArg())
    80002200:	00005797          	auipc	a5,0x5
    80002204:	1807b783          	ld	a5,384(a5) # 80007380 <_ZN3TCB7runningE>
        void* getArg()const{return arg;}
    80002208:	0087b783          	ld	a5,8(a5)
    8000220c:	00078a63          	beqz	a5,80002220 <_ZN3TCB8checkArgEv+0x2c>
        return true;
    80002210:	00100513          	li	a0,1
}
    80002214:	00813403          	ld	s0,8(sp)
    80002218:	01010113          	addi	sp,sp,16
    8000221c:	00008067          	ret
    else return false;
    80002220:	00000513          	li	a0,0
    80002224:	ff1ff06f          	j	80002214 <_ZN3TCB8checkArgEv+0x20>

0000000080002228 <_ZN3TCB4joinEv>:
void TCB::join() {
    80002228:	fd010113          	addi	sp,sp,-48
    8000222c:	02113423          	sd	ra,40(sp)
    80002230:	02813023          	sd	s0,32(sp)
    80002234:	00913c23          	sd	s1,24(sp)
    80002238:	01213823          	sd	s2,16(sp)
    8000223c:	01313423          	sd	s3,8(sp)
    80002240:	03010413          	addi	s0,sp,48
    if(this==TCB::running|| this->isFinished()==true) {
    80002244:	00005917          	auipc	s2,0x5
    80002248:	13c93903          	ld	s2,316(s2) # 80007380 <_ZN3TCB7runningE>
    8000224c:	00a90863          	beq	s2,a0,8000225c <_ZN3TCB4joinEv+0x34>
    80002250:	00050493          	mv	s1,a0
        bool isFinished() const { return finished; }
    80002254:	02854783          	lbu	a5,40(a0)
    80002258:	02078063          	beqz	a5,80002278 <_ZN3TCB4joinEv+0x50>

    TCB::running->setBlocked(true);
    blockedThreads.dodaj(TCB::running);

    TCB::dispatch();
    8000225c:	02813083          	ld	ra,40(sp)
    80002260:	02013403          	ld	s0,32(sp)
    80002264:	01813483          	ld	s1,24(sp)
    80002268:	01013903          	ld	s2,16(sp)
    8000226c:	00813983          	ld	s3,8(sp)
    80002270:	03010113          	addi	sp,sp,48
    80002274:	00008067          	ret
        void setBlocked(bool value){blocked=value;}
    80002278:	00100793          	li	a5,1
    8000227c:	02f904a3          	sb	a5,41(s2)
    blockedThreads.dodaj(TCB::running);
    80002280:	03050993          	addi	s3,a0,48
        for (temp = prvi; temp; temp= temp->sled);
    80002284:	03053703          	ld	a4,48(a0)
    80002288:	00070793          	mv	a5,a4
    8000228c:	0080006f          	j	80002294 <_ZN3TCB4joinEv+0x6c>
    80002290:	0087b783          	ld	a5,8(a5)
    80002294:	fe079ee3          	bnez	a5,80002290 <_ZN3TCB4joinEv+0x68>
        if (prvi== nullptr) prvi= posl = new Elem(tcb);
    80002298:	02070e63          	beqz	a4,800022d4 <_ZN3TCB4joinEv+0xac>
           return MemoryAllocator::memAlloc(n);
    8000229c:	01000513          	li	a0,16
    800022a0:	00001097          	auipc	ra,0x1
    800022a4:	d48080e7          	jalr	-696(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
            this->tcb=tcb;
    800022a8:	01253023          	sd	s2,0(a0)
            sled= nullptr;
    800022ac:	00053423          	sd	zero,8(a0)
        else posl = posl->sled = new Elem(tcb);
    800022b0:	0089b783          	ld	a5,8(s3)
    800022b4:	00a7b423          	sd	a0,8(a5)
    800022b8:	00a9b423          	sd	a0,8(s3)
        vel++;
    800022bc:	0109a783          	lw	a5,16(s3)
    800022c0:	0017879b          	addiw	a5,a5,1
    800022c4:	00f9a823          	sw	a5,16(s3)
    TCB::dispatch();
    800022c8:	00000097          	auipc	ra,0x0
    800022cc:	e28080e7          	jalr	-472(ra) # 800020f0 <_ZN3TCB8dispatchEv>
    800022d0:	f8dff06f          	j	8000225c <_ZN3TCB4joinEv+0x34>
           return MemoryAllocator::memAlloc(n);
    800022d4:	01000513          	li	a0,16
    800022d8:	00001097          	auipc	ra,0x1
    800022dc:	d10080e7          	jalr	-752(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
            this->tcb=tcb;
    800022e0:	01253023          	sd	s2,0(a0)
            sled= nullptr;
    800022e4:	00053423          	sd	zero,8(a0)
        if (prvi== nullptr) prvi= posl = new Elem(tcb);
    800022e8:	00a9b423          	sd	a0,8(s3)
    800022ec:	02a4b823          	sd	a0,48(s1)
    800022f0:	fcdff06f          	j	800022bc <_ZN3TCB4joinEv+0x94>

00000000800022f4 <_ZN9SemaphoreD1Ev>:
Semaphore::Semaphore(unsigned int init) {

    sem_open(&myHandle, init);

}
Semaphore::~Semaphore() {
    800022f4:	ff010113          	addi	sp,sp,-16
    800022f8:	00113423          	sd	ra,8(sp)
    800022fc:	00813023          	sd	s0,0(sp)
    80002300:	01010413          	addi	s0,sp,16
    80002304:	00005797          	auipc	a5,0x5
    80002308:	fc478793          	addi	a5,a5,-60 # 800072c8 <_ZTV9Semaphore+0x10>
    8000230c:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002310:	00853503          	ld	a0,8(a0)
    80002314:	fffff097          	auipc	ra,0xfffff
    80002318:	070080e7          	jalr	112(ra) # 80001384 <_Z9sem_closeP3SCB>
}
    8000231c:	00813083          	ld	ra,8(sp)
    80002320:	00013403          	ld	s0,0(sp)
    80002324:	01010113          	addi	sp,sp,16
    80002328:	00008067          	ret

000000008000232c <_Znwm>:
void *operator new(uint64 n) {
    8000232c:	ff010113          	addi	sp,sp,-16
    80002330:	00113423          	sd	ra,8(sp)
    80002334:	00813023          	sd	s0,0(sp)
    80002338:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    8000233c:	fffff097          	auipc	ra,0xfffff
    80002340:	e08080e7          	jalr	-504(ra) # 80001144 <_Z9mem_allocm>
}
    80002344:	00813083          	ld	ra,8(sp)
    80002348:	00013403          	ld	s0,0(sp)
    8000234c:	01010113          	addi	sp,sp,16
    80002350:	00008067          	ret

0000000080002354 <_ZdlPv>:
void operator delete(void *ptr) {
    80002354:	ff010113          	addi	sp,sp,-16
    80002358:	00113423          	sd	ra,8(sp)
    8000235c:	00813023          	sd	s0,0(sp)
    80002360:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80002364:	fffff097          	auipc	ra,0xfffff
    80002368:	e98080e7          	jalr	-360(ra) # 800011fc <_Z8mem_freePv>
}
    8000236c:	00813083          	ld	ra,8(sp)
    80002370:	00013403          	ld	s0,0(sp)
    80002374:	01010113          	addi	sp,sp,16
    80002378:	00008067          	ret

000000008000237c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    8000237c:	fe010113          	addi	sp,sp,-32
    80002380:	00113c23          	sd	ra,24(sp)
    80002384:	00813823          	sd	s0,16(sp)
    80002388:	00913423          	sd	s1,8(sp)
    8000238c:	02010413          	addi	s0,sp,32
    80002390:	00050493          	mv	s1,a0
}
    80002394:	00000097          	auipc	ra,0x0
    80002398:	f60080e7          	jalr	-160(ra) # 800022f4 <_ZN9SemaphoreD1Ev>
    8000239c:	00048513          	mv	a0,s1
    800023a0:	00000097          	auipc	ra,0x0
    800023a4:	fb4080e7          	jalr	-76(ra) # 80002354 <_ZdlPv>
    800023a8:	01813083          	ld	ra,24(sp)
    800023ac:	01013403          	ld	s0,16(sp)
    800023b0:	00813483          	ld	s1,8(sp)
    800023b4:	02010113          	addi	sp,sp,32
    800023b8:	00008067          	ret

00000000800023bc <_Znam>:
void *operator new[](uint64 n) {
    800023bc:	ff010113          	addi	sp,sp,-16
    800023c0:	00113423          	sd	ra,8(sp)
    800023c4:	00813023          	sd	s0,0(sp)
    800023c8:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    800023cc:	fffff097          	auipc	ra,0xfffff
    800023d0:	d78080e7          	jalr	-648(ra) # 80001144 <_Z9mem_allocm>
}
    800023d4:	00813083          	ld	ra,8(sp)
    800023d8:	00013403          	ld	s0,0(sp)
    800023dc:	01010113          	addi	sp,sp,16
    800023e0:	00008067          	ret

00000000800023e4 <_ZdaPv>:
void operator delete[](void *ptr) noexcept {
    800023e4:	ff010113          	addi	sp,sp,-16
    800023e8:	00113423          	sd	ra,8(sp)
    800023ec:	00813023          	sd	s0,0(sp)
    800023f0:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800023f4:	fffff097          	auipc	ra,0xfffff
    800023f8:	e08080e7          	jalr	-504(ra) # 800011fc <_Z8mem_freePv>
}
    800023fc:	00813083          	ld	ra,8(sp)
    80002400:	00013403          	ld	s0,0(sp)
    80002404:	01010113          	addi	sp,sp,16
    80002408:	00008067          	ret

000000008000240c <_ZN6ThreadD1Ev>:
Thread::~Thread() noexcept {
    8000240c:	fe010113          	addi	sp,sp,-32
    80002410:	00113c23          	sd	ra,24(sp)
    80002414:	00813823          	sd	s0,16(sp)
    80002418:	00913423          	sd	s1,8(sp)
    8000241c:	02010413          	addi	s0,sp,32
    80002420:	00005797          	auipc	a5,0x5
    80002424:	e8078793          	addi	a5,a5,-384 # 800072a0 <_ZTV6Thread+0x10>
    80002428:	00f53023          	sd	a5,0(a0)
        if (myHandle->isFinished()==true) {
    8000242c:	00853483          	ld	s1,8(a0)

public:

        ~TCB() { if(stack) delete[]stack; }
        using Body = void (*)(void*);
        bool isFinished() const { return finished; }
    80002430:	0284c783          	lbu	a5,40(s1)
    80002434:	02078263          	beqz	a5,80002458 <_ZN6ThreadD1Ev+0x4c>
            delete myHandle;
    80002438:	02048063          	beqz	s1,80002458 <_ZN6ThreadD1Ev+0x4c>
        ~TCB() { if(stack) delete[]stack; }
    8000243c:	0104b503          	ld	a0,16(s1)
    80002440:	00050663          	beqz	a0,8000244c <_ZN6ThreadD1Ev+0x40>
    80002444:	00000097          	auipc	ra,0x0
    80002448:	fa0080e7          	jalr	-96(ra) # 800023e4 <_ZdaPv>
        return MemoryAllocator::memAlloc(n);
    }


    void operator delete(void *ptr) {
        MemoryAllocator::memFree(ptr);
    8000244c:	00048513          	mv	a0,s1
    80002450:	00001097          	auipc	ra,0x1
    80002454:	cd0080e7          	jalr	-816(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
    }
    80002458:	01813083          	ld	ra,24(sp)
    8000245c:	01013403          	ld	s0,16(sp)
    80002460:	00813483          	ld	s1,8(sp)
    80002464:	02010113          	addi	sp,sp,32
    80002468:	00008067          	ret

000000008000246c <_ZN6ThreadD0Ev>:
Thread::~Thread() noexcept {
    8000246c:	fe010113          	addi	sp,sp,-32
    80002470:	00113c23          	sd	ra,24(sp)
    80002474:	00813823          	sd	s0,16(sp)
    80002478:	00913423          	sd	s1,8(sp)
    8000247c:	02010413          	addi	s0,sp,32
    80002480:	00050493          	mv	s1,a0
    }
    80002484:	00000097          	auipc	ra,0x0
    80002488:	f88080e7          	jalr	-120(ra) # 8000240c <_ZN6ThreadD1Ev>
    8000248c:	00048513          	mv	a0,s1
    80002490:	00000097          	auipc	ra,0x0
    80002494:	ec4080e7          	jalr	-316(ra) # 80002354 <_ZdlPv>
    80002498:	01813083          	ld	ra,24(sp)
    8000249c:	01013403          	ld	s0,16(sp)
    800024a0:	00813483          	ld	s1,8(sp)
    800024a4:	02010113          	addi	sp,sp,32
    800024a8:	00008067          	ret

00000000800024ac <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800024ac:	fd010113          	addi	sp,sp,-48
    800024b0:	02113423          	sd	ra,40(sp)
    800024b4:	02813023          	sd	s0,32(sp)
    800024b8:	00913c23          	sd	s1,24(sp)
    800024bc:	01213823          	sd	s2,16(sp)
    800024c0:	01313423          	sd	s3,8(sp)
    800024c4:	01413023          	sd	s4,0(sp)
    800024c8:	03010413          	addi	s0,sp,48
    800024cc:	00050493          	mv	s1,a0
    800024d0:	00058993          	mv	s3,a1
    800024d4:	00060a13          	mv	s4,a2
    800024d8:	00005797          	auipc	a5,0x5
    800024dc:	dc878793          	addi	a5,a5,-568 # 800072a0 <_ZTV6Thread+0x10>
    800024e0:	00f53023          	sd	a5,0(a0)
        return MemoryAllocator::memAlloc(n);
    800024e4:	04800513          	li	a0,72
    800024e8:	00001097          	auipc	ra,0x1
    800024ec:	b00080e7          	jalr	-1280(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
    800024f0:	00050913          	mv	s2,a0
    myHandle=new TCB(body,arg);
    800024f4:	000a0613          	mv	a2,s4
    800024f8:	00098593          	mv	a1,s3
    800024fc:	00000097          	auipc	ra,0x0
    80002500:	b98080e7          	jalr	-1128(ra) # 80002094 <_ZN3TCBC1EPFvPvES0_>
    80002504:	0124b423          	sd	s2,8(s1)
}
    80002508:	02813083          	ld	ra,40(sp)
    8000250c:	02013403          	ld	s0,32(sp)
    80002510:	01813483          	ld	s1,24(sp)
    80002514:	01013903          	ld	s2,16(sp)
    80002518:	00813983          	ld	s3,8(sp)
    8000251c:	00013a03          	ld	s4,0(sp)
    80002520:	03010113          	addi	sp,sp,48
    80002524:	00008067          	ret
    80002528:	00050493          	mv	s1,a0
        MemoryAllocator::memFree(ptr);
    8000252c:	00090513          	mv	a0,s2
    80002530:	00001097          	auipc	ra,0x1
    80002534:	bf0080e7          	jalr	-1040(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
    80002538:	00048513          	mv	a0,s1
    8000253c:	00006097          	auipc	ra,0x6
    80002540:	f3c080e7          	jalr	-196(ra) # 80008478 <_Unwind_Resume>

0000000080002544 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002544:	fe010113          	addi	sp,sp,-32
    80002548:	00113c23          	sd	ra,24(sp)
    8000254c:	00813823          	sd	s0,16(sp)
    80002550:	00913423          	sd	s1,8(sp)
    80002554:	01213023          	sd	s2,0(sp)
    80002558:	02010413          	addi	s0,sp,32
    8000255c:	00050493          	mv	s1,a0
    80002560:	00005797          	auipc	a5,0x5
    80002564:	d4078793          	addi	a5,a5,-704 # 800072a0 <_ZTV6Thread+0x10>
    80002568:	00f53023          	sd	a5,0(a0)
        return MemoryAllocator::memAlloc(n);
    8000256c:	04800513          	li	a0,72
    80002570:	00001097          	auipc	ra,0x1
    80002574:	a78080e7          	jalr	-1416(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
    80002578:	00050913          	mv	s2,a0
    myHandle=new TCB(TCB::wrapper,this);
    8000257c:	00048613          	mv	a2,s1
    80002580:	00005597          	auipc	a1,0x5
    80002584:	d605b583          	ld	a1,-672(a1) # 800072e0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002588:	00000097          	auipc	ra,0x0
    8000258c:	b0c080e7          	jalr	-1268(ra) # 80002094 <_ZN3TCBC1EPFvPvES0_>
    80002590:	0124b423          	sd	s2,8(s1)
}
    80002594:	01813083          	ld	ra,24(sp)
    80002598:	01013403          	ld	s0,16(sp)
    8000259c:	00813483          	ld	s1,8(sp)
    800025a0:	00013903          	ld	s2,0(sp)
    800025a4:	02010113          	addi	sp,sp,32
    800025a8:	00008067          	ret
    800025ac:	00050493          	mv	s1,a0
        MemoryAllocator::memFree(ptr);
    800025b0:	00090513          	mv	a0,s2
    800025b4:	00001097          	auipc	ra,0x1
    800025b8:	b6c080e7          	jalr	-1172(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
    800025bc:	00048513          	mv	a0,s1
    800025c0:	00006097          	auipc	ra,0x6
    800025c4:	eb8080e7          	jalr	-328(ra) # 80008478 <_Unwind_Resume>

00000000800025c8 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    800025c8:	ff010113          	addi	sp,sp,-16
    800025cc:	00113423          	sd	ra,8(sp)
    800025d0:	00813023          	sd	s0,0(sp)
    800025d4:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800025d8:	fffff097          	auipc	ra,0xfffff
    800025dc:	c8c080e7          	jalr	-884(ra) # 80001264 <_Z15thread_dispatchv>
}
    800025e0:	00813083          	ld	ra,8(sp)
    800025e4:	00013403          	ld	s0,0(sp)
    800025e8:	01010113          	addi	sp,sp,16
    800025ec:	00008067          	ret

00000000800025f0 <_ZN6Thread5startEv>:
int Thread::start() {
    800025f0:	ff010113          	addi	sp,sp,-16
    800025f4:	00113423          	sd	ra,8(sp)
    800025f8:	00813023          	sd	s0,0(sp)
    800025fc:	01010413          	addi	s0,sp,16
    thread_create(&myHandle,myHandle->getBody(),myHandle->getArg());
    80002600:	00853783          	ld	a5,8(a0)
    80002604:	0087b603          	ld	a2,8(a5)
    80002608:	0007b583          	ld	a1,0(a5)
    8000260c:	00850513          	addi	a0,a0,8
    80002610:	fffff097          	auipc	ra,0xfffff
    80002614:	c1c080e7          	jalr	-996(ra) # 8000122c <_Z13thread_createPP3TCBPFvPvES2_>
}
    80002618:	00100513          	li	a0,1
    8000261c:	00813083          	ld	ra,8(sp)
    80002620:	00013403          	ld	s0,0(sp)
    80002624:	01010113          	addi	sp,sp,16
    80002628:	00008067          	ret

000000008000262c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000262c:	ff010113          	addi	sp,sp,-16
    80002630:	00113423          	sd	ra,8(sp)
    80002634:	00813023          	sd	s0,0(sp)
    80002638:	01010413          	addi	s0,sp,16
    8000263c:	00005797          	auipc	a5,0x5
    80002640:	c8c78793          	addi	a5,a5,-884 # 800072c8 <_ZTV9Semaphore+0x10>
    80002644:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80002648:	00850513          	addi	a0,a0,8
    8000264c:	fffff097          	auipc	ra,0xfffff
    80002650:	d04080e7          	jalr	-764(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80002654:	00813083          	ld	ra,8(sp)
    80002658:	00013403          	ld	s0,0(sp)
    8000265c:	01010113          	addi	sp,sp,16
    80002660:	00008067          	ret

0000000080002664 <_ZN9Semaphore4waitEv>:

int Semaphore::wait() {
    80002664:	ff010113          	addi	sp,sp,-16
    80002668:	00113423          	sd	ra,8(sp)
    8000266c:	00813023          	sd	s0,0(sp)
    80002670:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002674:	00853503          	ld	a0,8(a0)
    80002678:	fffff097          	auipc	ra,0xfffff
    8000267c:	d3c080e7          	jalr	-708(ra) # 800013b4 <_Z8sem_waitP3SCB>
}
    80002680:	00813083          	ld	ra,8(sp)
    80002684:	00013403          	ld	s0,0(sp)
    80002688:	01010113          	addi	sp,sp,16
    8000268c:	00008067          	ret

0000000080002690 <_ZN9Semaphore6signalEv>:

int Semaphore::signal() {
    80002690:	ff010113          	addi	sp,sp,-16
    80002694:	00113423          	sd	ra,8(sp)
    80002698:	00813023          	sd	s0,0(sp)
    8000269c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800026a0:	00853503          	ld	a0,8(a0)
    800026a4:	fffff097          	auipc	ra,0xfffff
    800026a8:	d40080e7          	jalr	-704(ra) # 800013e4 <_Z10sem_signalP3SCB>
}
    800026ac:	00813083          	ld	ra,8(sp)
    800026b0:	00013403          	ld	s0,0(sp)
    800026b4:	01010113          	addi	sp,sp,16
    800026b8:	00008067          	ret

00000000800026bc <_ZN7Console4getcEv>:

char Console::getc() {
    800026bc:	ff010113          	addi	sp,sp,-16
    800026c0:	00113423          	sd	ra,8(sp)
    800026c4:	00813023          	sd	s0,0(sp)
    800026c8:	01010413          	addi	s0,sp,16
    return ::getc();
    800026cc:	fffff097          	auipc	ra,0xfffff
    800026d0:	c30080e7          	jalr	-976(ra) # 800012fc <_Z4getcv>
}
    800026d4:	00813083          	ld	ra,8(sp)
    800026d8:	00013403          	ld	s0,0(sp)
    800026dc:	01010113          	addi	sp,sp,16
    800026e0:	00008067          	ret

00000000800026e4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    800026e4:	ff010113          	addi	sp,sp,-16
    800026e8:	00113423          	sd	ra,8(sp)
    800026ec:	00813023          	sd	s0,0(sp)
    800026f0:	01010413          	addi	s0,sp,16
    ::putc(c);
    800026f4:	fffff097          	auipc	ra,0xfffff
    800026f8:	c34080e7          	jalr	-972(ra) # 80001328 <_Z4putcc>
}
    800026fc:	00813083          	ld	ra,8(sp)
    80002700:	00013403          	ld	s0,0(sp)
    80002704:	01010113          	addi	sp,sp,16
    80002708:	00008067          	ret

000000008000270c <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    8000270c:	ff010113          	addi	sp,sp,-16
    80002710:	00813423          	sd	s0,8(sp)
    80002714:	01010413          	addi	s0,sp,16
    80002718:	00813403          	ld	s0,8(sp)
    8000271c:	01010113          	addi	sp,sp,16
    80002720:	00008067          	ret

0000000080002724 <_ZN5Riscv10popSppSpieEv>:
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/printing.hpp"
#include "../h/MemoryAllocator.hpp"

void Riscv::popSppSpie() {
    80002724:	ff010113          	addi	sp,sp,-16
    80002728:	00813423          	sd	s0,8(sp)
    8000272c:	01010413          	addi	s0,sp,16

    __asm__ volatile ("csrw sepc, ra");
    80002730:	14109073          	csrw	sepc,ra
    __asm__ volatile ("sret");
    80002734:	10200073          	sret
}
    80002738:	00813403          	ld	s0,8(sp)
    8000273c:	01010113          	addi	sp,sp,16
    80002740:	00008067          	ret

0000000080002744 <_ZN5Riscv20handleSupervisorTrapEv>:

void Riscv::handleSupervisorTrap() {
    80002744:	f9010113          	addi	sp,sp,-112
    80002748:	06113423          	sd	ra,104(sp)
    8000274c:	06813023          	sd	s0,96(sp)
    80002750:	04913c23          	sd	s1,88(sp)
    80002754:	05213823          	sd	s2,80(sp)
    80002758:	05313423          	sd	s3,72(sp)
    8000275c:	07010413          	addi	s0,sp,112
    static void handleSupervisorTrap();
};

inline uint64 Riscv::r_scause() {
    uint64 volatile scause;
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80002760:	142027f3          	csrr	a5,scause
    80002764:	f8f43c23          	sd	a5,-104(s0)
    return scause;
    80002768:	f9843703          	ld	a4,-104(s0)
    uint64 scause = r_scause();
    uint64 kod;

    __asm__ volatile("mv %0, a0" : "=r" (kod)); //koji je sistemski poziv
    8000276c:	00050793          	mv	a5,a0
    if(kod==0x200 && scause==0x0000000000000009UL){
    80002770:	20000693          	li	a3,512
    80002774:	04d78a63          	beq	a5,a3,800027c8 <_ZN5Riscv20handleSupervisorTrapEv+0x84>
        w_sstatus(sstatus);
    }


 else
    if(kod==0x201 && scause==0x0000000000000008UL){
    80002778:	20100693          	li	a3,513
    8000277c:	08d78063          	beq	a5,a3,800027fc <_ZN5Riscv20handleSupervisorTrapEv+0xb8>
        w_sepc(sepc);
        w_sstatus(sstatus);
    }


    else if ((scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)) {
    80002780:	ff870693          	addi	a3,a4,-8
    80002784:	00100613          	li	a2,1
    80002788:	0ad67463          	bgeu	a2,a3,80002830 <_ZN5Riscv20handleSupervisorTrapEv+0xec>
        TCB::dispatch();
     w_sstatus(sstatus);
     w_sepc(sepc);

     return;
    }  else if (scause == 0x8000000000000001UL) {
    8000278c:	fff00793          	li	a5,-1
    80002790:	03f79793          	slli	a5,a5,0x3f
    80002794:	00178793          	addi	a5,a5,1
    80002798:	2af70663          	beq	a4,a5,80002a44 <_ZN5Riscv20handleSupervisorTrapEv+0x300>
        // interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)

        mc_sip(SIP_SSIP);
    } else if (scause == 0x8000000000000009UL) {
    8000279c:	fff00793          	li	a5,-1
    800027a0:	03f79793          	slli	a5,a5,0x3f
    800027a4:	00978793          	addi	a5,a5,9
    800027a8:	2af70463          	beq	a4,a5,80002a50 <_ZN5Riscv20handleSupervisorTrapEv+0x30c>
        console_handler();
    }



}
    800027ac:	06813083          	ld	ra,104(sp)
    800027b0:	06013403          	ld	s0,96(sp)
    800027b4:	05813483          	ld	s1,88(sp)
    800027b8:	05013903          	ld	s2,80(sp)
    800027bc:	04813983          	ld	s3,72(sp)
    800027c0:	07010113          	addi	sp,sp,112
    800027c4:	00008067          	ret
    if(kod==0x200 && scause==0x0000000000000009UL){
    800027c8:	00900693          	li	a3,9
    800027cc:	fad716e3          	bne	a4,a3,80002778 <_ZN5Riscv20handleSupervisorTrapEv+0x34>
    __asm__ volatile ("csrw scause, %[scause]" : : [scause] "r"(scause));
}

inline uint64 Riscv::r_sepc() {
    uint64 volatile sepc;
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800027d0:	141027f3          	csrr	a5,sepc
    800027d4:	faf43423          	sd	a5,-88(s0)
    return sepc;
    800027d8:	fa843783          	ld	a5,-88(s0)
        uint64 sepc = r_sepc() + 4;
    800027dc:	00478793          	addi	a5,a5,4
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
}

inline uint64 Riscv::r_sstatus() {
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800027e0:	10002773          	csrr	a4,sstatus
    800027e4:	fae43023          	sd	a4,-96(s0)
    return sstatus;
    800027e8:	fa043703          	ld	a4,-96(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800027ec:	14179073          	csrw	sepc,a5
}
inline void Riscv::w_sstatus(uint64 sstatus) {
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800027f0:	03200793          	li	a5,50
    800027f4:	10079073          	csrw	sstatus,a5
}
    800027f8:	fb5ff06f          	j	800027ac <_ZN5Riscv20handleSupervisorTrapEv+0x68>
    if(kod==0x201 && scause==0x0000000000000008UL){
    800027fc:	00800693          	li	a3,8
    80002800:	f8d710e3          	bne	a4,a3,80002780 <_ZN5Riscv20handleSupervisorTrapEv+0x3c>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002804:	141027f3          	csrr	a5,sepc
    80002808:	faf43c23          	sd	a5,-72(s0)
    return sepc;
    8000280c:	fb843783          	ld	a5,-72(s0)
        uint64 sepc = r_sepc() + 4;
    80002810:	00478793          	addi	a5,a5,4
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002814:	10002773          	csrr	a4,sstatus
    80002818:	fae43823          	sd	a4,-80(s0)
    return sstatus;
    8000281c:	fb043703          	ld	a4,-80(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002820:	14179073          	csrw	sepc,a5
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002824:	03300793          	li	a5,51
    80002828:	10079073          	csrw	sstatus,a5
}
    8000282c:	f81ff06f          	j	800027ac <_ZN5Riscv20handleSupervisorTrapEv+0x68>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002830:	14102773          	csrr	a4,sepc
    80002834:	fce43423          	sd	a4,-56(s0)
    return sepc;
    80002838:	fc843483          	ld	s1,-56(s0)
        uint64 sepc = r_sepc() + 4;
    8000283c:	00448493          	addi	s1,s1,4
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002840:	10002773          	csrr	a4,sstatus
    80002844:	fce43023          	sd	a4,-64(s0)
    return sstatus;
    80002848:	fc043903          	ld	s2,-64(s0)
        if (kod == MEMALLOC) {
    8000284c:	00100713          	li	a4,1
    80002850:	08e78463          	beq	a5,a4,800028d8 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
        } else if(kod==0x500){
    80002854:	50000713          	li	a4,1280
    80002858:	08e78a63          	beq	a5,a4,800028ec <_ZN5Riscv20handleSupervisorTrapEv+0x1a8>
        }else if(kod==0x501){
    8000285c:	50100713          	li	a4,1281
    80002860:	0ae78c63          	beq	a5,a4,80002918 <_ZN5Riscv20handleSupervisorTrapEv+0x1d4>
        }else if(kod==0x61){
    80002864:	06100713          	li	a4,97
    80002868:	0ce78063          	beq	a5,a4,80002928 <_ZN5Riscv20handleSupervisorTrapEv+0x1e4>
        }else if (kod == MEMFREE) {
    8000286c:	00200713          	li	a4,2
    80002870:	0ce78463          	beq	a5,a4,80002938 <_ZN5Riscv20handleSupervisorTrapEv+0x1f4>
        } else if (kod == THRCRT) {
    80002874:	00b00713          	li	a4,11
    80002878:	0ce78863          	beq	a5,a4,80002948 <_ZN5Riscv20handleSupervisorTrapEv+0x204>
        } else if (kod == THREXIT) {
    8000287c:	00c00713          	li	a4,12
    80002880:	0ee78a63          	beq	a5,a4,80002974 <_ZN5Riscv20handleSupervisorTrapEv+0x230>
        } else if (kod == THRDSP) {
    80002884:	00d00713          	li	a4,13
    80002888:	06e78c63          	beq	a5,a4,80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
        } else if(kod==EXIT){
    8000288c:	04600713          	li	a4,70
    80002890:	0ee78e63          	beq	a5,a4,8000298c <_ZN5Riscv20handleSupervisorTrapEv+0x248>
        }else if (kod == SEMOPEN) {
    80002894:	01500713          	li	a4,21
    80002898:	12e78863          	beq	a5,a4,800029c8 <_ZN5Riscv20handleSupervisorTrapEv+0x284>
        } else if (kod == SEMCLOSE) {
    8000289c:	01600713          	li	a4,22
    800028a0:	14e78263          	beq	a5,a4,800029e4 <_ZN5Riscv20handleSupervisorTrapEv+0x2a0>
        } else if (kod == SEMWAIT) {
    800028a4:	01700713          	li	a4,23
    800028a8:	16e78663          	beq	a5,a4,80002a14 <_ZN5Riscv20handleSupervisorTrapEv+0x2d0>
        } else if (kod == SEMSIGNAL) {
    800028ac:	01800713          	li	a4,24
    800028b0:	16e78a63          	beq	a5,a4,80002a24 <_ZN5Riscv20handleSupervisorTrapEv+0x2e0>
        } else if (kod == GETC) {
    800028b4:	02900713          	li	a4,41
    800028b8:	16e78e63          	beq	a5,a4,80002a34 <_ZN5Riscv20handleSupervisorTrapEv+0x2f0>
        } else if (kod == PUTC) {
    800028bc:	02a00713          	li	a4,42
    800028c0:	04e79063          	bne	a5,a4,80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            __asm__ volatile("mv %0,a1":"=r"(c));
    800028c4:	00058513          	mv	a0,a1
            __putc(c);
    800028c8:	0ff57513          	andi	a0,a0,255
    800028cc:	00003097          	auipc	ra,0x3
    800028d0:	cb0080e7          	jalr	-848(ra) # 8000557c <__putc>
    800028d4:	02c0006f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
           __asm__ volatile("mv %0,a1" : "=r"(size)); //pokupi argument iz a1
    800028d8:	00058513          	mv	a0,a1
           ptr= MemoryAllocator::memAlloc(size); //uzmi povratnu vrednost
    800028dc:	00000097          	auipc	ra,0x0
    800028e0:	70c080e7          	jalr	1804(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
          __asm__ volatile("mv a0,%0"::"r"(ptr));
    800028e4:	00050513          	mv	a0,a0
    800028e8:	0180006f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            id=TCB::running->getId();
    800028ec:	00005797          	auipc	a5,0x5
    800028f0:	a147b783          	ld	a5,-1516(a5) # 80007300 <_GLOBAL_OFFSET_TABLE_+0x28>
    800028f4:	0007b783          	ld	a5,0(a5)
        void setBlocked(bool value){blocked=value;}
        bool isBlocked()const{return blocked;}
        bool isCreated()const{return created;}
        Body getBody()const{return body;}
        void* getArg()const{return arg;}
        int getId(){return id;}
    800028f8:	02c7a783          	lw	a5,44(a5)
            __asm__ volatile("mv a0,%0"::"r"(id));
    800028fc:	00078513          	mv	a0,a5
     __asm__ volatile("sd a0,10*8(s0)");
    80002900:	04a43823          	sd	a0,80(s0)
        TCB::dispatch();
    80002904:	fffff097          	auipc	ra,0xfffff
    80002908:	7ec080e7          	jalr	2028(ra) # 800020f0 <_ZN3TCB8dispatchEv>
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000290c:	10091073          	csrw	sstatus,s2
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002910:	14149073          	csrw	sepc,s1
     return;
    80002914:	e99ff06f          	j	800027ac <_ZN5Riscv20handleSupervisorTrapEv+0x68>
            __asm__ volatile("mv %0,a1":"=r"(t));
    80002918:	00058793          	mv	a5,a1
        void setFinished(bool value) { finished = value; }
    8000291c:	00100713          	li	a4,1
    80002920:	02e78423          	sb	a4,40(a5)
    80002924:	fddff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            __asm__ volatile("mv %0,a1":"=r"(t));
    80002928:	00058513          	mv	a0,a1
            t->join();
    8000292c:	00000097          	auipc	ra,0x0
    80002930:	8fc080e7          	jalr	-1796(ra) # 80002228 <_ZN3TCB4joinEv>
    80002934:	fcdff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            __asm__ volatile("mv %0,a1": "=r"(ptr1));
    80002938:	00058513          	mv	a0,a1
            MemoryAllocator::memFree(ptr1); //stavlja odmah u a0
    8000293c:	00000097          	auipc	ra,0x0
    80002940:	7e4080e7          	jalr	2020(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
    80002944:	fbdff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            void* stack=MemoryAllocator::memAlloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    80002948:	00008537          	lui	a0,0x8
    8000294c:	00000097          	auipc	ra,0x0
    80002950:	69c080e7          	jalr	1692(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
    80002954:	00050613          	mv	a2,a0
            __asm__ volatile ("ld %0, 11 * 8(s0)":  "=r"(handle));
    80002958:	05843983          	ld	s3,88(s0)
            __asm__ volatile ("ld %0, 12 * 8(s0)":  "=r"(start_routine));
    8000295c:	06043503          	ld	a0,96(s0)
            __asm__ volatile ("ld %0, 13 * 8(s0)":  "=r"(arg));
    80002960:	06843583          	ld	a1,104(s0)
            *handle = TCB::createThread(start_routine, arg,stack);
    80002964:	fffff097          	auipc	ra,0xfffff
    80002968:	68c080e7          	jalr	1676(ra) # 80001ff0 <_ZN3TCB12createThreadEPFvPvES0_S0_>
    8000296c:	00a9b023          	sd	a0,0(s3)
    80002970:	f91ff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            TCB::running->setFinished(true);
    80002974:	00005797          	auipc	a5,0x5
    80002978:	98c7b783          	ld	a5,-1652(a5) # 80007300 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000297c:	0007b783          	ld	a5,0(a5)
    80002980:	00100713          	li	a4,1
    80002984:	02e78423          	sb	a4,40(a5)
    80002988:	f79ff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            delete TCB::running;
    8000298c:	00005797          	auipc	a5,0x5
    80002990:	9747b783          	ld	a5,-1676(a5) # 80007300 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002994:	0007b983          	ld	s3,0(a5)
    80002998:	02098063          	beqz	s3,800029b8 <_ZN5Riscv20handleSupervisorTrapEv+0x274>
        ~TCB() { if(stack) delete[]stack; }
    8000299c:	0109b503          	ld	a0,16(s3)
    800029a0:	00050663          	beqz	a0,800029ac <_ZN5Riscv20handleSupervisorTrapEv+0x268>
    800029a4:	00000097          	auipc	ra,0x0
    800029a8:	a40080e7          	jalr	-1472(ra) # 800023e4 <_ZdaPv>
        return MemoryAllocator::memAlloc(n);
    }


    void operator delete(void *ptr) {
        MemoryAllocator::memFree(ptr);
    800029ac:	00098513          	mv	a0,s3
    800029b0:	00000097          	auipc	ra,0x0
    800029b4:	770080e7          	jalr	1904(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
            __asm__ volatile("mv a0,%0"::"r"(0x201));
    800029b8:	20100793          	li	a5,513
    800029bc:	00078513          	mv	a0,a5
            __asm__ volatile("ecall");
    800029c0:	00000073          	ecall
    800029c4:	f3dff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            __asm__ volatile ("ld %0, 11 * 8(s0)":  "=r"(semHandle));
    800029c8:	05843983          	ld	s3,88(s0)
            __asm__ volatile ("ld %0, 12 * 8(s0)":  "=r"(semInit));
    800029cc:	06043503          	ld	a0,96(s0)
            *semHandle = SCB::createSCB(semInit);
    800029d0:	0005051b          	sext.w	a0,a0
    800029d4:	00000097          	auipc	ra,0x0
    800029d8:	11c080e7          	jalr	284(ra) # 80002af0 <_ZN3SCB9createSCBEi>
    800029dc:	00a9b023          	sd	a0,0(s3)
    800029e0:	f21ff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            __asm__ volatile("mv %0, a1" : "=r" (id));
    800029e4:	00058993          	mv	s3,a1
            id->closeSem();
    800029e8:	00098513          	mv	a0,s3
    800029ec:	00000097          	auipc	ra,0x0
    800029f0:	2ec080e7          	jalr	748(ra) # 80002cd8 <_ZN3SCB8closeSemEv>
            delete id;
    800029f4:	f00986e3          	beqz	s3,80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
    800029f8:	00098513          	mv	a0,s3
    800029fc:	00000097          	auipc	ra,0x0
    80002a00:	148080e7          	jalr	328(ra) # 80002b44 <_ZN3SCBD1Ev>
    void *operator new(uint64 n) {
        return MemoryAllocator::memAlloc(n);
    }

    void operator delete(void *ptr) {
        MemoryAllocator::memFree(ptr);
    80002a04:	00098513          	mv	a0,s3
    80002a08:	00000097          	auipc	ra,0x0
    80002a0c:	718080e7          	jalr	1816(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
    }
    80002a10:	ef1ff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            __asm__ volatile("mv %0, a1" : "=r" (sem));
    80002a14:	00058513          	mv	a0,a1
            sem->wait();
    80002a18:	00000097          	auipc	ra,0x0
    80002a1c:	144080e7          	jalr	324(ra) # 80002b5c <_ZN3SCB4waitEv>
    80002a20:	ee1ff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            __asm__ volatile("mv %0,a1":"=r"(sem));
    80002a24:	00058513          	mv	a0,a1
            sem->signal();
    80002a28:	00000097          	auipc	ra,0x0
    80002a2c:	208080e7          	jalr	520(ra) # 80002c30 <_ZN3SCB6signalEv>
    80002a30:	ed1ff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
            c = __getc();
    80002a34:	00003097          	auipc	ra,0x3
    80002a38:	b84080e7          	jalr	-1148(ra) # 800055b8 <__getc>
           __asm__ volatile("mv a0,%0"::"r"(c));
    80002a3c:	00050513          	mv	a0,a0
    80002a40:	ec1ff06f          	j	80002900 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80002a44:	00200793          	li	a5,2
    80002a48:	1447b073          	csrc	sip,a5
}
    80002a4c:	d61ff06f          	j	800027ac <_ZN5Riscv20handleSupervisorTrapEv+0x68>
        console_handler();
    80002a50:	00003097          	auipc	ra,0x3
    80002a54:	ba0080e7          	jalr	-1120(ra) # 800055f0 <console_handler>
    80002a58:	d55ff06f          	j	800027ac <_ZN5Riscv20handleSupervisorTrapEv+0x68>

0000000080002a5c <_ZN5Riscv4initEv>:
void Riscv:: init() {
    80002a5c:	fe010113          	addi	sp,sp,-32
    80002a60:	00113c23          	sd	ra,24(sp)
    80002a64:	00813823          	sd	s0,16(sp)
    80002a68:	02010413          	addi	s0,sp,32
    w_stvec((uint64) &Riscv::supervisorTrap);
    80002a6c:	00005797          	auipc	a5,0x5
    80002a70:	8847b783          	ld	a5,-1916(a5) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x18>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80002a74:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002a78:	00200793          	li	a5,2
    80002a7c:	1007a073          	csrs	sstatus,a5
    ms_sstatus(Riscv::SSTATUS_SIE);
    __asm__ volatile("mv a0,%0"::"r"(0x200));
    80002a80:	20000793          	li	a5,512
    80002a84:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002a88:	00000073          	ecall
    TCB* running;
    thread_create(&running, nullptr, nullptr);
    80002a8c:	00000613          	li	a2,0
    80002a90:	00000593          	li	a1,0
    80002a94:	fe840513          	addi	a0,s0,-24
    80002a98:	ffffe097          	auipc	ra,0xffffe
    80002a9c:	794080e7          	jalr	1940(ra) # 8000122c <_Z13thread_createPP3TCBPFvPvES2_>
 //   TCB::running = running;
   // ms_sstatus(Riscv::SSTATUS_SIE);
}
    80002aa0:	01813083          	ld	ra,24(sp)
    80002aa4:	01013403          	ld	s0,16(sp)
    80002aa8:	02010113          	addi	sp,sp,32
    80002aac:	00008067          	ret

0000000080002ab0 <_ZN3SCBC1Ei>:
#include "../h/SCB.hpp"
#include "../h/scheduler.hpp"



SCB::SCB(int init) {
    80002ab0:	ff010113          	addi	sp,sp,-16
    80002ab4:	00813423          	sd	s0,8(sp)
    80002ab8:	01010413          	addi	s0,sp,16
    Queue() : prvi(nullptr), posl(nullptr) {}
    80002abc:	00053023          	sd	zero,0(a0) # 8000 <_entry-0x7fff8000>
    80002ac0:	00053423          	sd	zero,8(a0)

   // waiting=new Queue<TCB>;
    value = init;
    80002ac4:	00b52e23          	sw	a1,28(a0)

}
    80002ac8:	00813403          	ld	s0,8(sp)
    80002acc:	01010113          	addi	sp,sp,16
    80002ad0:	00008067          	ret

0000000080002ad4 <_ZNK3SCB3valEv>:
int SCB::val()const {
    80002ad4:	ff010113          	addi	sp,sp,-16
    80002ad8:	00813423          	sd	s0,8(sp)
    80002adc:	01010413          	addi	s0,sp,16
    return value;
}
    80002ae0:	01c52503          	lw	a0,28(a0)
    80002ae4:	00813403          	ld	s0,8(sp)
    80002ae8:	01010113          	addi	sp,sp,16
    80002aec:	00008067          	ret

0000000080002af0 <_ZN3SCB9createSCBEi>:
SCB *SCB::createSCB(int init) {
    80002af0:	fe010113          	addi	sp,sp,-32
    80002af4:	00113c23          	sd	ra,24(sp)
    80002af8:	00813823          	sd	s0,16(sp)
    80002afc:	00913423          	sd	s1,8(sp)
    80002b00:	01213023          	sd	s2,0(sp)
    80002b04:	02010413          	addi	s0,sp,32
    80002b08:	00050913          	mv	s2,a0
    SCB(int init = 1);
    static SCB* createSCB(int init);
    ~SCB();
    int val() const;
    void *operator new(uint64 n) {
        return MemoryAllocator::memAlloc(n);
    80002b0c:	02000513          	li	a0,32
    80002b10:	00000097          	auipc	ra,0x0
    80002b14:	4d8080e7          	jalr	1240(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
    80002b18:	00050493          	mv	s1,a0

    return new SCB(init);
    80002b1c:	00090593          	mv	a1,s2
    80002b20:	00000097          	auipc	ra,0x0
    80002b24:	f90080e7          	jalr	-112(ra) # 80002ab0 <_ZN3SCBC1Ei>

}
    80002b28:	00048513          	mv	a0,s1
    80002b2c:	01813083          	ld	ra,24(sp)
    80002b30:	01013403          	ld	s0,16(sp)
    80002b34:	00813483          	ld	s1,8(sp)
    80002b38:	00013903          	ld	s2,0(sp)
    80002b3c:	02010113          	addi	sp,sp,32
    80002b40:	00008067          	ret

0000000080002b44 <_ZN3SCBD1Ev>:
SCB::~SCB() {
    80002b44:	ff010113          	addi	sp,sp,-16
    80002b48:	00813423          	sd	s0,8(sp)
    80002b4c:	01010413          	addi	s0,sp,16
  //  waiting= nullptr;

}
    80002b50:	00813403          	ld	s0,8(sp)
    80002b54:	01010113          	addi	sp,sp,16
    80002b58:	00008067          	ret

0000000080002b5c <_ZN3SCB4waitEv>:
int SCB::wait() {
    int ret = 1;
        if (--value<0) {
    80002b5c:	01c52783          	lw	a5,28(a0)
    80002b60:	fff7879b          	addiw	a5,a5,-1
    80002b64:	00f52e23          	sw	a5,28(a0)
    80002b68:	02079713          	slli	a4,a5,0x20
    80002b6c:	00074663          	bltz	a4,80002b78 <_ZN3SCB4waitEv+0x1c>
    int ret = 1;
    80002b70:	00100513          	li	a0,1
        if(ret == 0)
           // thread_dispatch();
           TCB::dispatch();
    return ret;

}
    80002b74:	00008067          	ret
int SCB::wait() {
    80002b78:	fe010113          	addi	sp,sp,-32
    80002b7c:	00113c23          	sd	ra,24(sp)
    80002b80:	00813823          	sd	s0,16(sp)
    80002b84:	00913423          	sd	s1,8(sp)
    80002b88:	01213023          	sd	s2,0(sp)
    80002b8c:	02010413          	addi	s0,sp,32
    80002b90:	00050493          	mv	s1,a0
          TCB::running->setBlocked(true);
    80002b94:	00004797          	auipc	a5,0x4
    80002b98:	76c7b783          	ld	a5,1900(a5) # 80007300 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002b9c:	0007b903          	ld	s2,0(a5)
        void setBlocked(bool value){blocked=value;}
    80002ba0:	00100793          	li	a5,1
    80002ba4:	02f904a3          	sb	a5,41(s2)
        for (temp = prvi; temp; temp= temp->sled);
    80002ba8:	00053703          	ld	a4,0(a0)
    80002bac:	00070793          	mv	a5,a4
    80002bb0:	00078663          	beqz	a5,80002bbc <_ZN3SCB4waitEv+0x60>
    80002bb4:	0087b783          	ld	a5,8(a5)
    80002bb8:	ff9ff06f          	j	80002bb0 <_ZN3SCB4waitEv+0x54>
        if (prvi== nullptr) prvi= posl = new Elem(tcb);
    80002bbc:	04070a63          	beqz	a4,80002c10 <_ZN3SCB4waitEv+0xb4>
           return MemoryAllocator::memAlloc(n);
    80002bc0:	01000513          	li	a0,16
    80002bc4:	00000097          	auipc	ra,0x0
    80002bc8:	424080e7          	jalr	1060(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
            this->tcb=tcb;
    80002bcc:	01253023          	sd	s2,0(a0)
            sled= nullptr;
    80002bd0:	00053423          	sd	zero,8(a0)
        else posl = posl->sled = new Elem(tcb);
    80002bd4:	0084b783          	ld	a5,8(s1)
    80002bd8:	00a7b423          	sd	a0,8(a5)
    80002bdc:	00a4b423          	sd	a0,8(s1)
        vel++;
    80002be0:	0104a783          	lw	a5,16(s1)
    80002be4:	0017879b          	addiw	a5,a5,1
    80002be8:	00f4a823          	sw	a5,16(s1)
           TCB::dispatch();
    80002bec:	fffff097          	auipc	ra,0xfffff
    80002bf0:	504080e7          	jalr	1284(ra) # 800020f0 <_ZN3TCB8dispatchEv>
          ret=0;
    80002bf4:	00000513          	li	a0,0
}
    80002bf8:	01813083          	ld	ra,24(sp)
    80002bfc:	01013403          	ld	s0,16(sp)
    80002c00:	00813483          	ld	s1,8(sp)
    80002c04:	00013903          	ld	s2,0(sp)
    80002c08:	02010113          	addi	sp,sp,32
    80002c0c:	00008067          	ret
           return MemoryAllocator::memAlloc(n);
    80002c10:	01000513          	li	a0,16
    80002c14:	00000097          	auipc	ra,0x0
    80002c18:	3d4080e7          	jalr	980(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
            this->tcb=tcb;
    80002c1c:	01253023          	sd	s2,0(a0)
            sled= nullptr;
    80002c20:	00053423          	sd	zero,8(a0)
        if (prvi== nullptr) prvi= posl = new Elem(tcb);
    80002c24:	00a4b423          	sd	a0,8(s1)
    80002c28:	00a4b023          	sd	a0,0(s1)
    80002c2c:	fb5ff06f          	j	80002be0 <_ZN3SCB4waitEv+0x84>

0000000080002c30 <_ZN3SCB6signalEv>:
int SCB::signal() {
    80002c30:	fe010113          	addi	sp,sp,-32
    80002c34:	00113c23          	sd	ra,24(sp)
    80002c38:	00813823          	sd	s0,16(sp)
    80002c3c:	00913423          	sd	s1,8(sp)
    80002c40:	01213023          	sd	s2,0(sp)
    80002c44:	02010413          	addi	s0,sp,32
    80002c48:	00050493          	mv	s1,a0
   ret=1;
    80002c4c:	00100793          	li	a5,1
    80002c50:	00f52c23          	sw	a5,24(a0)
   TCB*t=nullptr;
    if(++value<=0) {
    80002c54:	01c52783          	lw	a5,28(a0)
    80002c58:	0017879b          	addiw	a5,a5,1
    80002c5c:	0007871b          	sext.w	a4,a5
    80002c60:	00f52e23          	sw	a5,28(a0)
    80002c64:	02e05063          	blez	a4,80002c84 <_ZN3SCB6signalEv+0x54>
            Scheduler::put(t);
        ret = 0;
    }

    return ret;
}
    80002c68:	0184a503          	lw	a0,24(s1)
    80002c6c:	01813083          	ld	ra,24(sp)
    80002c70:	01013403          	ld	s0,16(sp)
    80002c74:	00813483          	ld	s1,8(sp)
    80002c78:	00013903          	ld	s2,0(sp)
    80002c7c:	02010113          	addi	sp,sp,32
    80002c80:	00008067          	ret
        if (prvi != nullptr) {
    80002c84:	00053503          	ld	a0,0(a0)
    80002c88:	04050463          	beqz	a0,80002cd0 <_ZN3SCB6signalEv+0xa0>
            prvi=prvi->sled;
    80002c8c:	00853783          	ld	a5,8(a0)
    80002c90:	00f4b023          	sd	a5,0(s1)
            if (prvi== nullptr)
    80002c94:	02078a63          	beqz	a5,80002cc8 <_ZN3SCB6signalEv+0x98>
            ret = temp->tcb;
    80002c98:	00053903          	ld	s2,0(a0)
            MemoryAllocator::memFree(ptr);
    80002c9c:	00000097          	auipc	ra,0x0
    80002ca0:	484080e7          	jalr	1156(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
            vel--;
    80002ca4:	0104a783          	lw	a5,16(s1)
    80002ca8:	fff7879b          	addiw	a5,a5,-1
    80002cac:	00f4a823          	sw	a5,16(s1)
    80002cb0:	020904a3          	sb	zero,41(s2)
            Scheduler::put(t);
    80002cb4:	00090513          	mv	a0,s2
    80002cb8:	00000097          	auipc	ra,0x0
    80002cbc:	17c080e7          	jalr	380(ra) # 80002e34 <_ZN9Scheduler3putEP3TCB>
        ret = 0;
    80002cc0:	0004ac23          	sw	zero,24(s1)
    80002cc4:	fa5ff06f          	j	80002c68 <_ZN3SCB6signalEv+0x38>
                posl= nullptr;
    80002cc8:	0004b423          	sd	zero,8(s1)
    80002ccc:	fcdff06f          	j	80002c98 <_ZN3SCB6signalEv+0x68>
        T* ret = 0;
    80002cd0:	00050913          	mv	s2,a0
    80002cd4:	fddff06f          	j	80002cb0 <_ZN3SCB6signalEv+0x80>

0000000080002cd8 <_ZN3SCB8closeSemEv>:

void SCB::closeSem() {
    80002cd8:	fd010113          	addi	sp,sp,-48
    80002cdc:	02113423          	sd	ra,40(sp)
    80002ce0:	02813023          	sd	s0,32(sp)
    80002ce4:	00913c23          	sd	s1,24(sp)
    80002ce8:	01213823          	sd	s2,16(sp)
    80002cec:	01313423          	sd	s3,8(sp)
    80002cf0:	03010413          	addi	s0,sp,48
    80002cf4:	00050493          	mv	s1,a0
    TCB*t= nullptr;
for(int i=0;i<waiting.getVel();i++) {
    80002cf8:	00000993          	li	s3,0
    80002cfc:	0380006f          	j	80002d34 <_ZN3SCB8closeSemEv+0x5c>
                posl= nullptr;
    80002d00:	0004b423          	sd	zero,8(s1)
            ret = temp->tcb;
    80002d04:	00053903          	ld	s2,0(a0)
            MemoryAllocator::memFree(ptr);
    80002d08:	00000097          	auipc	ra,0x0
    80002d0c:	418080e7          	jalr	1048(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
            vel--;
    80002d10:	0104a783          	lw	a5,16(s1)
    80002d14:	fff7879b          	addiw	a5,a5,-1
    80002d18:	00f4a823          	sw	a5,16(s1)
    t = waiting.izbrisiPrvi();
    if(t== nullptr) {
    80002d1c:	04090063          	beqz	s2,80002d5c <_ZN3SCB8closeSemEv+0x84>
    80002d20:	020904a3          	sb	zero,41(s2)
        return;
    }
        t->setBlocked(false);
        Scheduler::put(t);
    80002d24:	00090513          	mv	a0,s2
    80002d28:	00000097          	auipc	ra,0x0
    80002d2c:	10c080e7          	jalr	268(ra) # 80002e34 <_ZN9Scheduler3putEP3TCB>
for(int i=0;i<waiting.getVel();i++) {
    80002d30:	0019899b          	addiw	s3,s3,1
    int getVel()const{return vel;}
    80002d34:	0104a783          	lw	a5,16(s1)
    80002d38:	02f9d263          	bge	s3,a5,80002d5c <_ZN3SCB8closeSemEv+0x84>
        if (prvi != nullptr) {
    80002d3c:	0004b503          	ld	a0,0(s1)
    80002d40:	00050a63          	beqz	a0,80002d54 <_ZN3SCB8closeSemEv+0x7c>
            prvi=prvi->sled;
    80002d44:	00853783          	ld	a5,8(a0)
    80002d48:	00f4b023          	sd	a5,0(s1)
            if (prvi== nullptr)
    80002d4c:	fa079ce3          	bnez	a5,80002d04 <_ZN3SCB8closeSemEv+0x2c>
    80002d50:	fb1ff06f          	j	80002d00 <_ZN3SCB8closeSemEv+0x28>
        T* ret = 0;
    80002d54:	00050913          	mv	s2,a0
    80002d58:	fc5ff06f          	j	80002d1c <_ZN3SCB8closeSemEv+0x44>
}
    80002d5c:	02813083          	ld	ra,40(sp)
    80002d60:	02013403          	ld	s0,32(sp)
    80002d64:	01813483          	ld	s1,24(sp)
    80002d68:	01013903          	ld	s2,16(sp)
    80002d6c:	00813983          	ld	s3,8(sp)
    80002d70:	03010113          	addi	sp,sp,48
    80002d74:	00008067          	ret

0000000080002d78 <_Z41__static_initialization_and_destruction_0ii>:
    return readyQueue.izbrisiPrvi();
}

void Scheduler::put(TCB *tcb) {
    readyQueue.dodaj(tcb);
    80002d78:	ff010113          	addi	sp,sp,-16
    80002d7c:	00813423          	sd	s0,8(sp)
    80002d80:	01010413          	addi	s0,sp,16
    80002d84:	00100793          	li	a5,1
    80002d88:	00f50863          	beq	a0,a5,80002d98 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002d8c:	00813403          	ld	s0,8(sp)
    80002d90:	01010113          	addi	sp,sp,16
    80002d94:	00008067          	ret
    80002d98:	000107b7          	lui	a5,0x10
    80002d9c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002da0:	fef596e3          	bne	a1,a5,80002d8c <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *prvi, *posl;
    int vel;
public:
    Queue() : prvi(nullptr), posl(nullptr) {}
    80002da4:	00004797          	auipc	a5,0x4
    80002da8:	5ec78793          	addi	a5,a5,1516 # 80007390 <_ZN9Scheduler10readyQueueE>
    80002dac:	0007b023          	sd	zero,0(a5)
    80002db0:	0007b423          	sd	zero,8(a5)
    80002db4:	fd9ff06f          	j	80002d8c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002db8 <_ZN9Scheduler3getEv>:
TCB *Scheduler::get() {
    80002db8:	fe010113          	addi	sp,sp,-32
    80002dbc:	00113c23          	sd	ra,24(sp)
    80002dc0:	00813823          	sd	s0,16(sp)
    80002dc4:	00913423          	sd	s1,8(sp)
    80002dc8:	02010413          	addi	s0,sp,32
        vel++;

    }
    T *izbrisiPrvi(){
        T* ret = 0;
        if (prvi != nullptr) {
    80002dcc:	00004517          	auipc	a0,0x4
    80002dd0:	5c453503          	ld	a0,1476(a0) # 80007390 <_ZN9Scheduler10readyQueueE>
    80002dd4:	04050c63          	beqz	a0,80002e2c <_ZN9Scheduler3getEv+0x74>

            Elem* temp = prvi;
            prvi=prvi->sled;
    80002dd8:	00853783          	ld	a5,8(a0)
    80002ddc:	00004717          	auipc	a4,0x4
    80002de0:	5af73a23          	sd	a5,1460(a4) # 80007390 <_ZN9Scheduler10readyQueueE>
            if (prvi== nullptr)
    80002de4:	02078e63          	beqz	a5,80002e20 <_ZN9Scheduler3getEv+0x68>
                posl= nullptr;
            ret = temp->tcb;
    80002de8:	00053483          	ld	s1,0(a0)
            MemoryAllocator::memFree(ptr);
    80002dec:	00000097          	auipc	ra,0x0
    80002df0:	334080e7          	jalr	820(ra) # 80003120 <_ZN15MemoryAllocator7memFreeEPv>
            delete temp;
            vel--;
    80002df4:	00004717          	auipc	a4,0x4
    80002df8:	59c70713          	addi	a4,a4,1436 # 80007390 <_ZN9Scheduler10readyQueueE>
    80002dfc:	01072783          	lw	a5,16(a4)
    80002e00:	fff7879b          	addiw	a5,a5,-1
    80002e04:	00f72823          	sw	a5,16(a4)
}
    80002e08:	00048513          	mv	a0,s1
    80002e0c:	01813083          	ld	ra,24(sp)
    80002e10:	01013403          	ld	s0,16(sp)
    80002e14:	00813483          	ld	s1,8(sp)
    80002e18:	02010113          	addi	sp,sp,32
    80002e1c:	00008067          	ret
                posl= nullptr;
    80002e20:	00004797          	auipc	a5,0x4
    80002e24:	5607bc23          	sd	zero,1400(a5) # 80007398 <_ZN9Scheduler10readyQueueE+0x8>
    80002e28:	fc1ff06f          	j	80002de8 <_ZN9Scheduler3getEv+0x30>
        T* ret = 0;
    80002e2c:	00050493          	mv	s1,a0
    return readyQueue.izbrisiPrvi();
    80002e30:	fd9ff06f          	j	80002e08 <_ZN9Scheduler3getEv+0x50>

0000000080002e34 <_ZN9Scheduler3putEP3TCB>:
void Scheduler::put(TCB *tcb) {
    80002e34:	fe010113          	addi	sp,sp,-32
    80002e38:	00113c23          	sd	ra,24(sp)
    80002e3c:	00813823          	sd	s0,16(sp)
    80002e40:	00913423          	sd	s1,8(sp)
    80002e44:	02010413          	addi	s0,sp,32
    80002e48:	00050493          	mv	s1,a0
        for (temp = prvi; temp; temp= temp->sled);
    80002e4c:	00004717          	auipc	a4,0x4
    80002e50:	54473703          	ld	a4,1348(a4) # 80007390 <_ZN9Scheduler10readyQueueE>
    80002e54:	00070793          	mv	a5,a4
    80002e58:	00078663          	beqz	a5,80002e64 <_ZN9Scheduler3putEP3TCB+0x30>
    80002e5c:	0087b783          	ld	a5,8(a5)
    80002e60:	ff9ff06f          	j	80002e58 <_ZN9Scheduler3putEP3TCB+0x24>
        if (prvi== nullptr) prvi= posl = new Elem(tcb);
    80002e64:	04070a63          	beqz	a4,80002eb8 <_ZN9Scheduler3putEP3TCB+0x84>
           return MemoryAllocator::memAlloc(n);
    80002e68:	01000513          	li	a0,16
    80002e6c:	00000097          	auipc	ra,0x0
    80002e70:	17c080e7          	jalr	380(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
            this->tcb=tcb;
    80002e74:	00953023          	sd	s1,0(a0)
            sled= nullptr;
    80002e78:	00053423          	sd	zero,8(a0)
        else posl = posl->sled = new Elem(tcb);
    80002e7c:	00004797          	auipc	a5,0x4
    80002e80:	51478793          	addi	a5,a5,1300 # 80007390 <_ZN9Scheduler10readyQueueE>
    80002e84:	0087b703          	ld	a4,8(a5)
    80002e88:	00a73423          	sd	a0,8(a4)
    80002e8c:	00a7b423          	sd	a0,8(a5)
        vel++;
    80002e90:	00004717          	auipc	a4,0x4
    80002e94:	50070713          	addi	a4,a4,1280 # 80007390 <_ZN9Scheduler10readyQueueE>
    80002e98:	01072783          	lw	a5,16(a4)
    80002e9c:	0017879b          	addiw	a5,a5,1
    80002ea0:	00f72823          	sw	a5,16(a4)
    80002ea4:	01813083          	ld	ra,24(sp)
    80002ea8:	01013403          	ld	s0,16(sp)
    80002eac:	00813483          	ld	s1,8(sp)
    80002eb0:	02010113          	addi	sp,sp,32
    80002eb4:	00008067          	ret
           return MemoryAllocator::memAlloc(n);
    80002eb8:	01000513          	li	a0,16
    80002ebc:	00000097          	auipc	ra,0x0
    80002ec0:	12c080e7          	jalr	300(ra) # 80002fe8 <_ZN15MemoryAllocator8memAllocEm>
            this->tcb=tcb;
    80002ec4:	00953023          	sd	s1,0(a0)
            sled= nullptr;
    80002ec8:	00053423          	sd	zero,8(a0)
        if (prvi== nullptr) prvi= posl = new Elem(tcb);
    80002ecc:	00004797          	auipc	a5,0x4
    80002ed0:	4c478793          	addi	a5,a5,1220 # 80007390 <_ZN9Scheduler10readyQueueE>
    80002ed4:	00a7b423          	sd	a0,8(a5)
    80002ed8:	00a7b023          	sd	a0,0(a5)
    80002edc:	fb5ff06f          	j	80002e90 <_ZN9Scheduler3putEP3TCB+0x5c>

0000000080002ee0 <_GLOBAL__sub_I__ZN9Scheduler10readyQueueE>:
    80002ee0:	ff010113          	addi	sp,sp,-16
    80002ee4:	00113423          	sd	ra,8(sp)
    80002ee8:	00813023          	sd	s0,0(sp)
    80002eec:	01010413          	addi	s0,sp,16
    80002ef0:	000105b7          	lui	a1,0x10
    80002ef4:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002ef8:	00100513          	li	a0,1
    80002efc:	00000097          	auipc	ra,0x0
    80002f00:	e7c080e7          	jalr	-388(ra) # 80002d78 <_Z41__static_initialization_and_destruction_0ii>
    80002f04:	00813083          	ld	ra,8(sp)
    80002f08:	00013403          	ld	s0,0(sp)
    80002f0c:	01010113          	addi	sp,sp,16
    80002f10:	00008067          	ret

0000000080002f14 <_ZN15MemoryAllocator7memInitEv>:
#include "../h/MemoryAllocator.hpp"

MemoryAllocator::Mem* MemoryAllocator::fmem_head;


void MemoryAllocator::memInit() {
    80002f14:	ff010113          	addi	sp,sp,-16
    80002f18:	00813423          	sd	s0,8(sp)
    80002f1c:	01010413          	addi	s0,sp,16
    fmem_head=(MemoryAllocator::Mem*)HEAP_START_ADDR;
    80002f20:	00004717          	auipc	a4,0x4
    80002f24:	3c873703          	ld	a4,968(a4) # 800072e8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002f28:	00073683          	ld	a3,0(a4)
    80002f2c:	00004797          	auipc	a5,0x4
    80002f30:	47c78793          	addi	a5,a5,1148 # 800073a8 <_ZN15MemoryAllocator9fmem_headE>
    80002f34:	00d7b023          	sd	a3,0(a5)
    fmem_head->next=nullptr;
    80002f38:	0006b023          	sd	zero,0(a3) # 8000 <_entry-0x7fff8000>
    fmem_head->size=((size_t)HEAP_END_ADDR-((size_t)HEAP_START_ADDR));
    80002f3c:	00073683          	ld	a3,0(a4)
    80002f40:	0007b783          	ld	a5,0(a5)
    80002f44:	00004717          	auipc	a4,0x4
    80002f48:	3c473703          	ld	a4,964(a4) # 80007308 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002f4c:	00073703          	ld	a4,0(a4)
    80002f50:	40d70733          	sub	a4,a4,a3
    80002f54:	00e7b423          	sd	a4,8(a5)
    fmem_head->addr=(char*)HEAP_START_ADDR;
    80002f58:	00d7b823          	sd	a3,16(a5)
    fmem_head->free=1;
    80002f5c:	00100713          	li	a4,1
    80002f60:	00e7ac23          	sw	a4,24(a5)

}
    80002f64:	00813403          	ld	s0,8(sp)
    80002f68:	01010113          	addi	sp,sp,16
    80002f6c:	00008067          	ret

0000000080002f70 <_Z5getBFm>:

MemoryAllocator::Mem* getBF(size_t size) {
    80002f70:	ff010113          	addi	sp,sp,-16
    80002f74:	00813423          	sd	s0,8(sp)
    80002f78:	01010413          	addi	s0,sp,16
    80002f7c:	00050693          	mv	a3,a0

    uint64 min = 1000000000000000000;
   MemoryAllocator::Mem* tmp=MemoryAllocator::fmem_head;
    80002f80:	00004797          	auipc	a5,0x4
    80002f84:	4287b783          	ld	a5,1064(a5) # 800073a8 <_ZN15MemoryAllocator9fmem_headE>
   MemoryAllocator::Mem* bf= nullptr;
    80002f88:	00000513          	li	a0,0
    uint64 min = 1000000000000000000;
    80002f8c:	00003817          	auipc	a6,0x3
    80002f90:	14c83803          	ld	a6,332(a6) # 800060d8 <CONSOLE_STATUS+0xc8>
    80002f94:	0240006f          	j	80002fb8 <_Z5getBFm+0x48>
    while (tmp) {
        if (tmp->size == size && tmp->free==1) {
    80002f98:	0187a583          	lw	a1,24(a5)
    80002f9c:	00100613          	li	a2,1
    80002fa0:	02c59263          	bne	a1,a2,80002fc4 <_Z5getBFm+0x54>
            return tmp;
    80002fa4:	00078513          	mv	a0,a5
            }
        }
        tmp = tmp->next;
    }
    return bf;
}
    80002fa8:	00813403          	ld	s0,8(sp)
    80002fac:	01010113          	addi	sp,sp,16
    80002fb0:	00008067          	ret
        tmp = tmp->next;
    80002fb4:	0007b783          	ld	a5,0(a5)
    while (tmp) {
    80002fb8:	fe0788e3          	beqz	a5,80002fa8 <_Z5getBFm+0x38>
        if (tmp->size == size && tmp->free==1) {
    80002fbc:	0087b703          	ld	a4,8(a5)
    80002fc0:	fcd70ce3          	beq	a4,a3,80002f98 <_Z5getBFm+0x28>
        if (tmp->size > size && tmp->free==1) {
    80002fc4:	fee6f8e3          	bgeu	a3,a4,80002fb4 <_Z5getBFm+0x44>
    80002fc8:	0187a583          	lw	a1,24(a5)
    80002fcc:	00100613          	li	a2,1
    80002fd0:	fec592e3          	bne	a1,a2,80002fb4 <_Z5getBFm+0x44>
            if ((tmp->size - size )< min) {
    80002fd4:	40d70733          	sub	a4,a4,a3
    80002fd8:	fd077ee3          	bgeu	a4,a6,80002fb4 <_Z5getBFm+0x44>
                bf = tmp;
    80002fdc:	00078513          	mv	a0,a5
                min = tmp->size - size;
    80002fe0:	00070813          	mv	a6,a4
    80002fe4:	fd1ff06f          	j	80002fb4 <_Z5getBFm+0x44>

0000000080002fe8 <_ZN15MemoryAllocator8memAllocEm>:

void *MemoryAllocator::memAlloc(size_t size) {
    80002fe8:	ff010113          	addi	sp,sp,-16
    80002fec:	00813423          	sd	s0,8(sp)
    80002ff0:	01010413          	addi	s0,sp,16
    80002ff4:	00050793          	mv	a5,a0
    if(fmem_head== nullptr|| size==0)
    80002ff8:	00004517          	auipc	a0,0x4
    80002ffc:	3b053503          	ld	a0,944(a0) # 800073a8 <_ZN15MemoryAllocator9fmem_headE>
    80003000:	06050263          	beqz	a0,80003064 <_ZN15MemoryAllocator8memAllocEm+0x7c>
    80003004:	0a078063          	beqz	a5,800030a4 <_ZN15MemoryAllocator8memAllocEm+0xbc>
        return nullptr;
    void *res= nullptr;
    size_t size1=size+ sizeof(MemoryAllocator::Mem);
    MemoryAllocator::Mem* cur=fmem_head;

    if(size>MEM_BLOCK_SIZE)
    80003008:	04000713          	li	a4,64
    8000300c:	00f77c63          	bgeu	a4,a5,80003024 <_ZN15MemoryAllocator8memAllocEm+0x3c>
        size1= (((size / MEM_BLOCK_SIZE) + 1) * MEM_BLOCK_SIZE) + sizeof(MemoryAllocator::Mem);
    80003010:	0067d693          	srli	a3,a5,0x6
    80003014:	00168693          	addi	a3,a3,1
    80003018:	00669693          	slli	a3,a3,0x6
    8000301c:	02068693          	addi	a3,a3,32
    80003020:	0180006f          	j	80003038 <_ZN15MemoryAllocator8memAllocEm+0x50>
    else

        size1 = MEM_BLOCK_SIZE + sizeof(MemoryAllocator::Mem);
    80003024:	06000693          	li	a3,96
    80003028:	0100006f          	j	80003038 <_ZN15MemoryAllocator8memAllocEm+0x50>

   while(((cur->size<size1)||(cur->free==0))&& cur->next!= nullptr){
    8000302c:	00053783          	ld	a5,0(a0)
    80003030:	00078c63          	beqz	a5,80003048 <_ZN15MemoryAllocator8memAllocEm+0x60>
        cur=cur->next;
    80003034:	00078513          	mv	a0,a5
   while(((cur->size<size1)||(cur->free==0))&& cur->next!= nullptr){
    80003038:	00853703          	ld	a4,8(a0)
    8000303c:	fed768e3          	bltu	a4,a3,8000302c <_ZN15MemoryAllocator8memAllocEm+0x44>
    80003040:	01852783          	lw	a5,24(a0)
    80003044:	fe0784e3          	beqz	a5,8000302c <_ZN15MemoryAllocator8memAllocEm+0x44>
  }

    if(cur->size>=size1){
    80003048:	06d76263          	bltu	a4,a3,800030ac <_ZN15MemoryAllocator8memAllocEm+0xc4>
        if(cur->size-size1<=sizeof(MemoryAllocator::Mem)){ //ako smanjenjem ovog fragmenta, ostane manje ili jednako od velicine zaglavlja, onda cu da
    8000304c:	40d70733          	sub	a4,a4,a3
    80003050:	02000793          	li	a5,32
    80003054:	00e7ee63          	bltu	a5,a4,80003070 <_ZN15MemoryAllocator8memAllocEm+0x88>
            //alociram ceo taj fragment
            cur->free=0;
    80003058:	00052c23          	sw	zero,24(a0)
            res=(void*)(cur->addr+sizeof (MemoryAllocator::Mem));
    8000305c:	01053503          	ld	a0,16(a0)
    80003060:	02050513          	addi	a0,a0,32

   }

    return res;

}
    80003064:	00813403          	ld	s0,8(sp)
    80003068:	01010113          	addi	sp,sp,16
    8000306c:	00008067          	ret
            MemoryAllocator::Mem *newFrag= (MemoryAllocator::Mem *) (cur->addr+cur->size-size1);//postavim se nakon trenutnog koji sam nasla da je odgovarajuciS
    80003070:	01053783          	ld	a5,16(a0)
    80003074:	00e787b3          	add	a5,a5,a4
            cur->size -= size1;
    80003078:	00e53423          	sd	a4,8(a0)
            cur->next = newFrag;
    8000307c:	00f53023          	sd	a5,0(a0)
            newFrag->next = cur->next;
    80003080:	00f7b023          	sd	a5,0(a5)
            newFrag->size = size1;
    80003084:	00d7b423          	sd	a3,8(a5)
            newFrag->addr=(cur->addr+cur->size); //racuna i zaglavlje
    80003088:	01053703          	ld	a4,16(a0)
    8000308c:	00853503          	ld	a0,8(a0)
    80003090:	00a70533          	add	a0,a4,a0
    80003094:	00a7b823          	sd	a0,16(a5)
            newFrag->free = 0;
    80003098:	0007ac23          	sw	zero,24(a5)
            res = (void *) (newFrag->addr + sizeof(MemoryAllocator::Mem));
    8000309c:	02050513          	addi	a0,a0,32
    800030a0:	fc5ff06f          	j	80003064 <_ZN15MemoryAllocator8memAllocEm+0x7c>
        return nullptr;
    800030a4:	00000513          	li	a0,0
    800030a8:	fbdff06f          	j	80003064 <_ZN15MemoryAllocator8memAllocEm+0x7c>
    void *res= nullptr;
    800030ac:	00000513          	li	a0,0
    800030b0:	fb5ff06f          	j	80003064 <_ZN15MemoryAllocator8memAllocEm+0x7c>

00000000800030b4 <_Z5mergePN15MemoryAllocator3MemE>:
void merge(MemoryAllocator::Mem* temp){
    800030b4:	ff010113          	addi	sp,sp,-16
    800030b8:	00813423          	sd	s0,8(sp)
    800030bc:	01010413          	addi	s0,sp,16

    if(temp== nullptr) return;
    800030c0:	00050863          	beqz	a0,800030d0 <_Z5mergePN15MemoryAllocator3MemE+0x1c>
        if ((temp->free == 1) && (temp->next->free == 1) && temp->next && temp->addr + temp->size == temp->next->addr) {
    800030c4:	01852703          	lw	a4,24(a0)
    800030c8:	00100793          	li	a5,1
    800030cc:	00f70863          	beq	a4,a5,800030dc <_Z5mergePN15MemoryAllocator3MemE+0x28>
            temp->size += (temp->next->size) + sizeof(MemoryAllocator::Mem);
            temp->next = temp->next->next;

        }

}
    800030d0:	00813403          	ld	s0,8(sp)
    800030d4:	01010113          	addi	sp,sp,16
    800030d8:	00008067          	ret
        if ((temp->free == 1) && (temp->next->free == 1) && temp->next && temp->addr + temp->size == temp->next->addr) {
    800030dc:	00053783          	ld	a5,0(a0)
    800030e0:	0187a683          	lw	a3,24(a5)
    800030e4:	00100713          	li	a4,1
    800030e8:	fee694e3          	bne	a3,a4,800030d0 <_Z5mergePN15MemoryAllocator3MemE+0x1c>
    800030ec:	fe0782e3          	beqz	a5,800030d0 <_Z5mergePN15MemoryAllocator3MemE+0x1c>
    800030f0:	01053703          	ld	a4,16(a0)
    800030f4:	00853683          	ld	a3,8(a0)
    800030f8:	00d70733          	add	a4,a4,a3
    800030fc:	0107b603          	ld	a2,16(a5)
    80003100:	fcc718e3          	bne	a4,a2,800030d0 <_Z5mergePN15MemoryAllocator3MemE+0x1c>
            temp->size += (temp->next->size) + sizeof(MemoryAllocator::Mem);
    80003104:	0087b703          	ld	a4,8(a5)
    80003108:	00e686b3          	add	a3,a3,a4
    8000310c:	02068693          	addi	a3,a3,32
    80003110:	00d53423          	sd	a3,8(a0)
            temp->next = temp->next->next;
    80003114:	0007b783          	ld	a5,0(a5)
    80003118:	00f53023          	sd	a5,0(a0)
    8000311c:	fb5ff06f          	j	800030d0 <_Z5mergePN15MemoryAllocator3MemE+0x1c>

0000000080003120 <_ZN15MemoryAllocator7memFreeEPv>:

int MemoryAllocator::memFree(void *ptr)  {
    if(!ptr || !fmem_head || (char*)ptr<(char*)fmem_head)
    80003120:	04050a63          	beqz	a0,80003174 <_ZN15MemoryAllocator7memFreeEPv+0x54>
    80003124:	00050793          	mv	a5,a0
    80003128:	00004717          	auipc	a4,0x4
    8000312c:	28073703          	ld	a4,640(a4) # 800073a8 <_ZN15MemoryAllocator9fmem_headE>
    80003130:	04070663          	beqz	a4,8000317c <_ZN15MemoryAllocator7memFreeEPv+0x5c>
    80003134:	04e56863          	bltu	a0,a4,80003184 <_ZN15MemoryAllocator7memFreeEPv+0x64>
        return -1;
    MemoryAllocator::Mem* cur=(MemoryAllocator::Mem*)((char*)ptr-sizeof(MemoryAllocator::Mem));
    80003138:	fe050513          	addi	a0,a0,-32
    if(cur==nullptr)
    8000313c:	04050863          	beqz	a0,8000318c <_ZN15MemoryAllocator7memFreeEPv+0x6c>
int MemoryAllocator::memFree(void *ptr)  {
    80003140:	ff010113          	addi	sp,sp,-16
    80003144:	00113423          	sd	ra,8(sp)
    80003148:	00813023          	sd	s0,0(sp)
    8000314c:	01010413          	addi	s0,sp,16
        return -10;
    cur->free=1;
    80003150:	00100713          	li	a4,1
    80003154:	fee7ac23          	sw	a4,-8(a5)
    merge(cur);
    80003158:	00000097          	auipc	ra,0x0
    8000315c:	f5c080e7          	jalr	-164(ra) # 800030b4 <_Z5mergePN15MemoryAllocator3MemE>
    return 0;
    80003160:	00000513          	li	a0,0

}
    80003164:	00813083          	ld	ra,8(sp)
    80003168:	00013403          	ld	s0,0(sp)
    8000316c:	01010113          	addi	sp,sp,16
    80003170:	00008067          	ret
        return -1;
    80003174:	fff00513          	li	a0,-1
    80003178:	00008067          	ret
    8000317c:	fff00513          	li	a0,-1
    80003180:	00008067          	ret
    80003184:	fff00513          	li	a0,-1
    80003188:	00008067          	ret
        return -10;
    8000318c:	ff600513          	li	a0,-10
}
    80003190:	00008067          	ret

0000000080003194 <_ZN6BufferC1Ei>:
#include "../h/buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003194:	fe010113          	addi	sp,sp,-32
    80003198:	00113c23          	sd	ra,24(sp)
    8000319c:	00813823          	sd	s0,16(sp)
    800031a0:	00913423          	sd	s1,8(sp)
    800031a4:	01213023          	sd	s2,0(sp)
    800031a8:	02010413          	addi	s0,sp,32
    800031ac:	00050493          	mv	s1,a0
    800031b0:	00058913          	mv	s2,a1
    800031b4:	0015879b          	addiw	a5,a1,1
    800031b8:	0007851b          	sext.w	a0,a5
    800031bc:	00f4a023          	sw	a5,0(s1)
    800031c0:	0004a823          	sw	zero,16(s1)
    800031c4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800031c8:	00251513          	slli	a0,a0,0x2
    800031cc:	ffffe097          	auipc	ra,0xffffe
    800031d0:	f78080e7          	jalr	-136(ra) # 80001144 <_Z9mem_allocm>
    800031d4:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800031d8:	00000593          	li	a1,0
    800031dc:	02048513          	addi	a0,s1,32
    800031e0:	ffffe097          	auipc	ra,0xffffe
    800031e4:	170080e7          	jalr	368(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, _cap);
    800031e8:	00090593          	mv	a1,s2
    800031ec:	01848513          	addi	a0,s1,24
    800031f0:	ffffe097          	auipc	ra,0xffffe
    800031f4:	160080e7          	jalr	352(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    800031f8:	00100593          	li	a1,1
    800031fc:	02848513          	addi	a0,s1,40
    80003200:	ffffe097          	auipc	ra,0xffffe
    80003204:	150080e7          	jalr	336(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80003208:	00100593          	li	a1,1
    8000320c:	03048513          	addi	a0,s1,48
    80003210:	ffffe097          	auipc	ra,0xffffe
    80003214:	140080e7          	jalr	320(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80003218:	01813083          	ld	ra,24(sp)
    8000321c:	01013403          	ld	s0,16(sp)
    80003220:	00813483          	ld	s1,8(sp)
    80003224:	00013903          	ld	s2,0(sp)
    80003228:	02010113          	addi	sp,sp,32
    8000322c:	00008067          	ret

0000000080003230 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80003230:	fe010113          	addi	sp,sp,-32
    80003234:	00113c23          	sd	ra,24(sp)
    80003238:	00813823          	sd	s0,16(sp)
    8000323c:	00913423          	sd	s1,8(sp)
    80003240:	01213023          	sd	s2,0(sp)
    80003244:	02010413          	addi	s0,sp,32
    80003248:	00050493          	mv	s1,a0
    8000324c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80003250:	01853503          	ld	a0,24(a0)
    80003254:	ffffe097          	auipc	ra,0xffffe
    80003258:	160080e7          	jalr	352(ra) # 800013b4 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    8000325c:	0304b503          	ld	a0,48(s1)
    80003260:	ffffe097          	auipc	ra,0xffffe
    80003264:	154080e7          	jalr	340(ra) # 800013b4 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    80003268:	0084b783          	ld	a5,8(s1)
    8000326c:	0144a703          	lw	a4,20(s1)
    80003270:	00271713          	slli	a4,a4,0x2
    80003274:	00e787b3          	add	a5,a5,a4
    80003278:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000327c:	0144a783          	lw	a5,20(s1)
    80003280:	0017879b          	addiw	a5,a5,1
    80003284:	0004a703          	lw	a4,0(s1)
    80003288:	02e7e7bb          	remw	a5,a5,a4
    8000328c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80003290:	0304b503          	ld	a0,48(s1)
    80003294:	ffffe097          	auipc	ra,0xffffe
    80003298:	150080e7          	jalr	336(ra) # 800013e4 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    8000329c:	0204b503          	ld	a0,32(s1)
    800032a0:	ffffe097          	auipc	ra,0xffffe
    800032a4:	144080e7          	jalr	324(ra) # 800013e4 <_Z10sem_signalP3SCB>

}
    800032a8:	01813083          	ld	ra,24(sp)
    800032ac:	01013403          	ld	s0,16(sp)
    800032b0:	00813483          	ld	s1,8(sp)
    800032b4:	00013903          	ld	s2,0(sp)
    800032b8:	02010113          	addi	sp,sp,32
    800032bc:	00008067          	ret

00000000800032c0 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800032c0:	fe010113          	addi	sp,sp,-32
    800032c4:	00113c23          	sd	ra,24(sp)
    800032c8:	00813823          	sd	s0,16(sp)
    800032cc:	00913423          	sd	s1,8(sp)
    800032d0:	01213023          	sd	s2,0(sp)
    800032d4:	02010413          	addi	s0,sp,32
    800032d8:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800032dc:	02053503          	ld	a0,32(a0)
    800032e0:	ffffe097          	auipc	ra,0xffffe
    800032e4:	0d4080e7          	jalr	212(ra) # 800013b4 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    800032e8:	0284b503          	ld	a0,40(s1)
    800032ec:	ffffe097          	auipc	ra,0xffffe
    800032f0:	0c8080e7          	jalr	200(ra) # 800013b4 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    800032f4:	0084b703          	ld	a4,8(s1)
    800032f8:	0104a783          	lw	a5,16(s1)
    800032fc:	00279693          	slli	a3,a5,0x2
    80003300:	00d70733          	add	a4,a4,a3
    80003304:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003308:	0017879b          	addiw	a5,a5,1
    8000330c:	0004a703          	lw	a4,0(s1)
    80003310:	02e7e7bb          	remw	a5,a5,a4
    80003314:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003318:	0284b503          	ld	a0,40(s1)
    8000331c:	ffffe097          	auipc	ra,0xffffe
    80003320:	0c8080e7          	jalr	200(ra) # 800013e4 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80003324:	0184b503          	ld	a0,24(s1)
    80003328:	ffffe097          	auipc	ra,0xffffe
    8000332c:	0bc080e7          	jalr	188(ra) # 800013e4 <_Z10sem_signalP3SCB>

    return ret;
}
    80003330:	00090513          	mv	a0,s2
    80003334:	01813083          	ld	ra,24(sp)
    80003338:	01013403          	ld	s0,16(sp)
    8000333c:	00813483          	ld	s1,8(sp)
    80003340:	00013903          	ld	s2,0(sp)
    80003344:	02010113          	addi	sp,sp,32
    80003348:	00008067          	ret

000000008000334c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000334c:	fe010113          	addi	sp,sp,-32
    80003350:	00113c23          	sd	ra,24(sp)
    80003354:	00813823          	sd	s0,16(sp)
    80003358:	00913423          	sd	s1,8(sp)
    8000335c:	01213023          	sd	s2,0(sp)
    80003360:	02010413          	addi	s0,sp,32
    80003364:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80003368:	02853503          	ld	a0,40(a0)
    8000336c:	ffffe097          	auipc	ra,0xffffe
    80003370:	048080e7          	jalr	72(ra) # 800013b4 <_Z8sem_waitP3SCB>
    sem_wait(mutexTail);
    80003374:	0304b503          	ld	a0,48(s1)
    80003378:	ffffe097          	auipc	ra,0xffffe
    8000337c:	03c080e7          	jalr	60(ra) # 800013b4 <_Z8sem_waitP3SCB>

    if (tail >= head) {
    80003380:	0144a783          	lw	a5,20(s1)
    80003384:	0104a903          	lw	s2,16(s1)
    80003388:	0327ce63          	blt	a5,s2,800033c4 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000338c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80003390:	0304b503          	ld	a0,48(s1)
    80003394:	ffffe097          	auipc	ra,0xffffe
    80003398:	050080e7          	jalr	80(ra) # 800013e4 <_Z10sem_signalP3SCB>
    sem_signal(mutexHead);
    8000339c:	0284b503          	ld	a0,40(s1)
    800033a0:	ffffe097          	auipc	ra,0xffffe
    800033a4:	044080e7          	jalr	68(ra) # 800013e4 <_Z10sem_signalP3SCB>

    return ret;
}
    800033a8:	00090513          	mv	a0,s2
    800033ac:	01813083          	ld	ra,24(sp)
    800033b0:	01013403          	ld	s0,16(sp)
    800033b4:	00813483          	ld	s1,8(sp)
    800033b8:	00013903          	ld	s2,0(sp)
    800033bc:	02010113          	addi	sp,sp,32
    800033c0:	00008067          	ret
        ret = cap - head + tail;
    800033c4:	0004a703          	lw	a4,0(s1)
    800033c8:	4127093b          	subw	s2,a4,s2
    800033cc:	00f9093b          	addw	s2,s2,a5
    800033d0:	fc1ff06f          	j	80003390 <_ZN6Buffer6getCntEv+0x44>

00000000800033d4 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800033d4:	fe010113          	addi	sp,sp,-32
    800033d8:	00113c23          	sd	ra,24(sp)
    800033dc:	00813823          	sd	s0,16(sp)
    800033e0:	00913423          	sd	s1,8(sp)
    800033e4:	02010413          	addi	s0,sp,32
    800033e8:	00050493          	mv	s1,a0
    putc('\n');
    800033ec:	00a00513          	li	a0,10
    800033f0:	ffffe097          	auipc	ra,0xffffe
    800033f4:	f38080e7          	jalr	-200(ra) # 80001328 <_Z4putcc>
    printString("Buffer deleted!\n");
    800033f8:	00003517          	auipc	a0,0x3
    800033fc:	c2850513          	addi	a0,a0,-984 # 80006020 <CONSOLE_STATUS+0x10>
    80003400:	ffffe097          	auipc	ra,0xffffe
    80003404:	014080e7          	jalr	20(ra) # 80001414 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80003408:	00048513          	mv	a0,s1
    8000340c:	00000097          	auipc	ra,0x0
    80003410:	f40080e7          	jalr	-192(ra) # 8000334c <_ZN6Buffer6getCntEv>
    80003414:	02a05c63          	blez	a0,8000344c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80003418:	0084b783          	ld	a5,8(s1)
    8000341c:	0104a703          	lw	a4,16(s1)
    80003420:	00271713          	slli	a4,a4,0x2
    80003424:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80003428:	0007c503          	lbu	a0,0(a5)
    8000342c:	ffffe097          	auipc	ra,0xffffe
    80003430:	efc080e7          	jalr	-260(ra) # 80001328 <_Z4putcc>
        head = (head + 1) % cap;
    80003434:	0104a783          	lw	a5,16(s1)
    80003438:	0017879b          	addiw	a5,a5,1
    8000343c:	0004a703          	lw	a4,0(s1)
    80003440:	02e7e7bb          	remw	a5,a5,a4
    80003444:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80003448:	fc1ff06f          	j	80003408 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000344c:	02100513          	li	a0,33
    80003450:	ffffe097          	auipc	ra,0xffffe
    80003454:	ed8080e7          	jalr	-296(ra) # 80001328 <_Z4putcc>
    putc('\n');
    80003458:	00a00513          	li	a0,10
    8000345c:	ffffe097          	auipc	ra,0xffffe
    80003460:	ecc080e7          	jalr	-308(ra) # 80001328 <_Z4putcc>
    mem_free(buffer);
    80003464:	0084b503          	ld	a0,8(s1)
    80003468:	ffffe097          	auipc	ra,0xffffe
    8000346c:	d94080e7          	jalr	-620(ra) # 800011fc <_Z8mem_freePv>
    sem_close(itemAvailable);
    80003470:	0204b503          	ld	a0,32(s1)
    80003474:	ffffe097          	auipc	ra,0xffffe
    80003478:	f10080e7          	jalr	-240(ra) # 80001384 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    8000347c:	0184b503          	ld	a0,24(s1)
    80003480:	ffffe097          	auipc	ra,0xffffe
    80003484:	f04080e7          	jalr	-252(ra) # 80001384 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80003488:	0304b503          	ld	a0,48(s1)
    8000348c:	ffffe097          	auipc	ra,0xffffe
    80003490:	ef8080e7          	jalr	-264(ra) # 80001384 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    80003494:	0284b503          	ld	a0,40(s1)
    80003498:	ffffe097          	auipc	ra,0xffffe
    8000349c:	eec080e7          	jalr	-276(ra) # 80001384 <_Z9sem_closeP3SCB>
}
    800034a0:	01813083          	ld	ra,24(sp)
    800034a4:	01013403          	ld	s0,16(sp)
    800034a8:	00813483          	ld	s1,8(sp)
    800034ac:	02010113          	addi	sp,sp,32
    800034b0:	00008067          	ret

00000000800034b4 <start>:
    800034b4:	ff010113          	addi	sp,sp,-16
    800034b8:	00813423          	sd	s0,8(sp)
    800034bc:	01010413          	addi	s0,sp,16
    800034c0:	300027f3          	csrr	a5,mstatus
    800034c4:	ffffe737          	lui	a4,0xffffe
    800034c8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff61ef>
    800034cc:	00e7f7b3          	and	a5,a5,a4
    800034d0:	00001737          	lui	a4,0x1
    800034d4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800034d8:	00e7e7b3          	or	a5,a5,a4
    800034dc:	30079073          	csrw	mstatus,a5
    800034e0:	00000797          	auipc	a5,0x0
    800034e4:	16078793          	addi	a5,a5,352 # 80003640 <system_main>
    800034e8:	34179073          	csrw	mepc,a5
    800034ec:	00000793          	li	a5,0
    800034f0:	18079073          	csrw	satp,a5
    800034f4:	000107b7          	lui	a5,0x10
    800034f8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800034fc:	30279073          	csrw	medeleg,a5
    80003500:	30379073          	csrw	mideleg,a5
    80003504:	104027f3          	csrr	a5,sie
    80003508:	2227e793          	ori	a5,a5,546
    8000350c:	10479073          	csrw	sie,a5
    80003510:	fff00793          	li	a5,-1
    80003514:	00a7d793          	srli	a5,a5,0xa
    80003518:	3b079073          	csrw	pmpaddr0,a5
    8000351c:	00f00793          	li	a5,15
    80003520:	3a079073          	csrw	pmpcfg0,a5
    80003524:	f14027f3          	csrr	a5,mhartid
    80003528:	0200c737          	lui	a4,0x200c
    8000352c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003530:	0007869b          	sext.w	a3,a5
    80003534:	00269713          	slli	a4,a3,0x2
    80003538:	000f4637          	lui	a2,0xf4
    8000353c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003540:	00d70733          	add	a4,a4,a3
    80003544:	0037979b          	slliw	a5,a5,0x3
    80003548:	020046b7          	lui	a3,0x2004
    8000354c:	00d787b3          	add	a5,a5,a3
    80003550:	00c585b3          	add	a1,a1,a2
    80003554:	00371693          	slli	a3,a4,0x3
    80003558:	00004717          	auipc	a4,0x4
    8000355c:	e5870713          	addi	a4,a4,-424 # 800073b0 <timer_scratch>
    80003560:	00b7b023          	sd	a1,0(a5)
    80003564:	00d70733          	add	a4,a4,a3
    80003568:	00f73c23          	sd	a5,24(a4)
    8000356c:	02c73023          	sd	a2,32(a4)
    80003570:	34071073          	csrw	mscratch,a4
    80003574:	00000797          	auipc	a5,0x0
    80003578:	6ec78793          	addi	a5,a5,1772 # 80003c60 <timervec>
    8000357c:	30579073          	csrw	mtvec,a5
    80003580:	300027f3          	csrr	a5,mstatus
    80003584:	0087e793          	ori	a5,a5,8
    80003588:	30079073          	csrw	mstatus,a5
    8000358c:	304027f3          	csrr	a5,mie
    80003590:	0807e793          	ori	a5,a5,128
    80003594:	30479073          	csrw	mie,a5
    80003598:	f14027f3          	csrr	a5,mhartid
    8000359c:	0007879b          	sext.w	a5,a5
    800035a0:	00078213          	mv	tp,a5
    800035a4:	30200073          	mret
    800035a8:	00813403          	ld	s0,8(sp)
    800035ac:	01010113          	addi	sp,sp,16
    800035b0:	00008067          	ret

00000000800035b4 <timerinit>:
    800035b4:	ff010113          	addi	sp,sp,-16
    800035b8:	00813423          	sd	s0,8(sp)
    800035bc:	01010413          	addi	s0,sp,16
    800035c0:	f14027f3          	csrr	a5,mhartid
    800035c4:	0200c737          	lui	a4,0x200c
    800035c8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800035cc:	0007869b          	sext.w	a3,a5
    800035d0:	00269713          	slli	a4,a3,0x2
    800035d4:	000f4637          	lui	a2,0xf4
    800035d8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800035dc:	00d70733          	add	a4,a4,a3
    800035e0:	0037979b          	slliw	a5,a5,0x3
    800035e4:	020046b7          	lui	a3,0x2004
    800035e8:	00d787b3          	add	a5,a5,a3
    800035ec:	00c585b3          	add	a1,a1,a2
    800035f0:	00371693          	slli	a3,a4,0x3
    800035f4:	00004717          	auipc	a4,0x4
    800035f8:	dbc70713          	addi	a4,a4,-580 # 800073b0 <timer_scratch>
    800035fc:	00b7b023          	sd	a1,0(a5)
    80003600:	00d70733          	add	a4,a4,a3
    80003604:	00f73c23          	sd	a5,24(a4)
    80003608:	02c73023          	sd	a2,32(a4)
    8000360c:	34071073          	csrw	mscratch,a4
    80003610:	00000797          	auipc	a5,0x0
    80003614:	65078793          	addi	a5,a5,1616 # 80003c60 <timervec>
    80003618:	30579073          	csrw	mtvec,a5
    8000361c:	300027f3          	csrr	a5,mstatus
    80003620:	0087e793          	ori	a5,a5,8
    80003624:	30079073          	csrw	mstatus,a5
    80003628:	304027f3          	csrr	a5,mie
    8000362c:	0807e793          	ori	a5,a5,128
    80003630:	30479073          	csrw	mie,a5
    80003634:	00813403          	ld	s0,8(sp)
    80003638:	01010113          	addi	sp,sp,16
    8000363c:	00008067          	ret

0000000080003640 <system_main>:
    80003640:	fe010113          	addi	sp,sp,-32
    80003644:	00813823          	sd	s0,16(sp)
    80003648:	00913423          	sd	s1,8(sp)
    8000364c:	00113c23          	sd	ra,24(sp)
    80003650:	02010413          	addi	s0,sp,32
    80003654:	00000097          	auipc	ra,0x0
    80003658:	0c4080e7          	jalr	196(ra) # 80003718 <cpuid>
    8000365c:	00004497          	auipc	s1,0x4
    80003660:	cd448493          	addi	s1,s1,-812 # 80007330 <started>
    80003664:	02050263          	beqz	a0,80003688 <system_main+0x48>
    80003668:	0004a783          	lw	a5,0(s1)
    8000366c:	0007879b          	sext.w	a5,a5
    80003670:	fe078ce3          	beqz	a5,80003668 <system_main+0x28>
    80003674:	0ff0000f          	fence
    80003678:	00003517          	auipc	a0,0x3
    8000367c:	a9850513          	addi	a0,a0,-1384 # 80006110 <CONSOLE_STATUS+0x100>
    80003680:	00001097          	auipc	ra,0x1
    80003684:	a7c080e7          	jalr	-1412(ra) # 800040fc <panic>
    80003688:	00001097          	auipc	ra,0x1
    8000368c:	9d0080e7          	jalr	-1584(ra) # 80004058 <consoleinit>
    80003690:	00001097          	auipc	ra,0x1
    80003694:	15c080e7          	jalr	348(ra) # 800047ec <printfinit>
    80003698:	00003517          	auipc	a0,0x3
    8000369c:	a3850513          	addi	a0,a0,-1480 # 800060d0 <CONSOLE_STATUS+0xc0>
    800036a0:	00001097          	auipc	ra,0x1
    800036a4:	ab8080e7          	jalr	-1352(ra) # 80004158 <__printf>
    800036a8:	00003517          	auipc	a0,0x3
    800036ac:	a3850513          	addi	a0,a0,-1480 # 800060e0 <CONSOLE_STATUS+0xd0>
    800036b0:	00001097          	auipc	ra,0x1
    800036b4:	aa8080e7          	jalr	-1368(ra) # 80004158 <__printf>
    800036b8:	00003517          	auipc	a0,0x3
    800036bc:	a1850513          	addi	a0,a0,-1512 # 800060d0 <CONSOLE_STATUS+0xc0>
    800036c0:	00001097          	auipc	ra,0x1
    800036c4:	a98080e7          	jalr	-1384(ra) # 80004158 <__printf>
    800036c8:	00001097          	auipc	ra,0x1
    800036cc:	4b0080e7          	jalr	1200(ra) # 80004b78 <kinit>
    800036d0:	00000097          	auipc	ra,0x0
    800036d4:	148080e7          	jalr	328(ra) # 80003818 <trapinit>
    800036d8:	00000097          	auipc	ra,0x0
    800036dc:	16c080e7          	jalr	364(ra) # 80003844 <trapinithart>
    800036e0:	00000097          	auipc	ra,0x0
    800036e4:	5c0080e7          	jalr	1472(ra) # 80003ca0 <plicinit>
    800036e8:	00000097          	auipc	ra,0x0
    800036ec:	5e0080e7          	jalr	1504(ra) # 80003cc8 <plicinithart>
    800036f0:	00000097          	auipc	ra,0x0
    800036f4:	078080e7          	jalr	120(ra) # 80003768 <userinit>
    800036f8:	0ff0000f          	fence
    800036fc:	00100793          	li	a5,1
    80003700:	00003517          	auipc	a0,0x3
    80003704:	9f850513          	addi	a0,a0,-1544 # 800060f8 <CONSOLE_STATUS+0xe8>
    80003708:	00f4a023          	sw	a5,0(s1)
    8000370c:	00001097          	auipc	ra,0x1
    80003710:	a4c080e7          	jalr	-1460(ra) # 80004158 <__printf>
    80003714:	0000006f          	j	80003714 <system_main+0xd4>

0000000080003718 <cpuid>:
    80003718:	ff010113          	addi	sp,sp,-16
    8000371c:	00813423          	sd	s0,8(sp)
    80003720:	01010413          	addi	s0,sp,16
    80003724:	00020513          	mv	a0,tp
    80003728:	00813403          	ld	s0,8(sp)
    8000372c:	0005051b          	sext.w	a0,a0
    80003730:	01010113          	addi	sp,sp,16
    80003734:	00008067          	ret

0000000080003738 <mycpu>:
    80003738:	ff010113          	addi	sp,sp,-16
    8000373c:	00813423          	sd	s0,8(sp)
    80003740:	01010413          	addi	s0,sp,16
    80003744:	00020793          	mv	a5,tp
    80003748:	00813403          	ld	s0,8(sp)
    8000374c:	0007879b          	sext.w	a5,a5
    80003750:	00779793          	slli	a5,a5,0x7
    80003754:	00005517          	auipc	a0,0x5
    80003758:	c8c50513          	addi	a0,a0,-884 # 800083e0 <cpus>
    8000375c:	00f50533          	add	a0,a0,a5
    80003760:	01010113          	addi	sp,sp,16
    80003764:	00008067          	ret

0000000080003768 <userinit>:
    80003768:	ff010113          	addi	sp,sp,-16
    8000376c:	00813423          	sd	s0,8(sp)
    80003770:	01010413          	addi	s0,sp,16
    80003774:	00813403          	ld	s0,8(sp)
    80003778:	01010113          	addi	sp,sp,16
    8000377c:	ffffe317          	auipc	t1,0xffffe
    80003780:	6c830067          	jr	1736(t1) # 80001e44 <main>

0000000080003784 <either_copyout>:
    80003784:	ff010113          	addi	sp,sp,-16
    80003788:	00813023          	sd	s0,0(sp)
    8000378c:	00113423          	sd	ra,8(sp)
    80003790:	01010413          	addi	s0,sp,16
    80003794:	02051663          	bnez	a0,800037c0 <either_copyout+0x3c>
    80003798:	00058513          	mv	a0,a1
    8000379c:	00060593          	mv	a1,a2
    800037a0:	0006861b          	sext.w	a2,a3
    800037a4:	00002097          	auipc	ra,0x2
    800037a8:	c60080e7          	jalr	-928(ra) # 80005404 <__memmove>
    800037ac:	00813083          	ld	ra,8(sp)
    800037b0:	00013403          	ld	s0,0(sp)
    800037b4:	00000513          	li	a0,0
    800037b8:	01010113          	addi	sp,sp,16
    800037bc:	00008067          	ret
    800037c0:	00003517          	auipc	a0,0x3
    800037c4:	97850513          	addi	a0,a0,-1672 # 80006138 <CONSOLE_STATUS+0x128>
    800037c8:	00001097          	auipc	ra,0x1
    800037cc:	934080e7          	jalr	-1740(ra) # 800040fc <panic>

00000000800037d0 <either_copyin>:
    800037d0:	ff010113          	addi	sp,sp,-16
    800037d4:	00813023          	sd	s0,0(sp)
    800037d8:	00113423          	sd	ra,8(sp)
    800037dc:	01010413          	addi	s0,sp,16
    800037e0:	02059463          	bnez	a1,80003808 <either_copyin+0x38>
    800037e4:	00060593          	mv	a1,a2
    800037e8:	0006861b          	sext.w	a2,a3
    800037ec:	00002097          	auipc	ra,0x2
    800037f0:	c18080e7          	jalr	-1000(ra) # 80005404 <__memmove>
    800037f4:	00813083          	ld	ra,8(sp)
    800037f8:	00013403          	ld	s0,0(sp)
    800037fc:	00000513          	li	a0,0
    80003800:	01010113          	addi	sp,sp,16
    80003804:	00008067          	ret
    80003808:	00003517          	auipc	a0,0x3
    8000380c:	95850513          	addi	a0,a0,-1704 # 80006160 <CONSOLE_STATUS+0x150>
    80003810:	00001097          	auipc	ra,0x1
    80003814:	8ec080e7          	jalr	-1812(ra) # 800040fc <panic>

0000000080003818 <trapinit>:
    80003818:	ff010113          	addi	sp,sp,-16
    8000381c:	00813423          	sd	s0,8(sp)
    80003820:	01010413          	addi	s0,sp,16
    80003824:	00813403          	ld	s0,8(sp)
    80003828:	00003597          	auipc	a1,0x3
    8000382c:	96058593          	addi	a1,a1,-1696 # 80006188 <CONSOLE_STATUS+0x178>
    80003830:	00005517          	auipc	a0,0x5
    80003834:	c3050513          	addi	a0,a0,-976 # 80008460 <tickslock>
    80003838:	01010113          	addi	sp,sp,16
    8000383c:	00001317          	auipc	t1,0x1
    80003840:	5cc30067          	jr	1484(t1) # 80004e08 <initlock>

0000000080003844 <trapinithart>:
    80003844:	ff010113          	addi	sp,sp,-16
    80003848:	00813423          	sd	s0,8(sp)
    8000384c:	01010413          	addi	s0,sp,16
    80003850:	00000797          	auipc	a5,0x0
    80003854:	30078793          	addi	a5,a5,768 # 80003b50 <kernelvec>
    80003858:	10579073          	csrw	stvec,a5
    8000385c:	00813403          	ld	s0,8(sp)
    80003860:	01010113          	addi	sp,sp,16
    80003864:	00008067          	ret

0000000080003868 <usertrap>:
    80003868:	ff010113          	addi	sp,sp,-16
    8000386c:	00813423          	sd	s0,8(sp)
    80003870:	01010413          	addi	s0,sp,16
    80003874:	00813403          	ld	s0,8(sp)
    80003878:	01010113          	addi	sp,sp,16
    8000387c:	00008067          	ret

0000000080003880 <usertrapret>:
    80003880:	ff010113          	addi	sp,sp,-16
    80003884:	00813423          	sd	s0,8(sp)
    80003888:	01010413          	addi	s0,sp,16
    8000388c:	00813403          	ld	s0,8(sp)
    80003890:	01010113          	addi	sp,sp,16
    80003894:	00008067          	ret

0000000080003898 <kerneltrap>:
    80003898:	fe010113          	addi	sp,sp,-32
    8000389c:	00813823          	sd	s0,16(sp)
    800038a0:	00113c23          	sd	ra,24(sp)
    800038a4:	00913423          	sd	s1,8(sp)
    800038a8:	02010413          	addi	s0,sp,32
    800038ac:	142025f3          	csrr	a1,scause
    800038b0:	100027f3          	csrr	a5,sstatus
    800038b4:	0027f793          	andi	a5,a5,2
    800038b8:	10079c63          	bnez	a5,800039d0 <kerneltrap+0x138>
    800038bc:	142027f3          	csrr	a5,scause
    800038c0:	0207ce63          	bltz	a5,800038fc <kerneltrap+0x64>
    800038c4:	00003517          	auipc	a0,0x3
    800038c8:	90c50513          	addi	a0,a0,-1780 # 800061d0 <CONSOLE_STATUS+0x1c0>
    800038cc:	00001097          	auipc	ra,0x1
    800038d0:	88c080e7          	jalr	-1908(ra) # 80004158 <__printf>
    800038d4:	141025f3          	csrr	a1,sepc
    800038d8:	14302673          	csrr	a2,stval
    800038dc:	00003517          	auipc	a0,0x3
    800038e0:	90450513          	addi	a0,a0,-1788 # 800061e0 <CONSOLE_STATUS+0x1d0>
    800038e4:	00001097          	auipc	ra,0x1
    800038e8:	874080e7          	jalr	-1932(ra) # 80004158 <__printf>
    800038ec:	00003517          	auipc	a0,0x3
    800038f0:	90c50513          	addi	a0,a0,-1780 # 800061f8 <CONSOLE_STATUS+0x1e8>
    800038f4:	00001097          	auipc	ra,0x1
    800038f8:	808080e7          	jalr	-2040(ra) # 800040fc <panic>
    800038fc:	0ff7f713          	andi	a4,a5,255
    80003900:	00900693          	li	a3,9
    80003904:	04d70063          	beq	a4,a3,80003944 <kerneltrap+0xac>
    80003908:	fff00713          	li	a4,-1
    8000390c:	03f71713          	slli	a4,a4,0x3f
    80003910:	00170713          	addi	a4,a4,1
    80003914:	fae798e3          	bne	a5,a4,800038c4 <kerneltrap+0x2c>
    80003918:	00000097          	auipc	ra,0x0
    8000391c:	e00080e7          	jalr	-512(ra) # 80003718 <cpuid>
    80003920:	06050663          	beqz	a0,8000398c <kerneltrap+0xf4>
    80003924:	144027f3          	csrr	a5,sip
    80003928:	ffd7f793          	andi	a5,a5,-3
    8000392c:	14479073          	csrw	sip,a5
    80003930:	01813083          	ld	ra,24(sp)
    80003934:	01013403          	ld	s0,16(sp)
    80003938:	00813483          	ld	s1,8(sp)
    8000393c:	02010113          	addi	sp,sp,32
    80003940:	00008067          	ret
    80003944:	00000097          	auipc	ra,0x0
    80003948:	3d0080e7          	jalr	976(ra) # 80003d14 <plic_claim>
    8000394c:	00a00793          	li	a5,10
    80003950:	00050493          	mv	s1,a0
    80003954:	06f50863          	beq	a0,a5,800039c4 <kerneltrap+0x12c>
    80003958:	fc050ce3          	beqz	a0,80003930 <kerneltrap+0x98>
    8000395c:	00050593          	mv	a1,a0
    80003960:	00003517          	auipc	a0,0x3
    80003964:	85050513          	addi	a0,a0,-1968 # 800061b0 <CONSOLE_STATUS+0x1a0>
    80003968:	00000097          	auipc	ra,0x0
    8000396c:	7f0080e7          	jalr	2032(ra) # 80004158 <__printf>
    80003970:	01013403          	ld	s0,16(sp)
    80003974:	01813083          	ld	ra,24(sp)
    80003978:	00048513          	mv	a0,s1
    8000397c:	00813483          	ld	s1,8(sp)
    80003980:	02010113          	addi	sp,sp,32
    80003984:	00000317          	auipc	t1,0x0
    80003988:	3c830067          	jr	968(t1) # 80003d4c <plic_complete>
    8000398c:	00005517          	auipc	a0,0x5
    80003990:	ad450513          	addi	a0,a0,-1324 # 80008460 <tickslock>
    80003994:	00001097          	auipc	ra,0x1
    80003998:	498080e7          	jalr	1176(ra) # 80004e2c <acquire>
    8000399c:	00004717          	auipc	a4,0x4
    800039a0:	99870713          	addi	a4,a4,-1640 # 80007334 <ticks>
    800039a4:	00072783          	lw	a5,0(a4)
    800039a8:	00005517          	auipc	a0,0x5
    800039ac:	ab850513          	addi	a0,a0,-1352 # 80008460 <tickslock>
    800039b0:	0017879b          	addiw	a5,a5,1
    800039b4:	00f72023          	sw	a5,0(a4)
    800039b8:	00001097          	auipc	ra,0x1
    800039bc:	540080e7          	jalr	1344(ra) # 80004ef8 <release>
    800039c0:	f65ff06f          	j	80003924 <kerneltrap+0x8c>
    800039c4:	00001097          	auipc	ra,0x1
    800039c8:	09c080e7          	jalr	156(ra) # 80004a60 <uartintr>
    800039cc:	fa5ff06f          	j	80003970 <kerneltrap+0xd8>
    800039d0:	00002517          	auipc	a0,0x2
    800039d4:	7c050513          	addi	a0,a0,1984 # 80006190 <CONSOLE_STATUS+0x180>
    800039d8:	00000097          	auipc	ra,0x0
    800039dc:	724080e7          	jalr	1828(ra) # 800040fc <panic>

00000000800039e0 <clockintr>:
    800039e0:	fe010113          	addi	sp,sp,-32
    800039e4:	00813823          	sd	s0,16(sp)
    800039e8:	00913423          	sd	s1,8(sp)
    800039ec:	00113c23          	sd	ra,24(sp)
    800039f0:	02010413          	addi	s0,sp,32
    800039f4:	00005497          	auipc	s1,0x5
    800039f8:	a6c48493          	addi	s1,s1,-1428 # 80008460 <tickslock>
    800039fc:	00048513          	mv	a0,s1
    80003a00:	00001097          	auipc	ra,0x1
    80003a04:	42c080e7          	jalr	1068(ra) # 80004e2c <acquire>
    80003a08:	00004717          	auipc	a4,0x4
    80003a0c:	92c70713          	addi	a4,a4,-1748 # 80007334 <ticks>
    80003a10:	00072783          	lw	a5,0(a4)
    80003a14:	01013403          	ld	s0,16(sp)
    80003a18:	01813083          	ld	ra,24(sp)
    80003a1c:	00048513          	mv	a0,s1
    80003a20:	0017879b          	addiw	a5,a5,1
    80003a24:	00813483          	ld	s1,8(sp)
    80003a28:	00f72023          	sw	a5,0(a4)
    80003a2c:	02010113          	addi	sp,sp,32
    80003a30:	00001317          	auipc	t1,0x1
    80003a34:	4c830067          	jr	1224(t1) # 80004ef8 <release>

0000000080003a38 <devintr>:
    80003a38:	142027f3          	csrr	a5,scause
    80003a3c:	00000513          	li	a0,0
    80003a40:	0007c463          	bltz	a5,80003a48 <devintr+0x10>
    80003a44:	00008067          	ret
    80003a48:	fe010113          	addi	sp,sp,-32
    80003a4c:	00813823          	sd	s0,16(sp)
    80003a50:	00113c23          	sd	ra,24(sp)
    80003a54:	00913423          	sd	s1,8(sp)
    80003a58:	02010413          	addi	s0,sp,32
    80003a5c:	0ff7f713          	andi	a4,a5,255
    80003a60:	00900693          	li	a3,9
    80003a64:	04d70c63          	beq	a4,a3,80003abc <devintr+0x84>
    80003a68:	fff00713          	li	a4,-1
    80003a6c:	03f71713          	slli	a4,a4,0x3f
    80003a70:	00170713          	addi	a4,a4,1
    80003a74:	00e78c63          	beq	a5,a4,80003a8c <devintr+0x54>
    80003a78:	01813083          	ld	ra,24(sp)
    80003a7c:	01013403          	ld	s0,16(sp)
    80003a80:	00813483          	ld	s1,8(sp)
    80003a84:	02010113          	addi	sp,sp,32
    80003a88:	00008067          	ret
    80003a8c:	00000097          	auipc	ra,0x0
    80003a90:	c8c080e7          	jalr	-884(ra) # 80003718 <cpuid>
    80003a94:	06050663          	beqz	a0,80003b00 <devintr+0xc8>
    80003a98:	144027f3          	csrr	a5,sip
    80003a9c:	ffd7f793          	andi	a5,a5,-3
    80003aa0:	14479073          	csrw	sip,a5
    80003aa4:	01813083          	ld	ra,24(sp)
    80003aa8:	01013403          	ld	s0,16(sp)
    80003aac:	00813483          	ld	s1,8(sp)
    80003ab0:	00200513          	li	a0,2
    80003ab4:	02010113          	addi	sp,sp,32
    80003ab8:	00008067          	ret
    80003abc:	00000097          	auipc	ra,0x0
    80003ac0:	258080e7          	jalr	600(ra) # 80003d14 <plic_claim>
    80003ac4:	00a00793          	li	a5,10
    80003ac8:	00050493          	mv	s1,a0
    80003acc:	06f50663          	beq	a0,a5,80003b38 <devintr+0x100>
    80003ad0:	00100513          	li	a0,1
    80003ad4:	fa0482e3          	beqz	s1,80003a78 <devintr+0x40>
    80003ad8:	00048593          	mv	a1,s1
    80003adc:	00002517          	auipc	a0,0x2
    80003ae0:	6d450513          	addi	a0,a0,1748 # 800061b0 <CONSOLE_STATUS+0x1a0>
    80003ae4:	00000097          	auipc	ra,0x0
    80003ae8:	674080e7          	jalr	1652(ra) # 80004158 <__printf>
    80003aec:	00048513          	mv	a0,s1
    80003af0:	00000097          	auipc	ra,0x0
    80003af4:	25c080e7          	jalr	604(ra) # 80003d4c <plic_complete>
    80003af8:	00100513          	li	a0,1
    80003afc:	f7dff06f          	j	80003a78 <devintr+0x40>
    80003b00:	00005517          	auipc	a0,0x5
    80003b04:	96050513          	addi	a0,a0,-1696 # 80008460 <tickslock>
    80003b08:	00001097          	auipc	ra,0x1
    80003b0c:	324080e7          	jalr	804(ra) # 80004e2c <acquire>
    80003b10:	00004717          	auipc	a4,0x4
    80003b14:	82470713          	addi	a4,a4,-2012 # 80007334 <ticks>
    80003b18:	00072783          	lw	a5,0(a4)
    80003b1c:	00005517          	auipc	a0,0x5
    80003b20:	94450513          	addi	a0,a0,-1724 # 80008460 <tickslock>
    80003b24:	0017879b          	addiw	a5,a5,1
    80003b28:	00f72023          	sw	a5,0(a4)
    80003b2c:	00001097          	auipc	ra,0x1
    80003b30:	3cc080e7          	jalr	972(ra) # 80004ef8 <release>
    80003b34:	f65ff06f          	j	80003a98 <devintr+0x60>
    80003b38:	00001097          	auipc	ra,0x1
    80003b3c:	f28080e7          	jalr	-216(ra) # 80004a60 <uartintr>
    80003b40:	fadff06f          	j	80003aec <devintr+0xb4>
	...

0000000080003b50 <kernelvec>:
    80003b50:	f0010113          	addi	sp,sp,-256
    80003b54:	00113023          	sd	ra,0(sp)
    80003b58:	00213423          	sd	sp,8(sp)
    80003b5c:	00313823          	sd	gp,16(sp)
    80003b60:	00413c23          	sd	tp,24(sp)
    80003b64:	02513023          	sd	t0,32(sp)
    80003b68:	02613423          	sd	t1,40(sp)
    80003b6c:	02713823          	sd	t2,48(sp)
    80003b70:	02813c23          	sd	s0,56(sp)
    80003b74:	04913023          	sd	s1,64(sp)
    80003b78:	04a13423          	sd	a0,72(sp)
    80003b7c:	04b13823          	sd	a1,80(sp)
    80003b80:	04c13c23          	sd	a2,88(sp)
    80003b84:	06d13023          	sd	a3,96(sp)
    80003b88:	06e13423          	sd	a4,104(sp)
    80003b8c:	06f13823          	sd	a5,112(sp)
    80003b90:	07013c23          	sd	a6,120(sp)
    80003b94:	09113023          	sd	a7,128(sp)
    80003b98:	09213423          	sd	s2,136(sp)
    80003b9c:	09313823          	sd	s3,144(sp)
    80003ba0:	09413c23          	sd	s4,152(sp)
    80003ba4:	0b513023          	sd	s5,160(sp)
    80003ba8:	0b613423          	sd	s6,168(sp)
    80003bac:	0b713823          	sd	s7,176(sp)
    80003bb0:	0b813c23          	sd	s8,184(sp)
    80003bb4:	0d913023          	sd	s9,192(sp)
    80003bb8:	0da13423          	sd	s10,200(sp)
    80003bbc:	0db13823          	sd	s11,208(sp)
    80003bc0:	0dc13c23          	sd	t3,216(sp)
    80003bc4:	0fd13023          	sd	t4,224(sp)
    80003bc8:	0fe13423          	sd	t5,232(sp)
    80003bcc:	0ff13823          	sd	t6,240(sp)
    80003bd0:	cc9ff0ef          	jal	ra,80003898 <kerneltrap>
    80003bd4:	00013083          	ld	ra,0(sp)
    80003bd8:	00813103          	ld	sp,8(sp)
    80003bdc:	01013183          	ld	gp,16(sp)
    80003be0:	02013283          	ld	t0,32(sp)
    80003be4:	02813303          	ld	t1,40(sp)
    80003be8:	03013383          	ld	t2,48(sp)
    80003bec:	03813403          	ld	s0,56(sp)
    80003bf0:	04013483          	ld	s1,64(sp)
    80003bf4:	04813503          	ld	a0,72(sp)
    80003bf8:	05013583          	ld	a1,80(sp)
    80003bfc:	05813603          	ld	a2,88(sp)
    80003c00:	06013683          	ld	a3,96(sp)
    80003c04:	06813703          	ld	a4,104(sp)
    80003c08:	07013783          	ld	a5,112(sp)
    80003c0c:	07813803          	ld	a6,120(sp)
    80003c10:	08013883          	ld	a7,128(sp)
    80003c14:	08813903          	ld	s2,136(sp)
    80003c18:	09013983          	ld	s3,144(sp)
    80003c1c:	09813a03          	ld	s4,152(sp)
    80003c20:	0a013a83          	ld	s5,160(sp)
    80003c24:	0a813b03          	ld	s6,168(sp)
    80003c28:	0b013b83          	ld	s7,176(sp)
    80003c2c:	0b813c03          	ld	s8,184(sp)
    80003c30:	0c013c83          	ld	s9,192(sp)
    80003c34:	0c813d03          	ld	s10,200(sp)
    80003c38:	0d013d83          	ld	s11,208(sp)
    80003c3c:	0d813e03          	ld	t3,216(sp)
    80003c40:	0e013e83          	ld	t4,224(sp)
    80003c44:	0e813f03          	ld	t5,232(sp)
    80003c48:	0f013f83          	ld	t6,240(sp)
    80003c4c:	10010113          	addi	sp,sp,256
    80003c50:	10200073          	sret
    80003c54:	00000013          	nop
    80003c58:	00000013          	nop
    80003c5c:	00000013          	nop

0000000080003c60 <timervec>:
    80003c60:	34051573          	csrrw	a0,mscratch,a0
    80003c64:	00b53023          	sd	a1,0(a0)
    80003c68:	00c53423          	sd	a2,8(a0)
    80003c6c:	00d53823          	sd	a3,16(a0)
    80003c70:	01853583          	ld	a1,24(a0)
    80003c74:	02053603          	ld	a2,32(a0)
    80003c78:	0005b683          	ld	a3,0(a1)
    80003c7c:	00c686b3          	add	a3,a3,a2
    80003c80:	00d5b023          	sd	a3,0(a1)
    80003c84:	00200593          	li	a1,2
    80003c88:	14459073          	csrw	sip,a1
    80003c8c:	01053683          	ld	a3,16(a0)
    80003c90:	00853603          	ld	a2,8(a0)
    80003c94:	00053583          	ld	a1,0(a0)
    80003c98:	34051573          	csrrw	a0,mscratch,a0
    80003c9c:	30200073          	mret

0000000080003ca0 <plicinit>:
    80003ca0:	ff010113          	addi	sp,sp,-16
    80003ca4:	00813423          	sd	s0,8(sp)
    80003ca8:	01010413          	addi	s0,sp,16
    80003cac:	00813403          	ld	s0,8(sp)
    80003cb0:	0c0007b7          	lui	a5,0xc000
    80003cb4:	00100713          	li	a4,1
    80003cb8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80003cbc:	00e7a223          	sw	a4,4(a5)
    80003cc0:	01010113          	addi	sp,sp,16
    80003cc4:	00008067          	ret

0000000080003cc8 <plicinithart>:
    80003cc8:	ff010113          	addi	sp,sp,-16
    80003ccc:	00813023          	sd	s0,0(sp)
    80003cd0:	00113423          	sd	ra,8(sp)
    80003cd4:	01010413          	addi	s0,sp,16
    80003cd8:	00000097          	auipc	ra,0x0
    80003cdc:	a40080e7          	jalr	-1472(ra) # 80003718 <cpuid>
    80003ce0:	0085171b          	slliw	a4,a0,0x8
    80003ce4:	0c0027b7          	lui	a5,0xc002
    80003ce8:	00e787b3          	add	a5,a5,a4
    80003cec:	40200713          	li	a4,1026
    80003cf0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003cf4:	00813083          	ld	ra,8(sp)
    80003cf8:	00013403          	ld	s0,0(sp)
    80003cfc:	00d5151b          	slliw	a0,a0,0xd
    80003d00:	0c2017b7          	lui	a5,0xc201
    80003d04:	00a78533          	add	a0,a5,a0
    80003d08:	00052023          	sw	zero,0(a0)
    80003d0c:	01010113          	addi	sp,sp,16
    80003d10:	00008067          	ret

0000000080003d14 <plic_claim>:
    80003d14:	ff010113          	addi	sp,sp,-16
    80003d18:	00813023          	sd	s0,0(sp)
    80003d1c:	00113423          	sd	ra,8(sp)
    80003d20:	01010413          	addi	s0,sp,16
    80003d24:	00000097          	auipc	ra,0x0
    80003d28:	9f4080e7          	jalr	-1548(ra) # 80003718 <cpuid>
    80003d2c:	00813083          	ld	ra,8(sp)
    80003d30:	00013403          	ld	s0,0(sp)
    80003d34:	00d5151b          	slliw	a0,a0,0xd
    80003d38:	0c2017b7          	lui	a5,0xc201
    80003d3c:	00a78533          	add	a0,a5,a0
    80003d40:	00452503          	lw	a0,4(a0)
    80003d44:	01010113          	addi	sp,sp,16
    80003d48:	00008067          	ret

0000000080003d4c <plic_complete>:
    80003d4c:	fe010113          	addi	sp,sp,-32
    80003d50:	00813823          	sd	s0,16(sp)
    80003d54:	00913423          	sd	s1,8(sp)
    80003d58:	00113c23          	sd	ra,24(sp)
    80003d5c:	02010413          	addi	s0,sp,32
    80003d60:	00050493          	mv	s1,a0
    80003d64:	00000097          	auipc	ra,0x0
    80003d68:	9b4080e7          	jalr	-1612(ra) # 80003718 <cpuid>
    80003d6c:	01813083          	ld	ra,24(sp)
    80003d70:	01013403          	ld	s0,16(sp)
    80003d74:	00d5179b          	slliw	a5,a0,0xd
    80003d78:	0c201737          	lui	a4,0xc201
    80003d7c:	00f707b3          	add	a5,a4,a5
    80003d80:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003d84:	00813483          	ld	s1,8(sp)
    80003d88:	02010113          	addi	sp,sp,32
    80003d8c:	00008067          	ret

0000000080003d90 <consolewrite>:
    80003d90:	fb010113          	addi	sp,sp,-80
    80003d94:	04813023          	sd	s0,64(sp)
    80003d98:	04113423          	sd	ra,72(sp)
    80003d9c:	02913c23          	sd	s1,56(sp)
    80003da0:	03213823          	sd	s2,48(sp)
    80003da4:	03313423          	sd	s3,40(sp)
    80003da8:	03413023          	sd	s4,32(sp)
    80003dac:	01513c23          	sd	s5,24(sp)
    80003db0:	05010413          	addi	s0,sp,80
    80003db4:	06c05c63          	blez	a2,80003e2c <consolewrite+0x9c>
    80003db8:	00060993          	mv	s3,a2
    80003dbc:	00050a13          	mv	s4,a0
    80003dc0:	00058493          	mv	s1,a1
    80003dc4:	00000913          	li	s2,0
    80003dc8:	fff00a93          	li	s5,-1
    80003dcc:	01c0006f          	j	80003de8 <consolewrite+0x58>
    80003dd0:	fbf44503          	lbu	a0,-65(s0)
    80003dd4:	0019091b          	addiw	s2,s2,1
    80003dd8:	00148493          	addi	s1,s1,1
    80003ddc:	00001097          	auipc	ra,0x1
    80003de0:	a9c080e7          	jalr	-1380(ra) # 80004878 <uartputc>
    80003de4:	03298063          	beq	s3,s2,80003e04 <consolewrite+0x74>
    80003de8:	00048613          	mv	a2,s1
    80003dec:	00100693          	li	a3,1
    80003df0:	000a0593          	mv	a1,s4
    80003df4:	fbf40513          	addi	a0,s0,-65
    80003df8:	00000097          	auipc	ra,0x0
    80003dfc:	9d8080e7          	jalr	-1576(ra) # 800037d0 <either_copyin>
    80003e00:	fd5518e3          	bne	a0,s5,80003dd0 <consolewrite+0x40>
    80003e04:	04813083          	ld	ra,72(sp)
    80003e08:	04013403          	ld	s0,64(sp)
    80003e0c:	03813483          	ld	s1,56(sp)
    80003e10:	02813983          	ld	s3,40(sp)
    80003e14:	02013a03          	ld	s4,32(sp)
    80003e18:	01813a83          	ld	s5,24(sp)
    80003e1c:	00090513          	mv	a0,s2
    80003e20:	03013903          	ld	s2,48(sp)
    80003e24:	05010113          	addi	sp,sp,80
    80003e28:	00008067          	ret
    80003e2c:	00000913          	li	s2,0
    80003e30:	fd5ff06f          	j	80003e04 <consolewrite+0x74>

0000000080003e34 <consoleread>:
    80003e34:	f9010113          	addi	sp,sp,-112
    80003e38:	06813023          	sd	s0,96(sp)
    80003e3c:	04913c23          	sd	s1,88(sp)
    80003e40:	05213823          	sd	s2,80(sp)
    80003e44:	05313423          	sd	s3,72(sp)
    80003e48:	05413023          	sd	s4,64(sp)
    80003e4c:	03513c23          	sd	s5,56(sp)
    80003e50:	03613823          	sd	s6,48(sp)
    80003e54:	03713423          	sd	s7,40(sp)
    80003e58:	03813023          	sd	s8,32(sp)
    80003e5c:	06113423          	sd	ra,104(sp)
    80003e60:	01913c23          	sd	s9,24(sp)
    80003e64:	07010413          	addi	s0,sp,112
    80003e68:	00060b93          	mv	s7,a2
    80003e6c:	00050913          	mv	s2,a0
    80003e70:	00058c13          	mv	s8,a1
    80003e74:	00060b1b          	sext.w	s6,a2
    80003e78:	00004497          	auipc	s1,0x4
    80003e7c:	61048493          	addi	s1,s1,1552 # 80008488 <cons>
    80003e80:	00400993          	li	s3,4
    80003e84:	fff00a13          	li	s4,-1
    80003e88:	00a00a93          	li	s5,10
    80003e8c:	05705e63          	blez	s7,80003ee8 <consoleread+0xb4>
    80003e90:	09c4a703          	lw	a4,156(s1)
    80003e94:	0984a783          	lw	a5,152(s1)
    80003e98:	0007071b          	sext.w	a4,a4
    80003e9c:	08e78463          	beq	a5,a4,80003f24 <consoleread+0xf0>
    80003ea0:	07f7f713          	andi	a4,a5,127
    80003ea4:	00e48733          	add	a4,s1,a4
    80003ea8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80003eac:	0017869b          	addiw	a3,a5,1
    80003eb0:	08d4ac23          	sw	a3,152(s1)
    80003eb4:	00070c9b          	sext.w	s9,a4
    80003eb8:	0b370663          	beq	a4,s3,80003f64 <consoleread+0x130>
    80003ebc:	00100693          	li	a3,1
    80003ec0:	f9f40613          	addi	a2,s0,-97
    80003ec4:	000c0593          	mv	a1,s8
    80003ec8:	00090513          	mv	a0,s2
    80003ecc:	f8e40fa3          	sb	a4,-97(s0)
    80003ed0:	00000097          	auipc	ra,0x0
    80003ed4:	8b4080e7          	jalr	-1868(ra) # 80003784 <either_copyout>
    80003ed8:	01450863          	beq	a0,s4,80003ee8 <consoleread+0xb4>
    80003edc:	001c0c13          	addi	s8,s8,1
    80003ee0:	fffb8b9b          	addiw	s7,s7,-1
    80003ee4:	fb5c94e3          	bne	s9,s5,80003e8c <consoleread+0x58>
    80003ee8:	000b851b          	sext.w	a0,s7
    80003eec:	06813083          	ld	ra,104(sp)
    80003ef0:	06013403          	ld	s0,96(sp)
    80003ef4:	05813483          	ld	s1,88(sp)
    80003ef8:	05013903          	ld	s2,80(sp)
    80003efc:	04813983          	ld	s3,72(sp)
    80003f00:	04013a03          	ld	s4,64(sp)
    80003f04:	03813a83          	ld	s5,56(sp)
    80003f08:	02813b83          	ld	s7,40(sp)
    80003f0c:	02013c03          	ld	s8,32(sp)
    80003f10:	01813c83          	ld	s9,24(sp)
    80003f14:	40ab053b          	subw	a0,s6,a0
    80003f18:	03013b03          	ld	s6,48(sp)
    80003f1c:	07010113          	addi	sp,sp,112
    80003f20:	00008067          	ret
    80003f24:	00001097          	auipc	ra,0x1
    80003f28:	1d8080e7          	jalr	472(ra) # 800050fc <push_on>
    80003f2c:	0984a703          	lw	a4,152(s1)
    80003f30:	09c4a783          	lw	a5,156(s1)
    80003f34:	0007879b          	sext.w	a5,a5
    80003f38:	fef70ce3          	beq	a4,a5,80003f30 <consoleread+0xfc>
    80003f3c:	00001097          	auipc	ra,0x1
    80003f40:	234080e7          	jalr	564(ra) # 80005170 <pop_on>
    80003f44:	0984a783          	lw	a5,152(s1)
    80003f48:	07f7f713          	andi	a4,a5,127
    80003f4c:	00e48733          	add	a4,s1,a4
    80003f50:	01874703          	lbu	a4,24(a4)
    80003f54:	0017869b          	addiw	a3,a5,1
    80003f58:	08d4ac23          	sw	a3,152(s1)
    80003f5c:	00070c9b          	sext.w	s9,a4
    80003f60:	f5371ee3          	bne	a4,s3,80003ebc <consoleread+0x88>
    80003f64:	000b851b          	sext.w	a0,s7
    80003f68:	f96bf2e3          	bgeu	s7,s6,80003eec <consoleread+0xb8>
    80003f6c:	08f4ac23          	sw	a5,152(s1)
    80003f70:	f7dff06f          	j	80003eec <consoleread+0xb8>

0000000080003f74 <consputc>:
    80003f74:	10000793          	li	a5,256
    80003f78:	00f50663          	beq	a0,a5,80003f84 <consputc+0x10>
    80003f7c:	00001317          	auipc	t1,0x1
    80003f80:	9f430067          	jr	-1548(t1) # 80004970 <uartputc_sync>
    80003f84:	ff010113          	addi	sp,sp,-16
    80003f88:	00113423          	sd	ra,8(sp)
    80003f8c:	00813023          	sd	s0,0(sp)
    80003f90:	01010413          	addi	s0,sp,16
    80003f94:	00800513          	li	a0,8
    80003f98:	00001097          	auipc	ra,0x1
    80003f9c:	9d8080e7          	jalr	-1576(ra) # 80004970 <uartputc_sync>
    80003fa0:	02000513          	li	a0,32
    80003fa4:	00001097          	auipc	ra,0x1
    80003fa8:	9cc080e7          	jalr	-1588(ra) # 80004970 <uartputc_sync>
    80003fac:	00013403          	ld	s0,0(sp)
    80003fb0:	00813083          	ld	ra,8(sp)
    80003fb4:	00800513          	li	a0,8
    80003fb8:	01010113          	addi	sp,sp,16
    80003fbc:	00001317          	auipc	t1,0x1
    80003fc0:	9b430067          	jr	-1612(t1) # 80004970 <uartputc_sync>

0000000080003fc4 <consoleintr>:
    80003fc4:	fe010113          	addi	sp,sp,-32
    80003fc8:	00813823          	sd	s0,16(sp)
    80003fcc:	00913423          	sd	s1,8(sp)
    80003fd0:	01213023          	sd	s2,0(sp)
    80003fd4:	00113c23          	sd	ra,24(sp)
    80003fd8:	02010413          	addi	s0,sp,32
    80003fdc:	00004917          	auipc	s2,0x4
    80003fe0:	4ac90913          	addi	s2,s2,1196 # 80008488 <cons>
    80003fe4:	00050493          	mv	s1,a0
    80003fe8:	00090513          	mv	a0,s2
    80003fec:	00001097          	auipc	ra,0x1
    80003ff0:	e40080e7          	jalr	-448(ra) # 80004e2c <acquire>
    80003ff4:	02048c63          	beqz	s1,8000402c <consoleintr+0x68>
    80003ff8:	0a092783          	lw	a5,160(s2)
    80003ffc:	09892703          	lw	a4,152(s2)
    80004000:	07f00693          	li	a3,127
    80004004:	40e7873b          	subw	a4,a5,a4
    80004008:	02e6e263          	bltu	a3,a4,8000402c <consoleintr+0x68>
    8000400c:	00d00713          	li	a4,13
    80004010:	04e48063          	beq	s1,a4,80004050 <consoleintr+0x8c>
    80004014:	07f7f713          	andi	a4,a5,127
    80004018:	00e90733          	add	a4,s2,a4
    8000401c:	0017879b          	addiw	a5,a5,1
    80004020:	0af92023          	sw	a5,160(s2)
    80004024:	00970c23          	sb	s1,24(a4)
    80004028:	08f92e23          	sw	a5,156(s2)
    8000402c:	01013403          	ld	s0,16(sp)
    80004030:	01813083          	ld	ra,24(sp)
    80004034:	00813483          	ld	s1,8(sp)
    80004038:	00013903          	ld	s2,0(sp)
    8000403c:	00004517          	auipc	a0,0x4
    80004040:	44c50513          	addi	a0,a0,1100 # 80008488 <cons>
    80004044:	02010113          	addi	sp,sp,32
    80004048:	00001317          	auipc	t1,0x1
    8000404c:	eb030067          	jr	-336(t1) # 80004ef8 <release>
    80004050:	00a00493          	li	s1,10
    80004054:	fc1ff06f          	j	80004014 <consoleintr+0x50>

0000000080004058 <consoleinit>:
    80004058:	fe010113          	addi	sp,sp,-32
    8000405c:	00113c23          	sd	ra,24(sp)
    80004060:	00813823          	sd	s0,16(sp)
    80004064:	00913423          	sd	s1,8(sp)
    80004068:	02010413          	addi	s0,sp,32
    8000406c:	00004497          	auipc	s1,0x4
    80004070:	41c48493          	addi	s1,s1,1052 # 80008488 <cons>
    80004074:	00048513          	mv	a0,s1
    80004078:	00002597          	auipc	a1,0x2
    8000407c:	19058593          	addi	a1,a1,400 # 80006208 <CONSOLE_STATUS+0x1f8>
    80004080:	00001097          	auipc	ra,0x1
    80004084:	d88080e7          	jalr	-632(ra) # 80004e08 <initlock>
    80004088:	00000097          	auipc	ra,0x0
    8000408c:	7ac080e7          	jalr	1964(ra) # 80004834 <uartinit>
    80004090:	01813083          	ld	ra,24(sp)
    80004094:	01013403          	ld	s0,16(sp)
    80004098:	00000797          	auipc	a5,0x0
    8000409c:	d9c78793          	addi	a5,a5,-612 # 80003e34 <consoleread>
    800040a0:	0af4bc23          	sd	a5,184(s1)
    800040a4:	00000797          	auipc	a5,0x0
    800040a8:	cec78793          	addi	a5,a5,-788 # 80003d90 <consolewrite>
    800040ac:	0cf4b023          	sd	a5,192(s1)
    800040b0:	00813483          	ld	s1,8(sp)
    800040b4:	02010113          	addi	sp,sp,32
    800040b8:	00008067          	ret

00000000800040bc <console_read>:
    800040bc:	ff010113          	addi	sp,sp,-16
    800040c0:	00813423          	sd	s0,8(sp)
    800040c4:	01010413          	addi	s0,sp,16
    800040c8:	00813403          	ld	s0,8(sp)
    800040cc:	00004317          	auipc	t1,0x4
    800040d0:	47433303          	ld	t1,1140(t1) # 80008540 <devsw+0x10>
    800040d4:	01010113          	addi	sp,sp,16
    800040d8:	00030067          	jr	t1

00000000800040dc <console_write>:
    800040dc:	ff010113          	addi	sp,sp,-16
    800040e0:	00813423          	sd	s0,8(sp)
    800040e4:	01010413          	addi	s0,sp,16
    800040e8:	00813403          	ld	s0,8(sp)
    800040ec:	00004317          	auipc	t1,0x4
    800040f0:	45c33303          	ld	t1,1116(t1) # 80008548 <devsw+0x18>
    800040f4:	01010113          	addi	sp,sp,16
    800040f8:	00030067          	jr	t1

00000000800040fc <panic>:
    800040fc:	fe010113          	addi	sp,sp,-32
    80004100:	00113c23          	sd	ra,24(sp)
    80004104:	00813823          	sd	s0,16(sp)
    80004108:	00913423          	sd	s1,8(sp)
    8000410c:	02010413          	addi	s0,sp,32
    80004110:	00050493          	mv	s1,a0
    80004114:	00002517          	auipc	a0,0x2
    80004118:	0fc50513          	addi	a0,a0,252 # 80006210 <CONSOLE_STATUS+0x200>
    8000411c:	00004797          	auipc	a5,0x4
    80004120:	4c07a623          	sw	zero,1228(a5) # 800085e8 <pr+0x18>
    80004124:	00000097          	auipc	ra,0x0
    80004128:	034080e7          	jalr	52(ra) # 80004158 <__printf>
    8000412c:	00048513          	mv	a0,s1
    80004130:	00000097          	auipc	ra,0x0
    80004134:	028080e7          	jalr	40(ra) # 80004158 <__printf>
    80004138:	00002517          	auipc	a0,0x2
    8000413c:	f9850513          	addi	a0,a0,-104 # 800060d0 <CONSOLE_STATUS+0xc0>
    80004140:	00000097          	auipc	ra,0x0
    80004144:	018080e7          	jalr	24(ra) # 80004158 <__printf>
    80004148:	00100793          	li	a5,1
    8000414c:	00003717          	auipc	a4,0x3
    80004150:	1ef72623          	sw	a5,492(a4) # 80007338 <panicked>
    80004154:	0000006f          	j	80004154 <panic+0x58>

0000000080004158 <__printf>:
    80004158:	f3010113          	addi	sp,sp,-208
    8000415c:	08813023          	sd	s0,128(sp)
    80004160:	07313423          	sd	s3,104(sp)
    80004164:	09010413          	addi	s0,sp,144
    80004168:	05813023          	sd	s8,64(sp)
    8000416c:	08113423          	sd	ra,136(sp)
    80004170:	06913c23          	sd	s1,120(sp)
    80004174:	07213823          	sd	s2,112(sp)
    80004178:	07413023          	sd	s4,96(sp)
    8000417c:	05513c23          	sd	s5,88(sp)
    80004180:	05613823          	sd	s6,80(sp)
    80004184:	05713423          	sd	s7,72(sp)
    80004188:	03913c23          	sd	s9,56(sp)
    8000418c:	03a13823          	sd	s10,48(sp)
    80004190:	03b13423          	sd	s11,40(sp)
    80004194:	00004317          	auipc	t1,0x4
    80004198:	43c30313          	addi	t1,t1,1084 # 800085d0 <pr>
    8000419c:	01832c03          	lw	s8,24(t1)
    800041a0:	00b43423          	sd	a1,8(s0)
    800041a4:	00c43823          	sd	a2,16(s0)
    800041a8:	00d43c23          	sd	a3,24(s0)
    800041ac:	02e43023          	sd	a4,32(s0)
    800041b0:	02f43423          	sd	a5,40(s0)
    800041b4:	03043823          	sd	a6,48(s0)
    800041b8:	03143c23          	sd	a7,56(s0)
    800041bc:	00050993          	mv	s3,a0
    800041c0:	4a0c1663          	bnez	s8,8000466c <__printf+0x514>
    800041c4:	60098c63          	beqz	s3,800047dc <__printf+0x684>
    800041c8:	0009c503          	lbu	a0,0(s3)
    800041cc:	00840793          	addi	a5,s0,8
    800041d0:	f6f43c23          	sd	a5,-136(s0)
    800041d4:	00000493          	li	s1,0
    800041d8:	22050063          	beqz	a0,800043f8 <__printf+0x2a0>
    800041dc:	00002a37          	lui	s4,0x2
    800041e0:	00018ab7          	lui	s5,0x18
    800041e4:	000f4b37          	lui	s6,0xf4
    800041e8:	00989bb7          	lui	s7,0x989
    800041ec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800041f0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800041f4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800041f8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800041fc:	00148c9b          	addiw	s9,s1,1
    80004200:	02500793          	li	a5,37
    80004204:	01998933          	add	s2,s3,s9
    80004208:	38f51263          	bne	a0,a5,8000458c <__printf+0x434>
    8000420c:	00094783          	lbu	a5,0(s2)
    80004210:	00078c9b          	sext.w	s9,a5
    80004214:	1e078263          	beqz	a5,800043f8 <__printf+0x2a0>
    80004218:	0024849b          	addiw	s1,s1,2
    8000421c:	07000713          	li	a4,112
    80004220:	00998933          	add	s2,s3,s1
    80004224:	38e78a63          	beq	a5,a4,800045b8 <__printf+0x460>
    80004228:	20f76863          	bltu	a4,a5,80004438 <__printf+0x2e0>
    8000422c:	42a78863          	beq	a5,a0,8000465c <__printf+0x504>
    80004230:	06400713          	li	a4,100
    80004234:	40e79663          	bne	a5,a4,80004640 <__printf+0x4e8>
    80004238:	f7843783          	ld	a5,-136(s0)
    8000423c:	0007a603          	lw	a2,0(a5)
    80004240:	00878793          	addi	a5,a5,8
    80004244:	f6f43c23          	sd	a5,-136(s0)
    80004248:	42064a63          	bltz	a2,8000467c <__printf+0x524>
    8000424c:	00a00713          	li	a4,10
    80004250:	02e677bb          	remuw	a5,a2,a4
    80004254:	00002d97          	auipc	s11,0x2
    80004258:	fe4d8d93          	addi	s11,s11,-28 # 80006238 <digits>
    8000425c:	00900593          	li	a1,9
    80004260:	0006051b          	sext.w	a0,a2
    80004264:	00000c93          	li	s9,0
    80004268:	02079793          	slli	a5,a5,0x20
    8000426c:	0207d793          	srli	a5,a5,0x20
    80004270:	00fd87b3          	add	a5,s11,a5
    80004274:	0007c783          	lbu	a5,0(a5)
    80004278:	02e656bb          	divuw	a3,a2,a4
    8000427c:	f8f40023          	sb	a5,-128(s0)
    80004280:	14c5d863          	bge	a1,a2,800043d0 <__printf+0x278>
    80004284:	06300593          	li	a1,99
    80004288:	00100c93          	li	s9,1
    8000428c:	02e6f7bb          	remuw	a5,a3,a4
    80004290:	02079793          	slli	a5,a5,0x20
    80004294:	0207d793          	srli	a5,a5,0x20
    80004298:	00fd87b3          	add	a5,s11,a5
    8000429c:	0007c783          	lbu	a5,0(a5)
    800042a0:	02e6d73b          	divuw	a4,a3,a4
    800042a4:	f8f400a3          	sb	a5,-127(s0)
    800042a8:	12a5f463          	bgeu	a1,a0,800043d0 <__printf+0x278>
    800042ac:	00a00693          	li	a3,10
    800042b0:	00900593          	li	a1,9
    800042b4:	02d777bb          	remuw	a5,a4,a3
    800042b8:	02079793          	slli	a5,a5,0x20
    800042bc:	0207d793          	srli	a5,a5,0x20
    800042c0:	00fd87b3          	add	a5,s11,a5
    800042c4:	0007c503          	lbu	a0,0(a5)
    800042c8:	02d757bb          	divuw	a5,a4,a3
    800042cc:	f8a40123          	sb	a0,-126(s0)
    800042d0:	48e5f263          	bgeu	a1,a4,80004754 <__printf+0x5fc>
    800042d4:	06300513          	li	a0,99
    800042d8:	02d7f5bb          	remuw	a1,a5,a3
    800042dc:	02059593          	slli	a1,a1,0x20
    800042e0:	0205d593          	srli	a1,a1,0x20
    800042e4:	00bd85b3          	add	a1,s11,a1
    800042e8:	0005c583          	lbu	a1,0(a1)
    800042ec:	02d7d7bb          	divuw	a5,a5,a3
    800042f0:	f8b401a3          	sb	a1,-125(s0)
    800042f4:	48e57263          	bgeu	a0,a4,80004778 <__printf+0x620>
    800042f8:	3e700513          	li	a0,999
    800042fc:	02d7f5bb          	remuw	a1,a5,a3
    80004300:	02059593          	slli	a1,a1,0x20
    80004304:	0205d593          	srli	a1,a1,0x20
    80004308:	00bd85b3          	add	a1,s11,a1
    8000430c:	0005c583          	lbu	a1,0(a1)
    80004310:	02d7d7bb          	divuw	a5,a5,a3
    80004314:	f8b40223          	sb	a1,-124(s0)
    80004318:	46e57663          	bgeu	a0,a4,80004784 <__printf+0x62c>
    8000431c:	02d7f5bb          	remuw	a1,a5,a3
    80004320:	02059593          	slli	a1,a1,0x20
    80004324:	0205d593          	srli	a1,a1,0x20
    80004328:	00bd85b3          	add	a1,s11,a1
    8000432c:	0005c583          	lbu	a1,0(a1)
    80004330:	02d7d7bb          	divuw	a5,a5,a3
    80004334:	f8b402a3          	sb	a1,-123(s0)
    80004338:	46ea7863          	bgeu	s4,a4,800047a8 <__printf+0x650>
    8000433c:	02d7f5bb          	remuw	a1,a5,a3
    80004340:	02059593          	slli	a1,a1,0x20
    80004344:	0205d593          	srli	a1,a1,0x20
    80004348:	00bd85b3          	add	a1,s11,a1
    8000434c:	0005c583          	lbu	a1,0(a1)
    80004350:	02d7d7bb          	divuw	a5,a5,a3
    80004354:	f8b40323          	sb	a1,-122(s0)
    80004358:	3eeaf863          	bgeu	s5,a4,80004748 <__printf+0x5f0>
    8000435c:	02d7f5bb          	remuw	a1,a5,a3
    80004360:	02059593          	slli	a1,a1,0x20
    80004364:	0205d593          	srli	a1,a1,0x20
    80004368:	00bd85b3          	add	a1,s11,a1
    8000436c:	0005c583          	lbu	a1,0(a1)
    80004370:	02d7d7bb          	divuw	a5,a5,a3
    80004374:	f8b403a3          	sb	a1,-121(s0)
    80004378:	42eb7e63          	bgeu	s6,a4,800047b4 <__printf+0x65c>
    8000437c:	02d7f5bb          	remuw	a1,a5,a3
    80004380:	02059593          	slli	a1,a1,0x20
    80004384:	0205d593          	srli	a1,a1,0x20
    80004388:	00bd85b3          	add	a1,s11,a1
    8000438c:	0005c583          	lbu	a1,0(a1)
    80004390:	02d7d7bb          	divuw	a5,a5,a3
    80004394:	f8b40423          	sb	a1,-120(s0)
    80004398:	42ebfc63          	bgeu	s7,a4,800047d0 <__printf+0x678>
    8000439c:	02079793          	slli	a5,a5,0x20
    800043a0:	0207d793          	srli	a5,a5,0x20
    800043a4:	00fd8db3          	add	s11,s11,a5
    800043a8:	000dc703          	lbu	a4,0(s11)
    800043ac:	00a00793          	li	a5,10
    800043b0:	00900c93          	li	s9,9
    800043b4:	f8e404a3          	sb	a4,-119(s0)
    800043b8:	00065c63          	bgez	a2,800043d0 <__printf+0x278>
    800043bc:	f9040713          	addi	a4,s0,-112
    800043c0:	00f70733          	add	a4,a4,a5
    800043c4:	02d00693          	li	a3,45
    800043c8:	fed70823          	sb	a3,-16(a4)
    800043cc:	00078c93          	mv	s9,a5
    800043d0:	f8040793          	addi	a5,s0,-128
    800043d4:	01978cb3          	add	s9,a5,s9
    800043d8:	f7f40d13          	addi	s10,s0,-129
    800043dc:	000cc503          	lbu	a0,0(s9)
    800043e0:	fffc8c93          	addi	s9,s9,-1
    800043e4:	00000097          	auipc	ra,0x0
    800043e8:	b90080e7          	jalr	-1136(ra) # 80003f74 <consputc>
    800043ec:	ffac98e3          	bne	s9,s10,800043dc <__printf+0x284>
    800043f0:	00094503          	lbu	a0,0(s2)
    800043f4:	e00514e3          	bnez	a0,800041fc <__printf+0xa4>
    800043f8:	1a0c1663          	bnez	s8,800045a4 <__printf+0x44c>
    800043fc:	08813083          	ld	ra,136(sp)
    80004400:	08013403          	ld	s0,128(sp)
    80004404:	07813483          	ld	s1,120(sp)
    80004408:	07013903          	ld	s2,112(sp)
    8000440c:	06813983          	ld	s3,104(sp)
    80004410:	06013a03          	ld	s4,96(sp)
    80004414:	05813a83          	ld	s5,88(sp)
    80004418:	05013b03          	ld	s6,80(sp)
    8000441c:	04813b83          	ld	s7,72(sp)
    80004420:	04013c03          	ld	s8,64(sp)
    80004424:	03813c83          	ld	s9,56(sp)
    80004428:	03013d03          	ld	s10,48(sp)
    8000442c:	02813d83          	ld	s11,40(sp)
    80004430:	0d010113          	addi	sp,sp,208
    80004434:	00008067          	ret
    80004438:	07300713          	li	a4,115
    8000443c:	1ce78a63          	beq	a5,a4,80004610 <__printf+0x4b8>
    80004440:	07800713          	li	a4,120
    80004444:	1ee79e63          	bne	a5,a4,80004640 <__printf+0x4e8>
    80004448:	f7843783          	ld	a5,-136(s0)
    8000444c:	0007a703          	lw	a4,0(a5)
    80004450:	00878793          	addi	a5,a5,8
    80004454:	f6f43c23          	sd	a5,-136(s0)
    80004458:	28074263          	bltz	a4,800046dc <__printf+0x584>
    8000445c:	00002d97          	auipc	s11,0x2
    80004460:	ddcd8d93          	addi	s11,s11,-548 # 80006238 <digits>
    80004464:	00f77793          	andi	a5,a4,15
    80004468:	00fd87b3          	add	a5,s11,a5
    8000446c:	0007c683          	lbu	a3,0(a5)
    80004470:	00f00613          	li	a2,15
    80004474:	0007079b          	sext.w	a5,a4
    80004478:	f8d40023          	sb	a3,-128(s0)
    8000447c:	0047559b          	srliw	a1,a4,0x4
    80004480:	0047569b          	srliw	a3,a4,0x4
    80004484:	00000c93          	li	s9,0
    80004488:	0ee65063          	bge	a2,a4,80004568 <__printf+0x410>
    8000448c:	00f6f693          	andi	a3,a3,15
    80004490:	00dd86b3          	add	a3,s11,a3
    80004494:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004498:	0087d79b          	srliw	a5,a5,0x8
    8000449c:	00100c93          	li	s9,1
    800044a0:	f8d400a3          	sb	a3,-127(s0)
    800044a4:	0cb67263          	bgeu	a2,a1,80004568 <__printf+0x410>
    800044a8:	00f7f693          	andi	a3,a5,15
    800044ac:	00dd86b3          	add	a3,s11,a3
    800044b0:	0006c583          	lbu	a1,0(a3)
    800044b4:	00f00613          	li	a2,15
    800044b8:	0047d69b          	srliw	a3,a5,0x4
    800044bc:	f8b40123          	sb	a1,-126(s0)
    800044c0:	0047d593          	srli	a1,a5,0x4
    800044c4:	28f67e63          	bgeu	a2,a5,80004760 <__printf+0x608>
    800044c8:	00f6f693          	andi	a3,a3,15
    800044cc:	00dd86b3          	add	a3,s11,a3
    800044d0:	0006c503          	lbu	a0,0(a3)
    800044d4:	0087d813          	srli	a6,a5,0x8
    800044d8:	0087d69b          	srliw	a3,a5,0x8
    800044dc:	f8a401a3          	sb	a0,-125(s0)
    800044e0:	28b67663          	bgeu	a2,a1,8000476c <__printf+0x614>
    800044e4:	00f6f693          	andi	a3,a3,15
    800044e8:	00dd86b3          	add	a3,s11,a3
    800044ec:	0006c583          	lbu	a1,0(a3)
    800044f0:	00c7d513          	srli	a0,a5,0xc
    800044f4:	00c7d69b          	srliw	a3,a5,0xc
    800044f8:	f8b40223          	sb	a1,-124(s0)
    800044fc:	29067a63          	bgeu	a2,a6,80004790 <__printf+0x638>
    80004500:	00f6f693          	andi	a3,a3,15
    80004504:	00dd86b3          	add	a3,s11,a3
    80004508:	0006c583          	lbu	a1,0(a3)
    8000450c:	0107d813          	srli	a6,a5,0x10
    80004510:	0107d69b          	srliw	a3,a5,0x10
    80004514:	f8b402a3          	sb	a1,-123(s0)
    80004518:	28a67263          	bgeu	a2,a0,8000479c <__printf+0x644>
    8000451c:	00f6f693          	andi	a3,a3,15
    80004520:	00dd86b3          	add	a3,s11,a3
    80004524:	0006c683          	lbu	a3,0(a3)
    80004528:	0147d79b          	srliw	a5,a5,0x14
    8000452c:	f8d40323          	sb	a3,-122(s0)
    80004530:	21067663          	bgeu	a2,a6,8000473c <__printf+0x5e4>
    80004534:	02079793          	slli	a5,a5,0x20
    80004538:	0207d793          	srli	a5,a5,0x20
    8000453c:	00fd8db3          	add	s11,s11,a5
    80004540:	000dc683          	lbu	a3,0(s11)
    80004544:	00800793          	li	a5,8
    80004548:	00700c93          	li	s9,7
    8000454c:	f8d403a3          	sb	a3,-121(s0)
    80004550:	00075c63          	bgez	a4,80004568 <__printf+0x410>
    80004554:	f9040713          	addi	a4,s0,-112
    80004558:	00f70733          	add	a4,a4,a5
    8000455c:	02d00693          	li	a3,45
    80004560:	fed70823          	sb	a3,-16(a4)
    80004564:	00078c93          	mv	s9,a5
    80004568:	f8040793          	addi	a5,s0,-128
    8000456c:	01978cb3          	add	s9,a5,s9
    80004570:	f7f40d13          	addi	s10,s0,-129
    80004574:	000cc503          	lbu	a0,0(s9)
    80004578:	fffc8c93          	addi	s9,s9,-1
    8000457c:	00000097          	auipc	ra,0x0
    80004580:	9f8080e7          	jalr	-1544(ra) # 80003f74 <consputc>
    80004584:	ff9d18e3          	bne	s10,s9,80004574 <__printf+0x41c>
    80004588:	0100006f          	j	80004598 <__printf+0x440>
    8000458c:	00000097          	auipc	ra,0x0
    80004590:	9e8080e7          	jalr	-1560(ra) # 80003f74 <consputc>
    80004594:	000c8493          	mv	s1,s9
    80004598:	00094503          	lbu	a0,0(s2)
    8000459c:	c60510e3          	bnez	a0,800041fc <__printf+0xa4>
    800045a0:	e40c0ee3          	beqz	s8,800043fc <__printf+0x2a4>
    800045a4:	00004517          	auipc	a0,0x4
    800045a8:	02c50513          	addi	a0,a0,44 # 800085d0 <pr>
    800045ac:	00001097          	auipc	ra,0x1
    800045b0:	94c080e7          	jalr	-1716(ra) # 80004ef8 <release>
    800045b4:	e49ff06f          	j	800043fc <__printf+0x2a4>
    800045b8:	f7843783          	ld	a5,-136(s0)
    800045bc:	03000513          	li	a0,48
    800045c0:	01000d13          	li	s10,16
    800045c4:	00878713          	addi	a4,a5,8
    800045c8:	0007bc83          	ld	s9,0(a5)
    800045cc:	f6e43c23          	sd	a4,-136(s0)
    800045d0:	00000097          	auipc	ra,0x0
    800045d4:	9a4080e7          	jalr	-1628(ra) # 80003f74 <consputc>
    800045d8:	07800513          	li	a0,120
    800045dc:	00000097          	auipc	ra,0x0
    800045e0:	998080e7          	jalr	-1640(ra) # 80003f74 <consputc>
    800045e4:	00002d97          	auipc	s11,0x2
    800045e8:	c54d8d93          	addi	s11,s11,-940 # 80006238 <digits>
    800045ec:	03ccd793          	srli	a5,s9,0x3c
    800045f0:	00fd87b3          	add	a5,s11,a5
    800045f4:	0007c503          	lbu	a0,0(a5)
    800045f8:	fffd0d1b          	addiw	s10,s10,-1
    800045fc:	004c9c93          	slli	s9,s9,0x4
    80004600:	00000097          	auipc	ra,0x0
    80004604:	974080e7          	jalr	-1676(ra) # 80003f74 <consputc>
    80004608:	fe0d12e3          	bnez	s10,800045ec <__printf+0x494>
    8000460c:	f8dff06f          	j	80004598 <__printf+0x440>
    80004610:	f7843783          	ld	a5,-136(s0)
    80004614:	0007bc83          	ld	s9,0(a5)
    80004618:	00878793          	addi	a5,a5,8
    8000461c:	f6f43c23          	sd	a5,-136(s0)
    80004620:	000c9a63          	bnez	s9,80004634 <__printf+0x4dc>
    80004624:	1080006f          	j	8000472c <__printf+0x5d4>
    80004628:	001c8c93          	addi	s9,s9,1
    8000462c:	00000097          	auipc	ra,0x0
    80004630:	948080e7          	jalr	-1720(ra) # 80003f74 <consputc>
    80004634:	000cc503          	lbu	a0,0(s9)
    80004638:	fe0518e3          	bnez	a0,80004628 <__printf+0x4d0>
    8000463c:	f5dff06f          	j	80004598 <__printf+0x440>
    80004640:	02500513          	li	a0,37
    80004644:	00000097          	auipc	ra,0x0
    80004648:	930080e7          	jalr	-1744(ra) # 80003f74 <consputc>
    8000464c:	000c8513          	mv	a0,s9
    80004650:	00000097          	auipc	ra,0x0
    80004654:	924080e7          	jalr	-1756(ra) # 80003f74 <consputc>
    80004658:	f41ff06f          	j	80004598 <__printf+0x440>
    8000465c:	02500513          	li	a0,37
    80004660:	00000097          	auipc	ra,0x0
    80004664:	914080e7          	jalr	-1772(ra) # 80003f74 <consputc>
    80004668:	f31ff06f          	j	80004598 <__printf+0x440>
    8000466c:	00030513          	mv	a0,t1
    80004670:	00000097          	auipc	ra,0x0
    80004674:	7bc080e7          	jalr	1980(ra) # 80004e2c <acquire>
    80004678:	b4dff06f          	j	800041c4 <__printf+0x6c>
    8000467c:	40c0053b          	negw	a0,a2
    80004680:	00a00713          	li	a4,10
    80004684:	02e576bb          	remuw	a3,a0,a4
    80004688:	00002d97          	auipc	s11,0x2
    8000468c:	bb0d8d93          	addi	s11,s11,-1104 # 80006238 <digits>
    80004690:	ff700593          	li	a1,-9
    80004694:	02069693          	slli	a3,a3,0x20
    80004698:	0206d693          	srli	a3,a3,0x20
    8000469c:	00dd86b3          	add	a3,s11,a3
    800046a0:	0006c683          	lbu	a3,0(a3)
    800046a4:	02e557bb          	divuw	a5,a0,a4
    800046a8:	f8d40023          	sb	a3,-128(s0)
    800046ac:	10b65e63          	bge	a2,a1,800047c8 <__printf+0x670>
    800046b0:	06300593          	li	a1,99
    800046b4:	02e7f6bb          	remuw	a3,a5,a4
    800046b8:	02069693          	slli	a3,a3,0x20
    800046bc:	0206d693          	srli	a3,a3,0x20
    800046c0:	00dd86b3          	add	a3,s11,a3
    800046c4:	0006c683          	lbu	a3,0(a3)
    800046c8:	02e7d73b          	divuw	a4,a5,a4
    800046cc:	00200793          	li	a5,2
    800046d0:	f8d400a3          	sb	a3,-127(s0)
    800046d4:	bca5ece3          	bltu	a1,a0,800042ac <__printf+0x154>
    800046d8:	ce5ff06f          	j	800043bc <__printf+0x264>
    800046dc:	40e007bb          	negw	a5,a4
    800046e0:	00002d97          	auipc	s11,0x2
    800046e4:	b58d8d93          	addi	s11,s11,-1192 # 80006238 <digits>
    800046e8:	00f7f693          	andi	a3,a5,15
    800046ec:	00dd86b3          	add	a3,s11,a3
    800046f0:	0006c583          	lbu	a1,0(a3)
    800046f4:	ff100613          	li	a2,-15
    800046f8:	0047d69b          	srliw	a3,a5,0x4
    800046fc:	f8b40023          	sb	a1,-128(s0)
    80004700:	0047d59b          	srliw	a1,a5,0x4
    80004704:	0ac75e63          	bge	a4,a2,800047c0 <__printf+0x668>
    80004708:	00f6f693          	andi	a3,a3,15
    8000470c:	00dd86b3          	add	a3,s11,a3
    80004710:	0006c603          	lbu	a2,0(a3)
    80004714:	00f00693          	li	a3,15
    80004718:	0087d79b          	srliw	a5,a5,0x8
    8000471c:	f8c400a3          	sb	a2,-127(s0)
    80004720:	d8b6e4e3          	bltu	a3,a1,800044a8 <__printf+0x350>
    80004724:	00200793          	li	a5,2
    80004728:	e2dff06f          	j	80004554 <__printf+0x3fc>
    8000472c:	00002c97          	auipc	s9,0x2
    80004730:	aecc8c93          	addi	s9,s9,-1300 # 80006218 <CONSOLE_STATUS+0x208>
    80004734:	02800513          	li	a0,40
    80004738:	ef1ff06f          	j	80004628 <__printf+0x4d0>
    8000473c:	00700793          	li	a5,7
    80004740:	00600c93          	li	s9,6
    80004744:	e0dff06f          	j	80004550 <__printf+0x3f8>
    80004748:	00700793          	li	a5,7
    8000474c:	00600c93          	li	s9,6
    80004750:	c69ff06f          	j	800043b8 <__printf+0x260>
    80004754:	00300793          	li	a5,3
    80004758:	00200c93          	li	s9,2
    8000475c:	c5dff06f          	j	800043b8 <__printf+0x260>
    80004760:	00300793          	li	a5,3
    80004764:	00200c93          	li	s9,2
    80004768:	de9ff06f          	j	80004550 <__printf+0x3f8>
    8000476c:	00400793          	li	a5,4
    80004770:	00300c93          	li	s9,3
    80004774:	dddff06f          	j	80004550 <__printf+0x3f8>
    80004778:	00400793          	li	a5,4
    8000477c:	00300c93          	li	s9,3
    80004780:	c39ff06f          	j	800043b8 <__printf+0x260>
    80004784:	00500793          	li	a5,5
    80004788:	00400c93          	li	s9,4
    8000478c:	c2dff06f          	j	800043b8 <__printf+0x260>
    80004790:	00500793          	li	a5,5
    80004794:	00400c93          	li	s9,4
    80004798:	db9ff06f          	j	80004550 <__printf+0x3f8>
    8000479c:	00600793          	li	a5,6
    800047a0:	00500c93          	li	s9,5
    800047a4:	dadff06f          	j	80004550 <__printf+0x3f8>
    800047a8:	00600793          	li	a5,6
    800047ac:	00500c93          	li	s9,5
    800047b0:	c09ff06f          	j	800043b8 <__printf+0x260>
    800047b4:	00800793          	li	a5,8
    800047b8:	00700c93          	li	s9,7
    800047bc:	bfdff06f          	j	800043b8 <__printf+0x260>
    800047c0:	00100793          	li	a5,1
    800047c4:	d91ff06f          	j	80004554 <__printf+0x3fc>
    800047c8:	00100793          	li	a5,1
    800047cc:	bf1ff06f          	j	800043bc <__printf+0x264>
    800047d0:	00900793          	li	a5,9
    800047d4:	00800c93          	li	s9,8
    800047d8:	be1ff06f          	j	800043b8 <__printf+0x260>
    800047dc:	00002517          	auipc	a0,0x2
    800047e0:	a4450513          	addi	a0,a0,-1468 # 80006220 <CONSOLE_STATUS+0x210>
    800047e4:	00000097          	auipc	ra,0x0
    800047e8:	918080e7          	jalr	-1768(ra) # 800040fc <panic>

00000000800047ec <printfinit>:
    800047ec:	fe010113          	addi	sp,sp,-32
    800047f0:	00813823          	sd	s0,16(sp)
    800047f4:	00913423          	sd	s1,8(sp)
    800047f8:	00113c23          	sd	ra,24(sp)
    800047fc:	02010413          	addi	s0,sp,32
    80004800:	00004497          	auipc	s1,0x4
    80004804:	dd048493          	addi	s1,s1,-560 # 800085d0 <pr>
    80004808:	00048513          	mv	a0,s1
    8000480c:	00002597          	auipc	a1,0x2
    80004810:	a2458593          	addi	a1,a1,-1500 # 80006230 <CONSOLE_STATUS+0x220>
    80004814:	00000097          	auipc	ra,0x0
    80004818:	5f4080e7          	jalr	1524(ra) # 80004e08 <initlock>
    8000481c:	01813083          	ld	ra,24(sp)
    80004820:	01013403          	ld	s0,16(sp)
    80004824:	0004ac23          	sw	zero,24(s1)
    80004828:	00813483          	ld	s1,8(sp)
    8000482c:	02010113          	addi	sp,sp,32
    80004830:	00008067          	ret

0000000080004834 <uartinit>:
    80004834:	ff010113          	addi	sp,sp,-16
    80004838:	00813423          	sd	s0,8(sp)
    8000483c:	01010413          	addi	s0,sp,16
    80004840:	100007b7          	lui	a5,0x10000
    80004844:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004848:	f8000713          	li	a4,-128
    8000484c:	00e781a3          	sb	a4,3(a5)
    80004850:	00300713          	li	a4,3
    80004854:	00e78023          	sb	a4,0(a5)
    80004858:	000780a3          	sb	zero,1(a5)
    8000485c:	00e781a3          	sb	a4,3(a5)
    80004860:	00700693          	li	a3,7
    80004864:	00d78123          	sb	a3,2(a5)
    80004868:	00e780a3          	sb	a4,1(a5)
    8000486c:	00813403          	ld	s0,8(sp)
    80004870:	01010113          	addi	sp,sp,16
    80004874:	00008067          	ret

0000000080004878 <uartputc>:
    80004878:	00003797          	auipc	a5,0x3
    8000487c:	ac07a783          	lw	a5,-1344(a5) # 80007338 <panicked>
    80004880:	00078463          	beqz	a5,80004888 <uartputc+0x10>
    80004884:	0000006f          	j	80004884 <uartputc+0xc>
    80004888:	fd010113          	addi	sp,sp,-48
    8000488c:	02813023          	sd	s0,32(sp)
    80004890:	00913c23          	sd	s1,24(sp)
    80004894:	01213823          	sd	s2,16(sp)
    80004898:	01313423          	sd	s3,8(sp)
    8000489c:	02113423          	sd	ra,40(sp)
    800048a0:	03010413          	addi	s0,sp,48
    800048a4:	00003917          	auipc	s2,0x3
    800048a8:	a9c90913          	addi	s2,s2,-1380 # 80007340 <uart_tx_r>
    800048ac:	00093783          	ld	a5,0(s2)
    800048b0:	00003497          	auipc	s1,0x3
    800048b4:	a9848493          	addi	s1,s1,-1384 # 80007348 <uart_tx_w>
    800048b8:	0004b703          	ld	a4,0(s1)
    800048bc:	02078693          	addi	a3,a5,32
    800048c0:	00050993          	mv	s3,a0
    800048c4:	02e69c63          	bne	a3,a4,800048fc <uartputc+0x84>
    800048c8:	00001097          	auipc	ra,0x1
    800048cc:	834080e7          	jalr	-1996(ra) # 800050fc <push_on>
    800048d0:	00093783          	ld	a5,0(s2)
    800048d4:	0004b703          	ld	a4,0(s1)
    800048d8:	02078793          	addi	a5,a5,32
    800048dc:	00e79463          	bne	a5,a4,800048e4 <uartputc+0x6c>
    800048e0:	0000006f          	j	800048e0 <uartputc+0x68>
    800048e4:	00001097          	auipc	ra,0x1
    800048e8:	88c080e7          	jalr	-1908(ra) # 80005170 <pop_on>
    800048ec:	00093783          	ld	a5,0(s2)
    800048f0:	0004b703          	ld	a4,0(s1)
    800048f4:	02078693          	addi	a3,a5,32
    800048f8:	fce688e3          	beq	a3,a4,800048c8 <uartputc+0x50>
    800048fc:	01f77693          	andi	a3,a4,31
    80004900:	00004597          	auipc	a1,0x4
    80004904:	cf058593          	addi	a1,a1,-784 # 800085f0 <uart_tx_buf>
    80004908:	00d586b3          	add	a3,a1,a3
    8000490c:	00170713          	addi	a4,a4,1
    80004910:	01368023          	sb	s3,0(a3)
    80004914:	00e4b023          	sd	a4,0(s1)
    80004918:	10000637          	lui	a2,0x10000
    8000491c:	02f71063          	bne	a4,a5,8000493c <uartputc+0xc4>
    80004920:	0340006f          	j	80004954 <uartputc+0xdc>
    80004924:	00074703          	lbu	a4,0(a4)
    80004928:	00f93023          	sd	a5,0(s2)
    8000492c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004930:	00093783          	ld	a5,0(s2)
    80004934:	0004b703          	ld	a4,0(s1)
    80004938:	00f70e63          	beq	a4,a5,80004954 <uartputc+0xdc>
    8000493c:	00564683          	lbu	a3,5(a2)
    80004940:	01f7f713          	andi	a4,a5,31
    80004944:	00e58733          	add	a4,a1,a4
    80004948:	0206f693          	andi	a3,a3,32
    8000494c:	00178793          	addi	a5,a5,1
    80004950:	fc069ae3          	bnez	a3,80004924 <uartputc+0xac>
    80004954:	02813083          	ld	ra,40(sp)
    80004958:	02013403          	ld	s0,32(sp)
    8000495c:	01813483          	ld	s1,24(sp)
    80004960:	01013903          	ld	s2,16(sp)
    80004964:	00813983          	ld	s3,8(sp)
    80004968:	03010113          	addi	sp,sp,48
    8000496c:	00008067          	ret

0000000080004970 <uartputc_sync>:
    80004970:	ff010113          	addi	sp,sp,-16
    80004974:	00813423          	sd	s0,8(sp)
    80004978:	01010413          	addi	s0,sp,16
    8000497c:	00003717          	auipc	a4,0x3
    80004980:	9bc72703          	lw	a4,-1604(a4) # 80007338 <panicked>
    80004984:	02071663          	bnez	a4,800049b0 <uartputc_sync+0x40>
    80004988:	00050793          	mv	a5,a0
    8000498c:	100006b7          	lui	a3,0x10000
    80004990:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004994:	02077713          	andi	a4,a4,32
    80004998:	fe070ce3          	beqz	a4,80004990 <uartputc_sync+0x20>
    8000499c:	0ff7f793          	andi	a5,a5,255
    800049a0:	00f68023          	sb	a5,0(a3)
    800049a4:	00813403          	ld	s0,8(sp)
    800049a8:	01010113          	addi	sp,sp,16
    800049ac:	00008067          	ret
    800049b0:	0000006f          	j	800049b0 <uartputc_sync+0x40>

00000000800049b4 <uartstart>:
    800049b4:	ff010113          	addi	sp,sp,-16
    800049b8:	00813423          	sd	s0,8(sp)
    800049bc:	01010413          	addi	s0,sp,16
    800049c0:	00003617          	auipc	a2,0x3
    800049c4:	98060613          	addi	a2,a2,-1664 # 80007340 <uart_tx_r>
    800049c8:	00003517          	auipc	a0,0x3
    800049cc:	98050513          	addi	a0,a0,-1664 # 80007348 <uart_tx_w>
    800049d0:	00063783          	ld	a5,0(a2)
    800049d4:	00053703          	ld	a4,0(a0)
    800049d8:	04f70263          	beq	a4,a5,80004a1c <uartstart+0x68>
    800049dc:	100005b7          	lui	a1,0x10000
    800049e0:	00004817          	auipc	a6,0x4
    800049e4:	c1080813          	addi	a6,a6,-1008 # 800085f0 <uart_tx_buf>
    800049e8:	01c0006f          	j	80004a04 <uartstart+0x50>
    800049ec:	0006c703          	lbu	a4,0(a3)
    800049f0:	00f63023          	sd	a5,0(a2)
    800049f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800049f8:	00063783          	ld	a5,0(a2)
    800049fc:	00053703          	ld	a4,0(a0)
    80004a00:	00f70e63          	beq	a4,a5,80004a1c <uartstart+0x68>
    80004a04:	01f7f713          	andi	a4,a5,31
    80004a08:	00e806b3          	add	a3,a6,a4
    80004a0c:	0055c703          	lbu	a4,5(a1)
    80004a10:	00178793          	addi	a5,a5,1
    80004a14:	02077713          	andi	a4,a4,32
    80004a18:	fc071ae3          	bnez	a4,800049ec <uartstart+0x38>
    80004a1c:	00813403          	ld	s0,8(sp)
    80004a20:	01010113          	addi	sp,sp,16
    80004a24:	00008067          	ret

0000000080004a28 <uartgetc>:
    80004a28:	ff010113          	addi	sp,sp,-16
    80004a2c:	00813423          	sd	s0,8(sp)
    80004a30:	01010413          	addi	s0,sp,16
    80004a34:	10000737          	lui	a4,0x10000
    80004a38:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80004a3c:	0017f793          	andi	a5,a5,1
    80004a40:	00078c63          	beqz	a5,80004a58 <uartgetc+0x30>
    80004a44:	00074503          	lbu	a0,0(a4)
    80004a48:	0ff57513          	andi	a0,a0,255
    80004a4c:	00813403          	ld	s0,8(sp)
    80004a50:	01010113          	addi	sp,sp,16
    80004a54:	00008067          	ret
    80004a58:	fff00513          	li	a0,-1
    80004a5c:	ff1ff06f          	j	80004a4c <uartgetc+0x24>

0000000080004a60 <uartintr>:
    80004a60:	100007b7          	lui	a5,0x10000
    80004a64:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004a68:	0017f793          	andi	a5,a5,1
    80004a6c:	0a078463          	beqz	a5,80004b14 <uartintr+0xb4>
    80004a70:	fe010113          	addi	sp,sp,-32
    80004a74:	00813823          	sd	s0,16(sp)
    80004a78:	00913423          	sd	s1,8(sp)
    80004a7c:	00113c23          	sd	ra,24(sp)
    80004a80:	02010413          	addi	s0,sp,32
    80004a84:	100004b7          	lui	s1,0x10000
    80004a88:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80004a8c:	0ff57513          	andi	a0,a0,255
    80004a90:	fffff097          	auipc	ra,0xfffff
    80004a94:	534080e7          	jalr	1332(ra) # 80003fc4 <consoleintr>
    80004a98:	0054c783          	lbu	a5,5(s1)
    80004a9c:	0017f793          	andi	a5,a5,1
    80004aa0:	fe0794e3          	bnez	a5,80004a88 <uartintr+0x28>
    80004aa4:	00003617          	auipc	a2,0x3
    80004aa8:	89c60613          	addi	a2,a2,-1892 # 80007340 <uart_tx_r>
    80004aac:	00003517          	auipc	a0,0x3
    80004ab0:	89c50513          	addi	a0,a0,-1892 # 80007348 <uart_tx_w>
    80004ab4:	00063783          	ld	a5,0(a2)
    80004ab8:	00053703          	ld	a4,0(a0)
    80004abc:	04f70263          	beq	a4,a5,80004b00 <uartintr+0xa0>
    80004ac0:	100005b7          	lui	a1,0x10000
    80004ac4:	00004817          	auipc	a6,0x4
    80004ac8:	b2c80813          	addi	a6,a6,-1236 # 800085f0 <uart_tx_buf>
    80004acc:	01c0006f          	j	80004ae8 <uartintr+0x88>
    80004ad0:	0006c703          	lbu	a4,0(a3)
    80004ad4:	00f63023          	sd	a5,0(a2)
    80004ad8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004adc:	00063783          	ld	a5,0(a2)
    80004ae0:	00053703          	ld	a4,0(a0)
    80004ae4:	00f70e63          	beq	a4,a5,80004b00 <uartintr+0xa0>
    80004ae8:	01f7f713          	andi	a4,a5,31
    80004aec:	00e806b3          	add	a3,a6,a4
    80004af0:	0055c703          	lbu	a4,5(a1)
    80004af4:	00178793          	addi	a5,a5,1
    80004af8:	02077713          	andi	a4,a4,32
    80004afc:	fc071ae3          	bnez	a4,80004ad0 <uartintr+0x70>
    80004b00:	01813083          	ld	ra,24(sp)
    80004b04:	01013403          	ld	s0,16(sp)
    80004b08:	00813483          	ld	s1,8(sp)
    80004b0c:	02010113          	addi	sp,sp,32
    80004b10:	00008067          	ret
    80004b14:	00003617          	auipc	a2,0x3
    80004b18:	82c60613          	addi	a2,a2,-2004 # 80007340 <uart_tx_r>
    80004b1c:	00003517          	auipc	a0,0x3
    80004b20:	82c50513          	addi	a0,a0,-2004 # 80007348 <uart_tx_w>
    80004b24:	00063783          	ld	a5,0(a2)
    80004b28:	00053703          	ld	a4,0(a0)
    80004b2c:	04f70263          	beq	a4,a5,80004b70 <uartintr+0x110>
    80004b30:	100005b7          	lui	a1,0x10000
    80004b34:	00004817          	auipc	a6,0x4
    80004b38:	abc80813          	addi	a6,a6,-1348 # 800085f0 <uart_tx_buf>
    80004b3c:	01c0006f          	j	80004b58 <uartintr+0xf8>
    80004b40:	0006c703          	lbu	a4,0(a3)
    80004b44:	00f63023          	sd	a5,0(a2)
    80004b48:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004b4c:	00063783          	ld	a5,0(a2)
    80004b50:	00053703          	ld	a4,0(a0)
    80004b54:	02f70063          	beq	a4,a5,80004b74 <uartintr+0x114>
    80004b58:	01f7f713          	andi	a4,a5,31
    80004b5c:	00e806b3          	add	a3,a6,a4
    80004b60:	0055c703          	lbu	a4,5(a1)
    80004b64:	00178793          	addi	a5,a5,1
    80004b68:	02077713          	andi	a4,a4,32
    80004b6c:	fc071ae3          	bnez	a4,80004b40 <uartintr+0xe0>
    80004b70:	00008067          	ret
    80004b74:	00008067          	ret

0000000080004b78 <kinit>:
    80004b78:	fc010113          	addi	sp,sp,-64
    80004b7c:	02913423          	sd	s1,40(sp)
    80004b80:	fffff7b7          	lui	a5,0xfffff
    80004b84:	00005497          	auipc	s1,0x5
    80004b88:	a8b48493          	addi	s1,s1,-1397 # 8000960f <end+0xfff>
    80004b8c:	02813823          	sd	s0,48(sp)
    80004b90:	01313c23          	sd	s3,24(sp)
    80004b94:	00f4f4b3          	and	s1,s1,a5
    80004b98:	02113c23          	sd	ra,56(sp)
    80004b9c:	03213023          	sd	s2,32(sp)
    80004ba0:	01413823          	sd	s4,16(sp)
    80004ba4:	01513423          	sd	s5,8(sp)
    80004ba8:	04010413          	addi	s0,sp,64
    80004bac:	000017b7          	lui	a5,0x1
    80004bb0:	01100993          	li	s3,17
    80004bb4:	00f487b3          	add	a5,s1,a5
    80004bb8:	01b99993          	slli	s3,s3,0x1b
    80004bbc:	06f9e063          	bltu	s3,a5,80004c1c <kinit+0xa4>
    80004bc0:	00004a97          	auipc	s5,0x4
    80004bc4:	a50a8a93          	addi	s5,s5,-1456 # 80008610 <end>
    80004bc8:	0754ec63          	bltu	s1,s5,80004c40 <kinit+0xc8>
    80004bcc:	0734fa63          	bgeu	s1,s3,80004c40 <kinit+0xc8>
    80004bd0:	00088a37          	lui	s4,0x88
    80004bd4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004bd8:	00002917          	auipc	s2,0x2
    80004bdc:	77890913          	addi	s2,s2,1912 # 80007350 <kmem>
    80004be0:	00ca1a13          	slli	s4,s4,0xc
    80004be4:	0140006f          	j	80004bf8 <kinit+0x80>
    80004be8:	000017b7          	lui	a5,0x1
    80004bec:	00f484b3          	add	s1,s1,a5
    80004bf0:	0554e863          	bltu	s1,s5,80004c40 <kinit+0xc8>
    80004bf4:	0534f663          	bgeu	s1,s3,80004c40 <kinit+0xc8>
    80004bf8:	00001637          	lui	a2,0x1
    80004bfc:	00100593          	li	a1,1
    80004c00:	00048513          	mv	a0,s1
    80004c04:	00000097          	auipc	ra,0x0
    80004c08:	5e4080e7          	jalr	1508(ra) # 800051e8 <__memset>
    80004c0c:	00093783          	ld	a5,0(s2)
    80004c10:	00f4b023          	sd	a5,0(s1)
    80004c14:	00993023          	sd	s1,0(s2)
    80004c18:	fd4498e3          	bne	s1,s4,80004be8 <kinit+0x70>
    80004c1c:	03813083          	ld	ra,56(sp)
    80004c20:	03013403          	ld	s0,48(sp)
    80004c24:	02813483          	ld	s1,40(sp)
    80004c28:	02013903          	ld	s2,32(sp)
    80004c2c:	01813983          	ld	s3,24(sp)
    80004c30:	01013a03          	ld	s4,16(sp)
    80004c34:	00813a83          	ld	s5,8(sp)
    80004c38:	04010113          	addi	sp,sp,64
    80004c3c:	00008067          	ret
    80004c40:	00001517          	auipc	a0,0x1
    80004c44:	61050513          	addi	a0,a0,1552 # 80006250 <digits+0x18>
    80004c48:	fffff097          	auipc	ra,0xfffff
    80004c4c:	4b4080e7          	jalr	1204(ra) # 800040fc <panic>

0000000080004c50 <freerange>:
    80004c50:	fc010113          	addi	sp,sp,-64
    80004c54:	000017b7          	lui	a5,0x1
    80004c58:	02913423          	sd	s1,40(sp)
    80004c5c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004c60:	009504b3          	add	s1,a0,s1
    80004c64:	fffff537          	lui	a0,0xfffff
    80004c68:	02813823          	sd	s0,48(sp)
    80004c6c:	02113c23          	sd	ra,56(sp)
    80004c70:	03213023          	sd	s2,32(sp)
    80004c74:	01313c23          	sd	s3,24(sp)
    80004c78:	01413823          	sd	s4,16(sp)
    80004c7c:	01513423          	sd	s5,8(sp)
    80004c80:	01613023          	sd	s6,0(sp)
    80004c84:	04010413          	addi	s0,sp,64
    80004c88:	00a4f4b3          	and	s1,s1,a0
    80004c8c:	00f487b3          	add	a5,s1,a5
    80004c90:	06f5e463          	bltu	a1,a5,80004cf8 <freerange+0xa8>
    80004c94:	00004a97          	auipc	s5,0x4
    80004c98:	97ca8a93          	addi	s5,s5,-1668 # 80008610 <end>
    80004c9c:	0954e263          	bltu	s1,s5,80004d20 <freerange+0xd0>
    80004ca0:	01100993          	li	s3,17
    80004ca4:	01b99993          	slli	s3,s3,0x1b
    80004ca8:	0734fc63          	bgeu	s1,s3,80004d20 <freerange+0xd0>
    80004cac:	00058a13          	mv	s4,a1
    80004cb0:	00002917          	auipc	s2,0x2
    80004cb4:	6a090913          	addi	s2,s2,1696 # 80007350 <kmem>
    80004cb8:	00002b37          	lui	s6,0x2
    80004cbc:	0140006f          	j	80004cd0 <freerange+0x80>
    80004cc0:	000017b7          	lui	a5,0x1
    80004cc4:	00f484b3          	add	s1,s1,a5
    80004cc8:	0554ec63          	bltu	s1,s5,80004d20 <freerange+0xd0>
    80004ccc:	0534fa63          	bgeu	s1,s3,80004d20 <freerange+0xd0>
    80004cd0:	00001637          	lui	a2,0x1
    80004cd4:	00100593          	li	a1,1
    80004cd8:	00048513          	mv	a0,s1
    80004cdc:	00000097          	auipc	ra,0x0
    80004ce0:	50c080e7          	jalr	1292(ra) # 800051e8 <__memset>
    80004ce4:	00093703          	ld	a4,0(s2)
    80004ce8:	016487b3          	add	a5,s1,s6
    80004cec:	00e4b023          	sd	a4,0(s1)
    80004cf0:	00993023          	sd	s1,0(s2)
    80004cf4:	fcfa76e3          	bgeu	s4,a5,80004cc0 <freerange+0x70>
    80004cf8:	03813083          	ld	ra,56(sp)
    80004cfc:	03013403          	ld	s0,48(sp)
    80004d00:	02813483          	ld	s1,40(sp)
    80004d04:	02013903          	ld	s2,32(sp)
    80004d08:	01813983          	ld	s3,24(sp)
    80004d0c:	01013a03          	ld	s4,16(sp)
    80004d10:	00813a83          	ld	s5,8(sp)
    80004d14:	00013b03          	ld	s6,0(sp)
    80004d18:	04010113          	addi	sp,sp,64
    80004d1c:	00008067          	ret
    80004d20:	00001517          	auipc	a0,0x1
    80004d24:	53050513          	addi	a0,a0,1328 # 80006250 <digits+0x18>
    80004d28:	fffff097          	auipc	ra,0xfffff
    80004d2c:	3d4080e7          	jalr	980(ra) # 800040fc <panic>

0000000080004d30 <kfree>:
    80004d30:	fe010113          	addi	sp,sp,-32
    80004d34:	00813823          	sd	s0,16(sp)
    80004d38:	00113c23          	sd	ra,24(sp)
    80004d3c:	00913423          	sd	s1,8(sp)
    80004d40:	02010413          	addi	s0,sp,32
    80004d44:	03451793          	slli	a5,a0,0x34
    80004d48:	04079c63          	bnez	a5,80004da0 <kfree+0x70>
    80004d4c:	00004797          	auipc	a5,0x4
    80004d50:	8c478793          	addi	a5,a5,-1852 # 80008610 <end>
    80004d54:	00050493          	mv	s1,a0
    80004d58:	04f56463          	bltu	a0,a5,80004da0 <kfree+0x70>
    80004d5c:	01100793          	li	a5,17
    80004d60:	01b79793          	slli	a5,a5,0x1b
    80004d64:	02f57e63          	bgeu	a0,a5,80004da0 <kfree+0x70>
    80004d68:	00001637          	lui	a2,0x1
    80004d6c:	00100593          	li	a1,1
    80004d70:	00000097          	auipc	ra,0x0
    80004d74:	478080e7          	jalr	1144(ra) # 800051e8 <__memset>
    80004d78:	00002797          	auipc	a5,0x2
    80004d7c:	5d878793          	addi	a5,a5,1496 # 80007350 <kmem>
    80004d80:	0007b703          	ld	a4,0(a5)
    80004d84:	01813083          	ld	ra,24(sp)
    80004d88:	01013403          	ld	s0,16(sp)
    80004d8c:	00e4b023          	sd	a4,0(s1)
    80004d90:	0097b023          	sd	s1,0(a5)
    80004d94:	00813483          	ld	s1,8(sp)
    80004d98:	02010113          	addi	sp,sp,32
    80004d9c:	00008067          	ret
    80004da0:	00001517          	auipc	a0,0x1
    80004da4:	4b050513          	addi	a0,a0,1200 # 80006250 <digits+0x18>
    80004da8:	fffff097          	auipc	ra,0xfffff
    80004dac:	354080e7          	jalr	852(ra) # 800040fc <panic>

0000000080004db0 <kalloc>:
    80004db0:	fe010113          	addi	sp,sp,-32
    80004db4:	00813823          	sd	s0,16(sp)
    80004db8:	00913423          	sd	s1,8(sp)
    80004dbc:	00113c23          	sd	ra,24(sp)
    80004dc0:	02010413          	addi	s0,sp,32
    80004dc4:	00002797          	auipc	a5,0x2
    80004dc8:	58c78793          	addi	a5,a5,1420 # 80007350 <kmem>
    80004dcc:	0007b483          	ld	s1,0(a5)
    80004dd0:	02048063          	beqz	s1,80004df0 <kalloc+0x40>
    80004dd4:	0004b703          	ld	a4,0(s1)
    80004dd8:	00001637          	lui	a2,0x1
    80004ddc:	00500593          	li	a1,5
    80004de0:	00048513          	mv	a0,s1
    80004de4:	00e7b023          	sd	a4,0(a5)
    80004de8:	00000097          	auipc	ra,0x0
    80004dec:	400080e7          	jalr	1024(ra) # 800051e8 <__memset>
    80004df0:	01813083          	ld	ra,24(sp)
    80004df4:	01013403          	ld	s0,16(sp)
    80004df8:	00048513          	mv	a0,s1
    80004dfc:	00813483          	ld	s1,8(sp)
    80004e00:	02010113          	addi	sp,sp,32
    80004e04:	00008067          	ret

0000000080004e08 <initlock>:
    80004e08:	ff010113          	addi	sp,sp,-16
    80004e0c:	00813423          	sd	s0,8(sp)
    80004e10:	01010413          	addi	s0,sp,16
    80004e14:	00813403          	ld	s0,8(sp)
    80004e18:	00b53423          	sd	a1,8(a0)
    80004e1c:	00052023          	sw	zero,0(a0)
    80004e20:	00053823          	sd	zero,16(a0)
    80004e24:	01010113          	addi	sp,sp,16
    80004e28:	00008067          	ret

0000000080004e2c <acquire>:
    80004e2c:	fe010113          	addi	sp,sp,-32
    80004e30:	00813823          	sd	s0,16(sp)
    80004e34:	00913423          	sd	s1,8(sp)
    80004e38:	00113c23          	sd	ra,24(sp)
    80004e3c:	01213023          	sd	s2,0(sp)
    80004e40:	02010413          	addi	s0,sp,32
    80004e44:	00050493          	mv	s1,a0
    80004e48:	10002973          	csrr	s2,sstatus
    80004e4c:	100027f3          	csrr	a5,sstatus
    80004e50:	ffd7f793          	andi	a5,a5,-3
    80004e54:	10079073          	csrw	sstatus,a5
    80004e58:	fffff097          	auipc	ra,0xfffff
    80004e5c:	8e0080e7          	jalr	-1824(ra) # 80003738 <mycpu>
    80004e60:	07852783          	lw	a5,120(a0)
    80004e64:	06078e63          	beqz	a5,80004ee0 <acquire+0xb4>
    80004e68:	fffff097          	auipc	ra,0xfffff
    80004e6c:	8d0080e7          	jalr	-1840(ra) # 80003738 <mycpu>
    80004e70:	07852783          	lw	a5,120(a0)
    80004e74:	0004a703          	lw	a4,0(s1)
    80004e78:	0017879b          	addiw	a5,a5,1
    80004e7c:	06f52c23          	sw	a5,120(a0)
    80004e80:	04071063          	bnez	a4,80004ec0 <acquire+0x94>
    80004e84:	00100713          	li	a4,1
    80004e88:	00070793          	mv	a5,a4
    80004e8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004e90:	0007879b          	sext.w	a5,a5
    80004e94:	fe079ae3          	bnez	a5,80004e88 <acquire+0x5c>
    80004e98:	0ff0000f          	fence
    80004e9c:	fffff097          	auipc	ra,0xfffff
    80004ea0:	89c080e7          	jalr	-1892(ra) # 80003738 <mycpu>
    80004ea4:	01813083          	ld	ra,24(sp)
    80004ea8:	01013403          	ld	s0,16(sp)
    80004eac:	00a4b823          	sd	a0,16(s1)
    80004eb0:	00013903          	ld	s2,0(sp)
    80004eb4:	00813483          	ld	s1,8(sp)
    80004eb8:	02010113          	addi	sp,sp,32
    80004ebc:	00008067          	ret
    80004ec0:	0104b903          	ld	s2,16(s1)
    80004ec4:	fffff097          	auipc	ra,0xfffff
    80004ec8:	874080e7          	jalr	-1932(ra) # 80003738 <mycpu>
    80004ecc:	faa91ce3          	bne	s2,a0,80004e84 <acquire+0x58>
    80004ed0:	00001517          	auipc	a0,0x1
    80004ed4:	38850513          	addi	a0,a0,904 # 80006258 <digits+0x20>
    80004ed8:	fffff097          	auipc	ra,0xfffff
    80004edc:	224080e7          	jalr	548(ra) # 800040fc <panic>
    80004ee0:	00195913          	srli	s2,s2,0x1
    80004ee4:	fffff097          	auipc	ra,0xfffff
    80004ee8:	854080e7          	jalr	-1964(ra) # 80003738 <mycpu>
    80004eec:	00197913          	andi	s2,s2,1
    80004ef0:	07252e23          	sw	s2,124(a0)
    80004ef4:	f75ff06f          	j	80004e68 <acquire+0x3c>

0000000080004ef8 <release>:
    80004ef8:	fe010113          	addi	sp,sp,-32
    80004efc:	00813823          	sd	s0,16(sp)
    80004f00:	00113c23          	sd	ra,24(sp)
    80004f04:	00913423          	sd	s1,8(sp)
    80004f08:	01213023          	sd	s2,0(sp)
    80004f0c:	02010413          	addi	s0,sp,32
    80004f10:	00052783          	lw	a5,0(a0)
    80004f14:	00079a63          	bnez	a5,80004f28 <release+0x30>
    80004f18:	00001517          	auipc	a0,0x1
    80004f1c:	34850513          	addi	a0,a0,840 # 80006260 <digits+0x28>
    80004f20:	fffff097          	auipc	ra,0xfffff
    80004f24:	1dc080e7          	jalr	476(ra) # 800040fc <panic>
    80004f28:	01053903          	ld	s2,16(a0)
    80004f2c:	00050493          	mv	s1,a0
    80004f30:	fffff097          	auipc	ra,0xfffff
    80004f34:	808080e7          	jalr	-2040(ra) # 80003738 <mycpu>
    80004f38:	fea910e3          	bne	s2,a0,80004f18 <release+0x20>
    80004f3c:	0004b823          	sd	zero,16(s1)
    80004f40:	0ff0000f          	fence
    80004f44:	0f50000f          	fence	iorw,ow
    80004f48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80004f4c:	ffffe097          	auipc	ra,0xffffe
    80004f50:	7ec080e7          	jalr	2028(ra) # 80003738 <mycpu>
    80004f54:	100027f3          	csrr	a5,sstatus
    80004f58:	0027f793          	andi	a5,a5,2
    80004f5c:	04079a63          	bnez	a5,80004fb0 <release+0xb8>
    80004f60:	07852783          	lw	a5,120(a0)
    80004f64:	02f05e63          	blez	a5,80004fa0 <release+0xa8>
    80004f68:	fff7871b          	addiw	a4,a5,-1
    80004f6c:	06e52c23          	sw	a4,120(a0)
    80004f70:	00071c63          	bnez	a4,80004f88 <release+0x90>
    80004f74:	07c52783          	lw	a5,124(a0)
    80004f78:	00078863          	beqz	a5,80004f88 <release+0x90>
    80004f7c:	100027f3          	csrr	a5,sstatus
    80004f80:	0027e793          	ori	a5,a5,2
    80004f84:	10079073          	csrw	sstatus,a5
    80004f88:	01813083          	ld	ra,24(sp)
    80004f8c:	01013403          	ld	s0,16(sp)
    80004f90:	00813483          	ld	s1,8(sp)
    80004f94:	00013903          	ld	s2,0(sp)
    80004f98:	02010113          	addi	sp,sp,32
    80004f9c:	00008067          	ret
    80004fa0:	00001517          	auipc	a0,0x1
    80004fa4:	2e050513          	addi	a0,a0,736 # 80006280 <digits+0x48>
    80004fa8:	fffff097          	auipc	ra,0xfffff
    80004fac:	154080e7          	jalr	340(ra) # 800040fc <panic>
    80004fb0:	00001517          	auipc	a0,0x1
    80004fb4:	2b850513          	addi	a0,a0,696 # 80006268 <digits+0x30>
    80004fb8:	fffff097          	auipc	ra,0xfffff
    80004fbc:	144080e7          	jalr	324(ra) # 800040fc <panic>

0000000080004fc0 <holding>:
    80004fc0:	00052783          	lw	a5,0(a0)
    80004fc4:	00079663          	bnez	a5,80004fd0 <holding+0x10>
    80004fc8:	00000513          	li	a0,0
    80004fcc:	00008067          	ret
    80004fd0:	fe010113          	addi	sp,sp,-32
    80004fd4:	00813823          	sd	s0,16(sp)
    80004fd8:	00913423          	sd	s1,8(sp)
    80004fdc:	00113c23          	sd	ra,24(sp)
    80004fe0:	02010413          	addi	s0,sp,32
    80004fe4:	01053483          	ld	s1,16(a0)
    80004fe8:	ffffe097          	auipc	ra,0xffffe
    80004fec:	750080e7          	jalr	1872(ra) # 80003738 <mycpu>
    80004ff0:	01813083          	ld	ra,24(sp)
    80004ff4:	01013403          	ld	s0,16(sp)
    80004ff8:	40a48533          	sub	a0,s1,a0
    80004ffc:	00153513          	seqz	a0,a0
    80005000:	00813483          	ld	s1,8(sp)
    80005004:	02010113          	addi	sp,sp,32
    80005008:	00008067          	ret

000000008000500c <push_off>:
    8000500c:	fe010113          	addi	sp,sp,-32
    80005010:	00813823          	sd	s0,16(sp)
    80005014:	00113c23          	sd	ra,24(sp)
    80005018:	00913423          	sd	s1,8(sp)
    8000501c:	02010413          	addi	s0,sp,32
    80005020:	100024f3          	csrr	s1,sstatus
    80005024:	100027f3          	csrr	a5,sstatus
    80005028:	ffd7f793          	andi	a5,a5,-3
    8000502c:	10079073          	csrw	sstatus,a5
    80005030:	ffffe097          	auipc	ra,0xffffe
    80005034:	708080e7          	jalr	1800(ra) # 80003738 <mycpu>
    80005038:	07852783          	lw	a5,120(a0)
    8000503c:	02078663          	beqz	a5,80005068 <push_off+0x5c>
    80005040:	ffffe097          	auipc	ra,0xffffe
    80005044:	6f8080e7          	jalr	1784(ra) # 80003738 <mycpu>
    80005048:	07852783          	lw	a5,120(a0)
    8000504c:	01813083          	ld	ra,24(sp)
    80005050:	01013403          	ld	s0,16(sp)
    80005054:	0017879b          	addiw	a5,a5,1
    80005058:	06f52c23          	sw	a5,120(a0)
    8000505c:	00813483          	ld	s1,8(sp)
    80005060:	02010113          	addi	sp,sp,32
    80005064:	00008067          	ret
    80005068:	0014d493          	srli	s1,s1,0x1
    8000506c:	ffffe097          	auipc	ra,0xffffe
    80005070:	6cc080e7          	jalr	1740(ra) # 80003738 <mycpu>
    80005074:	0014f493          	andi	s1,s1,1
    80005078:	06952e23          	sw	s1,124(a0)
    8000507c:	fc5ff06f          	j	80005040 <push_off+0x34>

0000000080005080 <pop_off>:
    80005080:	ff010113          	addi	sp,sp,-16
    80005084:	00813023          	sd	s0,0(sp)
    80005088:	00113423          	sd	ra,8(sp)
    8000508c:	01010413          	addi	s0,sp,16
    80005090:	ffffe097          	auipc	ra,0xffffe
    80005094:	6a8080e7          	jalr	1704(ra) # 80003738 <mycpu>
    80005098:	100027f3          	csrr	a5,sstatus
    8000509c:	0027f793          	andi	a5,a5,2
    800050a0:	04079663          	bnez	a5,800050ec <pop_off+0x6c>
    800050a4:	07852783          	lw	a5,120(a0)
    800050a8:	02f05a63          	blez	a5,800050dc <pop_off+0x5c>
    800050ac:	fff7871b          	addiw	a4,a5,-1
    800050b0:	06e52c23          	sw	a4,120(a0)
    800050b4:	00071c63          	bnez	a4,800050cc <pop_off+0x4c>
    800050b8:	07c52783          	lw	a5,124(a0)
    800050bc:	00078863          	beqz	a5,800050cc <pop_off+0x4c>
    800050c0:	100027f3          	csrr	a5,sstatus
    800050c4:	0027e793          	ori	a5,a5,2
    800050c8:	10079073          	csrw	sstatus,a5
    800050cc:	00813083          	ld	ra,8(sp)
    800050d0:	00013403          	ld	s0,0(sp)
    800050d4:	01010113          	addi	sp,sp,16
    800050d8:	00008067          	ret
    800050dc:	00001517          	auipc	a0,0x1
    800050e0:	1a450513          	addi	a0,a0,420 # 80006280 <digits+0x48>
    800050e4:	fffff097          	auipc	ra,0xfffff
    800050e8:	018080e7          	jalr	24(ra) # 800040fc <panic>
    800050ec:	00001517          	auipc	a0,0x1
    800050f0:	17c50513          	addi	a0,a0,380 # 80006268 <digits+0x30>
    800050f4:	fffff097          	auipc	ra,0xfffff
    800050f8:	008080e7          	jalr	8(ra) # 800040fc <panic>

00000000800050fc <push_on>:
    800050fc:	fe010113          	addi	sp,sp,-32
    80005100:	00813823          	sd	s0,16(sp)
    80005104:	00113c23          	sd	ra,24(sp)
    80005108:	00913423          	sd	s1,8(sp)
    8000510c:	02010413          	addi	s0,sp,32
    80005110:	100024f3          	csrr	s1,sstatus
    80005114:	100027f3          	csrr	a5,sstatus
    80005118:	0027e793          	ori	a5,a5,2
    8000511c:	10079073          	csrw	sstatus,a5
    80005120:	ffffe097          	auipc	ra,0xffffe
    80005124:	618080e7          	jalr	1560(ra) # 80003738 <mycpu>
    80005128:	07852783          	lw	a5,120(a0)
    8000512c:	02078663          	beqz	a5,80005158 <push_on+0x5c>
    80005130:	ffffe097          	auipc	ra,0xffffe
    80005134:	608080e7          	jalr	1544(ra) # 80003738 <mycpu>
    80005138:	07852783          	lw	a5,120(a0)
    8000513c:	01813083          	ld	ra,24(sp)
    80005140:	01013403          	ld	s0,16(sp)
    80005144:	0017879b          	addiw	a5,a5,1
    80005148:	06f52c23          	sw	a5,120(a0)
    8000514c:	00813483          	ld	s1,8(sp)
    80005150:	02010113          	addi	sp,sp,32
    80005154:	00008067          	ret
    80005158:	0014d493          	srli	s1,s1,0x1
    8000515c:	ffffe097          	auipc	ra,0xffffe
    80005160:	5dc080e7          	jalr	1500(ra) # 80003738 <mycpu>
    80005164:	0014f493          	andi	s1,s1,1
    80005168:	06952e23          	sw	s1,124(a0)
    8000516c:	fc5ff06f          	j	80005130 <push_on+0x34>

0000000080005170 <pop_on>:
    80005170:	ff010113          	addi	sp,sp,-16
    80005174:	00813023          	sd	s0,0(sp)
    80005178:	00113423          	sd	ra,8(sp)
    8000517c:	01010413          	addi	s0,sp,16
    80005180:	ffffe097          	auipc	ra,0xffffe
    80005184:	5b8080e7          	jalr	1464(ra) # 80003738 <mycpu>
    80005188:	100027f3          	csrr	a5,sstatus
    8000518c:	0027f793          	andi	a5,a5,2
    80005190:	04078463          	beqz	a5,800051d8 <pop_on+0x68>
    80005194:	07852783          	lw	a5,120(a0)
    80005198:	02f05863          	blez	a5,800051c8 <pop_on+0x58>
    8000519c:	fff7879b          	addiw	a5,a5,-1
    800051a0:	06f52c23          	sw	a5,120(a0)
    800051a4:	07853783          	ld	a5,120(a0)
    800051a8:	00079863          	bnez	a5,800051b8 <pop_on+0x48>
    800051ac:	100027f3          	csrr	a5,sstatus
    800051b0:	ffd7f793          	andi	a5,a5,-3
    800051b4:	10079073          	csrw	sstatus,a5
    800051b8:	00813083          	ld	ra,8(sp)
    800051bc:	00013403          	ld	s0,0(sp)
    800051c0:	01010113          	addi	sp,sp,16
    800051c4:	00008067          	ret
    800051c8:	00001517          	auipc	a0,0x1
    800051cc:	0e050513          	addi	a0,a0,224 # 800062a8 <digits+0x70>
    800051d0:	fffff097          	auipc	ra,0xfffff
    800051d4:	f2c080e7          	jalr	-212(ra) # 800040fc <panic>
    800051d8:	00001517          	auipc	a0,0x1
    800051dc:	0b050513          	addi	a0,a0,176 # 80006288 <digits+0x50>
    800051e0:	fffff097          	auipc	ra,0xfffff
    800051e4:	f1c080e7          	jalr	-228(ra) # 800040fc <panic>

00000000800051e8 <__memset>:
    800051e8:	ff010113          	addi	sp,sp,-16
    800051ec:	00813423          	sd	s0,8(sp)
    800051f0:	01010413          	addi	s0,sp,16
    800051f4:	1a060e63          	beqz	a2,800053b0 <__memset+0x1c8>
    800051f8:	40a007b3          	neg	a5,a0
    800051fc:	0077f793          	andi	a5,a5,7
    80005200:	00778693          	addi	a3,a5,7
    80005204:	00b00813          	li	a6,11
    80005208:	0ff5f593          	andi	a1,a1,255
    8000520c:	fff6071b          	addiw	a4,a2,-1
    80005210:	1b06e663          	bltu	a3,a6,800053bc <__memset+0x1d4>
    80005214:	1cd76463          	bltu	a4,a3,800053dc <__memset+0x1f4>
    80005218:	1a078e63          	beqz	a5,800053d4 <__memset+0x1ec>
    8000521c:	00b50023          	sb	a1,0(a0)
    80005220:	00100713          	li	a4,1
    80005224:	1ae78463          	beq	a5,a4,800053cc <__memset+0x1e4>
    80005228:	00b500a3          	sb	a1,1(a0)
    8000522c:	00200713          	li	a4,2
    80005230:	1ae78a63          	beq	a5,a4,800053e4 <__memset+0x1fc>
    80005234:	00b50123          	sb	a1,2(a0)
    80005238:	00300713          	li	a4,3
    8000523c:	18e78463          	beq	a5,a4,800053c4 <__memset+0x1dc>
    80005240:	00b501a3          	sb	a1,3(a0)
    80005244:	00400713          	li	a4,4
    80005248:	1ae78263          	beq	a5,a4,800053ec <__memset+0x204>
    8000524c:	00b50223          	sb	a1,4(a0)
    80005250:	00500713          	li	a4,5
    80005254:	1ae78063          	beq	a5,a4,800053f4 <__memset+0x20c>
    80005258:	00b502a3          	sb	a1,5(a0)
    8000525c:	00700713          	li	a4,7
    80005260:	18e79e63          	bne	a5,a4,800053fc <__memset+0x214>
    80005264:	00b50323          	sb	a1,6(a0)
    80005268:	00700e93          	li	t4,7
    8000526c:	00859713          	slli	a4,a1,0x8
    80005270:	00e5e733          	or	a4,a1,a4
    80005274:	01059e13          	slli	t3,a1,0x10
    80005278:	01c76e33          	or	t3,a4,t3
    8000527c:	01859313          	slli	t1,a1,0x18
    80005280:	006e6333          	or	t1,t3,t1
    80005284:	02059893          	slli	a7,a1,0x20
    80005288:	40f60e3b          	subw	t3,a2,a5
    8000528c:	011368b3          	or	a7,t1,a7
    80005290:	02859813          	slli	a6,a1,0x28
    80005294:	0108e833          	or	a6,a7,a6
    80005298:	03059693          	slli	a3,a1,0x30
    8000529c:	003e589b          	srliw	a7,t3,0x3
    800052a0:	00d866b3          	or	a3,a6,a3
    800052a4:	03859713          	slli	a4,a1,0x38
    800052a8:	00389813          	slli	a6,a7,0x3
    800052ac:	00f507b3          	add	a5,a0,a5
    800052b0:	00e6e733          	or	a4,a3,a4
    800052b4:	000e089b          	sext.w	a7,t3
    800052b8:	00f806b3          	add	a3,a6,a5
    800052bc:	00e7b023          	sd	a4,0(a5)
    800052c0:	00878793          	addi	a5,a5,8
    800052c4:	fed79ce3          	bne	a5,a3,800052bc <__memset+0xd4>
    800052c8:	ff8e7793          	andi	a5,t3,-8
    800052cc:	0007871b          	sext.w	a4,a5
    800052d0:	01d787bb          	addw	a5,a5,t4
    800052d4:	0ce88e63          	beq	a7,a4,800053b0 <__memset+0x1c8>
    800052d8:	00f50733          	add	a4,a0,a5
    800052dc:	00b70023          	sb	a1,0(a4)
    800052e0:	0017871b          	addiw	a4,a5,1
    800052e4:	0cc77663          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    800052e8:	00e50733          	add	a4,a0,a4
    800052ec:	00b70023          	sb	a1,0(a4)
    800052f0:	0027871b          	addiw	a4,a5,2
    800052f4:	0ac77e63          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    800052f8:	00e50733          	add	a4,a0,a4
    800052fc:	00b70023          	sb	a1,0(a4)
    80005300:	0037871b          	addiw	a4,a5,3
    80005304:	0ac77663          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005308:	00e50733          	add	a4,a0,a4
    8000530c:	00b70023          	sb	a1,0(a4)
    80005310:	0047871b          	addiw	a4,a5,4
    80005314:	08c77e63          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005318:	00e50733          	add	a4,a0,a4
    8000531c:	00b70023          	sb	a1,0(a4)
    80005320:	0057871b          	addiw	a4,a5,5
    80005324:	08c77663          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005328:	00e50733          	add	a4,a0,a4
    8000532c:	00b70023          	sb	a1,0(a4)
    80005330:	0067871b          	addiw	a4,a5,6
    80005334:	06c77e63          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005338:	00e50733          	add	a4,a0,a4
    8000533c:	00b70023          	sb	a1,0(a4)
    80005340:	0077871b          	addiw	a4,a5,7
    80005344:	06c77663          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005348:	00e50733          	add	a4,a0,a4
    8000534c:	00b70023          	sb	a1,0(a4)
    80005350:	0087871b          	addiw	a4,a5,8
    80005354:	04c77e63          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005358:	00e50733          	add	a4,a0,a4
    8000535c:	00b70023          	sb	a1,0(a4)
    80005360:	0097871b          	addiw	a4,a5,9
    80005364:	04c77663          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005368:	00e50733          	add	a4,a0,a4
    8000536c:	00b70023          	sb	a1,0(a4)
    80005370:	00a7871b          	addiw	a4,a5,10
    80005374:	02c77e63          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005378:	00e50733          	add	a4,a0,a4
    8000537c:	00b70023          	sb	a1,0(a4)
    80005380:	00b7871b          	addiw	a4,a5,11
    80005384:	02c77663          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005388:	00e50733          	add	a4,a0,a4
    8000538c:	00b70023          	sb	a1,0(a4)
    80005390:	00c7871b          	addiw	a4,a5,12
    80005394:	00c77e63          	bgeu	a4,a2,800053b0 <__memset+0x1c8>
    80005398:	00e50733          	add	a4,a0,a4
    8000539c:	00b70023          	sb	a1,0(a4)
    800053a0:	00d7879b          	addiw	a5,a5,13
    800053a4:	00c7f663          	bgeu	a5,a2,800053b0 <__memset+0x1c8>
    800053a8:	00f507b3          	add	a5,a0,a5
    800053ac:	00b78023          	sb	a1,0(a5)
    800053b0:	00813403          	ld	s0,8(sp)
    800053b4:	01010113          	addi	sp,sp,16
    800053b8:	00008067          	ret
    800053bc:	00b00693          	li	a3,11
    800053c0:	e55ff06f          	j	80005214 <__memset+0x2c>
    800053c4:	00300e93          	li	t4,3
    800053c8:	ea5ff06f          	j	8000526c <__memset+0x84>
    800053cc:	00100e93          	li	t4,1
    800053d0:	e9dff06f          	j	8000526c <__memset+0x84>
    800053d4:	00000e93          	li	t4,0
    800053d8:	e95ff06f          	j	8000526c <__memset+0x84>
    800053dc:	00000793          	li	a5,0
    800053e0:	ef9ff06f          	j	800052d8 <__memset+0xf0>
    800053e4:	00200e93          	li	t4,2
    800053e8:	e85ff06f          	j	8000526c <__memset+0x84>
    800053ec:	00400e93          	li	t4,4
    800053f0:	e7dff06f          	j	8000526c <__memset+0x84>
    800053f4:	00500e93          	li	t4,5
    800053f8:	e75ff06f          	j	8000526c <__memset+0x84>
    800053fc:	00600e93          	li	t4,6
    80005400:	e6dff06f          	j	8000526c <__memset+0x84>

0000000080005404 <__memmove>:
    80005404:	ff010113          	addi	sp,sp,-16
    80005408:	00813423          	sd	s0,8(sp)
    8000540c:	01010413          	addi	s0,sp,16
    80005410:	0e060863          	beqz	a2,80005500 <__memmove+0xfc>
    80005414:	fff6069b          	addiw	a3,a2,-1
    80005418:	0006881b          	sext.w	a6,a3
    8000541c:	0ea5e863          	bltu	a1,a0,8000550c <__memmove+0x108>
    80005420:	00758713          	addi	a4,a1,7
    80005424:	00a5e7b3          	or	a5,a1,a0
    80005428:	40a70733          	sub	a4,a4,a0
    8000542c:	0077f793          	andi	a5,a5,7
    80005430:	00f73713          	sltiu	a4,a4,15
    80005434:	00174713          	xori	a4,a4,1
    80005438:	0017b793          	seqz	a5,a5
    8000543c:	00e7f7b3          	and	a5,a5,a4
    80005440:	10078863          	beqz	a5,80005550 <__memmove+0x14c>
    80005444:	00900793          	li	a5,9
    80005448:	1107f463          	bgeu	a5,a6,80005550 <__memmove+0x14c>
    8000544c:	0036581b          	srliw	a6,a2,0x3
    80005450:	fff8081b          	addiw	a6,a6,-1
    80005454:	02081813          	slli	a6,a6,0x20
    80005458:	01d85893          	srli	a7,a6,0x1d
    8000545c:	00858813          	addi	a6,a1,8
    80005460:	00058793          	mv	a5,a1
    80005464:	00050713          	mv	a4,a0
    80005468:	01088833          	add	a6,a7,a6
    8000546c:	0007b883          	ld	a7,0(a5)
    80005470:	00878793          	addi	a5,a5,8
    80005474:	00870713          	addi	a4,a4,8
    80005478:	ff173c23          	sd	a7,-8(a4)
    8000547c:	ff0798e3          	bne	a5,a6,8000546c <__memmove+0x68>
    80005480:	ff867713          	andi	a4,a2,-8
    80005484:	02071793          	slli	a5,a4,0x20
    80005488:	0207d793          	srli	a5,a5,0x20
    8000548c:	00f585b3          	add	a1,a1,a5
    80005490:	40e686bb          	subw	a3,a3,a4
    80005494:	00f507b3          	add	a5,a0,a5
    80005498:	06e60463          	beq	a2,a4,80005500 <__memmove+0xfc>
    8000549c:	0005c703          	lbu	a4,0(a1)
    800054a0:	00e78023          	sb	a4,0(a5)
    800054a4:	04068e63          	beqz	a3,80005500 <__memmove+0xfc>
    800054a8:	0015c603          	lbu	a2,1(a1)
    800054ac:	00100713          	li	a4,1
    800054b0:	00c780a3          	sb	a2,1(a5)
    800054b4:	04e68663          	beq	a3,a4,80005500 <__memmove+0xfc>
    800054b8:	0025c603          	lbu	a2,2(a1)
    800054bc:	00200713          	li	a4,2
    800054c0:	00c78123          	sb	a2,2(a5)
    800054c4:	02e68e63          	beq	a3,a4,80005500 <__memmove+0xfc>
    800054c8:	0035c603          	lbu	a2,3(a1)
    800054cc:	00300713          	li	a4,3
    800054d0:	00c781a3          	sb	a2,3(a5)
    800054d4:	02e68663          	beq	a3,a4,80005500 <__memmove+0xfc>
    800054d8:	0045c603          	lbu	a2,4(a1)
    800054dc:	00400713          	li	a4,4
    800054e0:	00c78223          	sb	a2,4(a5)
    800054e4:	00e68e63          	beq	a3,a4,80005500 <__memmove+0xfc>
    800054e8:	0055c603          	lbu	a2,5(a1)
    800054ec:	00500713          	li	a4,5
    800054f0:	00c782a3          	sb	a2,5(a5)
    800054f4:	00e68663          	beq	a3,a4,80005500 <__memmove+0xfc>
    800054f8:	0065c703          	lbu	a4,6(a1)
    800054fc:	00e78323          	sb	a4,6(a5)
    80005500:	00813403          	ld	s0,8(sp)
    80005504:	01010113          	addi	sp,sp,16
    80005508:	00008067          	ret
    8000550c:	02061713          	slli	a4,a2,0x20
    80005510:	02075713          	srli	a4,a4,0x20
    80005514:	00e587b3          	add	a5,a1,a4
    80005518:	f0f574e3          	bgeu	a0,a5,80005420 <__memmove+0x1c>
    8000551c:	02069613          	slli	a2,a3,0x20
    80005520:	02065613          	srli	a2,a2,0x20
    80005524:	fff64613          	not	a2,a2
    80005528:	00e50733          	add	a4,a0,a4
    8000552c:	00c78633          	add	a2,a5,a2
    80005530:	fff7c683          	lbu	a3,-1(a5)
    80005534:	fff78793          	addi	a5,a5,-1
    80005538:	fff70713          	addi	a4,a4,-1
    8000553c:	00d70023          	sb	a3,0(a4)
    80005540:	fec798e3          	bne	a5,a2,80005530 <__memmove+0x12c>
    80005544:	00813403          	ld	s0,8(sp)
    80005548:	01010113          	addi	sp,sp,16
    8000554c:	00008067          	ret
    80005550:	02069713          	slli	a4,a3,0x20
    80005554:	02075713          	srli	a4,a4,0x20
    80005558:	00170713          	addi	a4,a4,1
    8000555c:	00e50733          	add	a4,a0,a4
    80005560:	00050793          	mv	a5,a0
    80005564:	0005c683          	lbu	a3,0(a1)
    80005568:	00178793          	addi	a5,a5,1
    8000556c:	00158593          	addi	a1,a1,1
    80005570:	fed78fa3          	sb	a3,-1(a5)
    80005574:	fee798e3          	bne	a5,a4,80005564 <__memmove+0x160>
    80005578:	f89ff06f          	j	80005500 <__memmove+0xfc>

000000008000557c <__putc>:
    8000557c:	fe010113          	addi	sp,sp,-32
    80005580:	00813823          	sd	s0,16(sp)
    80005584:	00113c23          	sd	ra,24(sp)
    80005588:	02010413          	addi	s0,sp,32
    8000558c:	00050793          	mv	a5,a0
    80005590:	fef40593          	addi	a1,s0,-17
    80005594:	00100613          	li	a2,1
    80005598:	00000513          	li	a0,0
    8000559c:	fef407a3          	sb	a5,-17(s0)
    800055a0:	fffff097          	auipc	ra,0xfffff
    800055a4:	b3c080e7          	jalr	-1220(ra) # 800040dc <console_write>
    800055a8:	01813083          	ld	ra,24(sp)
    800055ac:	01013403          	ld	s0,16(sp)
    800055b0:	02010113          	addi	sp,sp,32
    800055b4:	00008067          	ret

00000000800055b8 <__getc>:
    800055b8:	fe010113          	addi	sp,sp,-32
    800055bc:	00813823          	sd	s0,16(sp)
    800055c0:	00113c23          	sd	ra,24(sp)
    800055c4:	02010413          	addi	s0,sp,32
    800055c8:	fe840593          	addi	a1,s0,-24
    800055cc:	00100613          	li	a2,1
    800055d0:	00000513          	li	a0,0
    800055d4:	fffff097          	auipc	ra,0xfffff
    800055d8:	ae8080e7          	jalr	-1304(ra) # 800040bc <console_read>
    800055dc:	fe844503          	lbu	a0,-24(s0)
    800055e0:	01813083          	ld	ra,24(sp)
    800055e4:	01013403          	ld	s0,16(sp)
    800055e8:	02010113          	addi	sp,sp,32
    800055ec:	00008067          	ret

00000000800055f0 <console_handler>:
    800055f0:	fe010113          	addi	sp,sp,-32
    800055f4:	00813823          	sd	s0,16(sp)
    800055f8:	00113c23          	sd	ra,24(sp)
    800055fc:	00913423          	sd	s1,8(sp)
    80005600:	02010413          	addi	s0,sp,32
    80005604:	14202773          	csrr	a4,scause
    80005608:	100027f3          	csrr	a5,sstatus
    8000560c:	0027f793          	andi	a5,a5,2
    80005610:	06079e63          	bnez	a5,8000568c <console_handler+0x9c>
    80005614:	00074c63          	bltz	a4,8000562c <console_handler+0x3c>
    80005618:	01813083          	ld	ra,24(sp)
    8000561c:	01013403          	ld	s0,16(sp)
    80005620:	00813483          	ld	s1,8(sp)
    80005624:	02010113          	addi	sp,sp,32
    80005628:	00008067          	ret
    8000562c:	0ff77713          	andi	a4,a4,255
    80005630:	00900793          	li	a5,9
    80005634:	fef712e3          	bne	a4,a5,80005618 <console_handler+0x28>
    80005638:	ffffe097          	auipc	ra,0xffffe
    8000563c:	6dc080e7          	jalr	1756(ra) # 80003d14 <plic_claim>
    80005640:	00a00793          	li	a5,10
    80005644:	00050493          	mv	s1,a0
    80005648:	02f50c63          	beq	a0,a5,80005680 <console_handler+0x90>
    8000564c:	fc0506e3          	beqz	a0,80005618 <console_handler+0x28>
    80005650:	00050593          	mv	a1,a0
    80005654:	00001517          	auipc	a0,0x1
    80005658:	b5c50513          	addi	a0,a0,-1188 # 800061b0 <CONSOLE_STATUS+0x1a0>
    8000565c:	fffff097          	auipc	ra,0xfffff
    80005660:	afc080e7          	jalr	-1284(ra) # 80004158 <__printf>
    80005664:	01013403          	ld	s0,16(sp)
    80005668:	01813083          	ld	ra,24(sp)
    8000566c:	00048513          	mv	a0,s1
    80005670:	00813483          	ld	s1,8(sp)
    80005674:	02010113          	addi	sp,sp,32
    80005678:	ffffe317          	auipc	t1,0xffffe
    8000567c:	6d430067          	jr	1748(t1) # 80003d4c <plic_complete>
    80005680:	fffff097          	auipc	ra,0xfffff
    80005684:	3e0080e7          	jalr	992(ra) # 80004a60 <uartintr>
    80005688:	fddff06f          	j	80005664 <console_handler+0x74>
    8000568c:	00001517          	auipc	a0,0x1
    80005690:	c2450513          	addi	a0,a0,-988 # 800062b0 <digits+0x78>
    80005694:	fffff097          	auipc	ra,0xfffff
    80005698:	a68080e7          	jalr	-1432(ra) # 800040fc <panic>
	...
