DISP MACRO MSG ; macro to display string on console
mov ah,09h
lea dx,msg
int 21h
ENDM ; macro ends
.model small ; selecting type of memory module
.data
sinput db 10,13,"Enter a string: $"
MSGLEN db 10,13,"Length of string: $"
MSGREV db 10,13,"Reverse of string: $"
MSGPALN db 10,13,"String is not Palindrom $"
MSGPAL db 10,13,"String is Palindrom $"
bhd db 10,13,"String is Palindrom $"
menu1 db 10,13,"====MENU====",10,13,"1:REVERSE ",10,13,"2:LENGTH ",10,13,"3:Palindrom ",10,13,"4:EXIT $"
menu2 db 10,13,"Enter your choice : $"
inputstr db 25,?,25 dup('$')
.code
mov ax,@data ; initialising data segment
mov ds,ax
menu: ; displaying menu
disp menu1
disp menu2
mov ah,01h ; accepting user input
int 21h
cmp al,31h ; if choice == 1, jump to reverse procedure
JE REVERSE1
cmp al,32h ; if choice == 2, jump to length procedure
JE LENGTH1
cmp al,33h ; if choice == 3, jump to palindrome procedure
JE PALINDROM
JMP EXIT ; else exit
REVERSE1:CALL REVERSE_PROC ; calling reverse near procedure
JMP menu
LENGTH1:CALL LENGTH_PROC ; calling length near procedure
JMP menu
PALINDROM:CALL PALINDROM_PROC ; calling palindrome near procedure
JMP menu
PROC REVERSE_PROC ; reverse procedure starts
disp sinput
mov ah,0Ah
lea dx,inputstr
int 21h
disp msgrev
xor cx,cx
lea si,inputstr+1
mov cl,byte ptr [si]
add si,cx
back2:
mov dl,[si]
mov ah,02h
int 21h
dec si
loop back2
RET
ENDP ; ends
PROC LENGTH_PROC ; length procedure starts
disp sinput
mov ah,0Ah
lea dx,inputstr
int 21h
disp msglen
xor cx,cx
lea si,inputstr+1
mov bl,byte ptr [si]
mov cl,02
back3: rol bl,04
mov dl,bl
and dl,0fh
cmp dl,09h
jbe add30
add dl,07
add30:add dl,30h
mov ah,02
int 21h
loop back3
RET
ENDP ; ends
proc PALINDROM_PROC ; palindrome procedure starts
disp sinput
mov ah,0Ah
lea dx,inputstr
int 21h
xor cx,cx
lea si,inputstr+1
lea di,inputstr+1
mov cl,byte ptr [si]
add di,cx
inc si
back4: mov al,[di]
cmp al,[si]
jne notpal
inc si
dec di
loop back4
disp msgpal
jmp exit1
notpal: disp msgpaln
EXIT1:RET
ENDP ; ends
EXIT:
mov ah,4ch
int 21h
end