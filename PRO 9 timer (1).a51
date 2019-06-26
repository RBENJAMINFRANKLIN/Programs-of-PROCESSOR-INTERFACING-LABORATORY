; timer program without interrupt
ORG 00H
MOV TMOD,#10H
AGAIN: MOV TL1,#1AH
	   MOV TH1,	#0FFH
	   SETB TR1
	   BACK: JNB TF1,BACK
	   CLR TR1
	   CPL P1.0
	   CLR TF1
	   SJMP AGAIN
END