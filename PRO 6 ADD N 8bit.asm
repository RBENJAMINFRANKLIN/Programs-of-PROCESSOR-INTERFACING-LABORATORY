;program to add n 8 bit numbers
MOV R0,#40H ; DATA STARTS FROM RAM LOCATION 40H
MOV R1,#0AH ; NUMBERS TO BE ADDED
MOV R6,#00H ; STORES MSB OF ADDITION
MOV R7,#00H ; STORES LSB OF ADDITION
MOV A,#00H ; ACCUMULATOR
UP: ADD A,@R0 ; ADD NUMBER FROM RAM
MOV R7,A ; STORE RESULT IN R7
MOV A,R6
ADDC A,#00H ; ADD WITH CARRY TO R6
MOV R6,A
MOV A,R7
INC R0 ; INCREMENT MEMORY ADDRESS
DJNZ R1,UP
END