; timer program with (ISR )interrupt

org 000H
ljmp main
org 001BH
cpl p1.0
RETI
MAIN : CLR P1.0
 MOV TMOD,#10H
 MOV TL1,#1AH
 MOV TH1,#0FFH
 MOV IE,#88H 
 SETB TR1
 HERE: SJMP HERE
 END 
