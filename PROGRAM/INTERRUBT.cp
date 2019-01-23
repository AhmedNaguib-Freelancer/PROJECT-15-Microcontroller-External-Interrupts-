#line 1 "C:/Users/only try/Desktop/PROJECT 15 Microcontroller (External Interrupts)/PROGRAM/INTERRUBT.c"
void init_interrupt(){
 option_reg.intedg=0;
 intcon.inte=1;
 intcon.PEIE=1;
 intcon.gie=1;
}
void interrupt(){
 if (intcon.intf==1)
 {
 PORTD.F0=~PORTD.F0;
 intcon.intf=0;
 }
}

void main(){
 init_interrupt();
 TRISB.F0=1;
 TRISD.F0=0;
 PORTD.F0=0;
 while (1)
 {
 asm sleep;
 }
}
