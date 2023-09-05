  ;
  ; Sieve of Eratosthenes, for generating prime numbers
  ;
  org 0x0100

table:      equ 0x8000
table_size: equ 10000

start:
  mov bx, table
  mov cx, table_size
  mov al, 0
                                                                               ; Eratosthenes Sieve algorithm:
p1:                                                                            ; 1. Start With 2
  mov [bx], al      ; Write AL into the address pointed by BX                  ; 2. Is this number marked non-prime? Go to step 5.
  inc bx            ; Increase BX                                              ; 3. If So, show it as prime.
  loop p1           ; Decrease CX, jump if non-zero                            ; 4. Mark all multiples as non-prime.
  mov ax, 2         ; Start at number 2                                        ; 5. Increment current number.
p2:                                                                            ; 6. If we havent reached the limit, go to step 2.
  mov bx, table   ; BX = table address
  add bx, ax      ; BX = BX + AX
  cmp byte [bx], 0    ; Is it prime?
  jne p3
  push ax
  call display_number
  mov al, 0x2c        ; Comma
  call display_letter
  pop ax
  mov bx, table
  add bx, ax
p4:
  add bx, ax
  cmp bx, table+table_size
  jnc p3
  mov byte [bx], 1
  jmp p4
p3:
  inc ax
  cmp ax, table_size
  jne p2

  int 0x20        ; Exit to command-line.

  ; Display letter contained in AL (ASCII code)
display_letter:
  push ax
  push bx
  push cx
  push dx
  push si
  push di
  mov ah, 0x0e    ; Load AH with code for terminal output
  mov bx, 0x000f  ; Load BH page zero and BL color (graphic mode)
  int 0x10        ; Call the BIOS for displaying one letter
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  ret             ; Returns to caller

  ; Read keyboard into AL (Ascii code)
read_keyboard:
  push bx
  push cx
  push dx
  push si
  push di
  mov ah, 0x00    ; Load AH with code for keyboard read
  int 0x16        ; Call the BIOS for reading keyboard
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  ret             ; Returns to caller

  ;
  ; Display the value of AX as a decimal number
  ;
display_number:
  mov dx, 0           ; Makes DX = 0
  mov cx, 10          ; Makes CX = 10
  div cx              ; AX = DX:AX / CX
  push dx
  cmp ax, 0           ; If AX is zero...
  je display_number_1 ; ...jump
  call display_number ; else calls itself
display_number_1:
  pop ax              
  add al, '0'         ; Convert remainder to ASCII digit
  call display_letter ; Display on screen.
  ret
