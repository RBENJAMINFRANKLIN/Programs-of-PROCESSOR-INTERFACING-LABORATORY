DISP MACRO MSG ; macro to display string on console
mov ah,09h
lea dx,msg
int 21h
ENDM ; macro ends
EXTRN INPUTSTR1:BYTE,INPUTSTR2:BYTE ; using memory array from prog4 module
PUBLIC COMPARE_PROC,CONCAT_PROC ; declaring scope of procedures public
.model small ; selecting type of memory module
.data
MSGCON db 10,13,"CONACTED STRING IS $"
MSGCOM db 10,13,"STRINGS ARE EQUAL $"
MSGCOMN db 10,13,"STRINGS ARE NOT EQUAL $"
inputstr3 db 50 dup ('$')
.code
mov ax,@data ; initialising data segment
mov ds,ax
mov es,ax

PROC COMPARE_PROC FAR ; compare procedure definition
xor cx,cx ; resetting cx to 0
lea si,inputstr1+1 ; si pointing to str1[1]
lea di,inputstr2+1 ; di pointing to str2[1]
mov cl,byte ptr [si]
CLD
back2:
CMPSB
JNE NOTEQUAL
loop back2
disp msgcom
jmp exit1
notequal: disp msgcomn
exit1: RET
ENDP ; compare procedure ends

PROC CONCAT_PROC FAR ; concate procedure definition
xor cx,cx
lea si,inputstr1+1
lea di,inputstr3
mov cl,byte ptr [si]
inc si
CLD
REP MOVSB
xor cx,cx
lea si,inputstr2+1
mov cl,byte ptr [si]
inc si
CLD
REP MOVSB
disp msgcon
lea si,inputstr1+1
mov cl,byte ptr [si]
lea si,inputstr2+1
mov ch,byte ptr [si]
add cl,ch
xor ch,ch
lea di,inputstr3
back4:mov ah,02
mov dl,[di]
int 21h
inc di
loop back4
RET
ENDP ; concatenation ends

EXIT:
mov ah,4ch
int 21h
end