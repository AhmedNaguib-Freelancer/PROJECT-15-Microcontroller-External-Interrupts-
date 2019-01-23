
_init_interrupt:

;INTERRUBT.c,1 :: 		void init_interrupt(){
;INTERRUBT.c,2 :: 		option_reg.intedg=0;
	BCF        OPTION_REG+0, 6
;INTERRUBT.c,3 :: 		intcon.inte=1;
	BSF        INTCON+0, 4
;INTERRUBT.c,4 :: 		intcon.PEIE=1;
	BSF        INTCON+0, 6
;INTERRUBT.c,5 :: 		intcon.gie=1;
	BSF        INTCON+0, 7
;INTERRUBT.c,6 :: 		}
L_end_init_interrupt:
	RETURN
; end of _init_interrupt

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;INTERRUBT.c,7 :: 		void interrupt(){
;INTERRUBT.c,8 :: 		if (intcon.intf==1)
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;INTERRUBT.c,10 :: 		PORTD.F0=~PORTD.F0;
	MOVLW      1
	XORWF      PORTD+0, 1
;INTERRUBT.c,11 :: 		intcon.intf=0;
	BCF        INTCON+0, 1
;INTERRUBT.c,12 :: 		}
L_interrupt0:
;INTERRUBT.c,13 :: 		}
L_end_interrupt:
L__interrupt5:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;INTERRUBT.c,15 :: 		void main(){
;INTERRUBT.c,16 :: 		init_interrupt();
	CALL       _init_interrupt+0
;INTERRUBT.c,17 :: 		TRISB.F0=1;
	BSF        TRISB+0, 0
;INTERRUBT.c,18 :: 		TRISD.F0=0;
	BCF        TRISD+0, 0
;INTERRUBT.c,19 :: 		PORTD.F0=0;
	BCF        PORTD+0, 0
;INTERRUBT.c,20 :: 		while (1)
L_main1:
;INTERRUBT.c,22 :: 		asm sleep;
	SLEEP
;INTERRUBT.c,23 :: 		}
	GOTO       L_main1
;INTERRUBT.c,24 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
