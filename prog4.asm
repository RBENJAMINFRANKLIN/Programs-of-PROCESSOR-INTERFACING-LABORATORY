DISP MACRO MSG ; macro for displaying string to console
mov ah,09h
lea dx,msg
int 21h
ENDM ; macro ends
public inputstr1,inputstr2 ; declaring scope as public
extrn concat_proc:far,compare_proc:far ; linking procedures from other module
.model small ; selecting a memory module
.data
SINPUT1 db 10,13,"ENTER A STRING1: $"
SINPUT2 DB 10,13,"ENTER A STRING2: $"
menu1 db 10,13,"====MENU====",10,13,"1:CONCATION ",10,13,"2:COMPARE ",10,13,"3:EXIT $"
menu2 db 10,13,"Enter your choice $"
inputstr1 db 25,?,25 dup('$')
inputstr2 db 25,?,25 dup('$')
inputstr3 db 50 dup ('$')
.code
mov ax,@data ; initialising data segment
mov ds,ax
mov es,ax
disp sinput1 ; accepting string1
mov ah,0Ah
mov dx,offset inputstr1
int 21h
disp sinput2 ; accepting string2
mov ah,0Ah
mov dx,offset inputstr2
int 21h
menu:
disp menu1 ; displaying menu
disp menu2
mov ah,01h ; accepting choice from user
int 21h
cmp al,31h ; if choice == 1 jump to concatenation
JE concat1
cmp al,32h ; if choice == 2 jump to compare
JE compare1
JMP EXIT ; else exit
concat1:CALL concat_proc ; calling concat procedure from string4 module
JMP menu
compare1:CALL compare_proc ; calling compare procedure from string4 module
JMP menu
EXIT:
mov ah,4ch
int 21h
end