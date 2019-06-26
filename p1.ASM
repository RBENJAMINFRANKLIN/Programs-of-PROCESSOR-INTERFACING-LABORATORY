input macro
        mov ah,01h
        int 21h
endm
output macro
        mov ah,02h
        int 21h
endm
disp macro var
        lea dx,var
        mov ah,09h
        int 21h
endm
.model small
.stack 100h
.data
        m1 db 10,13,09, "How many numbers you want add? $"
        m2 db 10,13,09,"Enter the numbers :- $"
        m3 db 10,13,09, "The addition is :- $"
        array db 5 dup (0)
        count db 0
        m4 db 10,13,"$"

.code
        mov ax,@data
        mov ds,ax

        lea si,array
        disp m1
        input
        sub al,30h

        mov count,al
        mov cl,count
        disp m4

       s1: disp m2
          input
          mov [si],al
          inc si
          loop s1

          disp m4
          disp m3

          xor ax,ax
          mov cl,count

          lea si,array

          ; Addition Logic
           s2: add al,[si]
               sub al,30h
               inc si
               loop s2
        ;  logic to display the result
               mov ch,02
               mov cl,04
              mov bl,al

              s3: rol bl,cl
                  mov dl,bl
                  and dl,0fH
                  cmp dl,09
                  jbe s4
                  add dl,07

               s4 : add dl,30h
               output
               dec ch
               jnz s3

               mov ah,04h
               int 21h
end


