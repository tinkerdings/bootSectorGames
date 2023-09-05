  ;
  ; Tic-Tac-Toe
  ;
  org 0x0100

board: equ 0x0300

; Initializes board with numbers
start:
  mov bx, board ; Put address of game board in BX
  mov cx, 9 ; Count 9 squares
  mov al, '1' ; Setup AL to contain 0x31 (ASCII code for 1)
b09:
  mov [bx], al ; Save it into the square (one byte)
  inc al ; Increase AL, this gives us next digit
  inc bx ; Increase index into board memory
  loop b09 ; Decrement CX, jump if non-zero

b10:
  call show_board
  call find_line
  call get_move ; Get move
  mov byte [bx], 'X' ; Put X into square
  
  call show_board ; Show board
  call find_line

  call get_move ; Get move
  mov byte [bx], 'O' ; Put O into square

  jmp b10

get_move:
  call read_keyboard
  cmp al, 0x1b ; Esc key pressed?
  je do_exit ; Exit
  sub al, 0x31 ; Subtract code for ASCII digit 1
  jc get_move ; Is it less than? wait for another key
  cmp al, 0x09 ; Comparison with 9
  jnc get_move ; Is it greater than or equal to? Wait
  cbw ; Expand AL to 16 bits using AH.
  mov bx, board ; BX points to board.
  add bx, ax ; Add the key entered
  mov al, [bx] ; Get square content
  cmp al, 0x40 ; Comparison with 0x40
  jnc get_move ; Is it greater than or equal to? Wait
  call show_crlf ; Line change
  ret ; Return, now BX points to square

do_exit:
  int 0x20 ; Exit to command-line

show_board:
  mov bx, board
  call show_row
  call show_div
  mov bx, board + 3
  call show_row
  call show_div
  mov bx, board + 6
  jmp show_row

show_row:
  call show_square
  mov al, 0xb3
  call display_letter
  call show_square
  mov al, 0xb3
  call display_letter
  call show_square
show_crlf:
  mov al, 0x0d
  call display_letter
  mov al, 0x0a
  jmp display_letter

show_div:
  mov al, 0xc4
  call display_letter
  mov al, 0xc5
  call display_letter
  mov al, 0xc4
  call display_letter
  mov al, 0xc5
  call display_letter
  mov al, 0xc4
  call display_letter
  jmp show_crlf

show_square:
  mov al, [bx]
  inc bx
  jmp display_letter

find_line:
  ; First horizontal row
  mov al, [board] ; X.. ... ...
  cmp al, [board+1] ; .x. ... ...
  jne b01
  cmp al, [board+2] ; ..x ... ...
  je won
b01:
  ; Leftmost vertical row
  cmp al, [board+3] ; ... x.. ..
  jne b04
  cmp al, [board+6]; ... ... x..
  je won
b04:
  ; First diagonal
  cmp al, [board+4] ; ... .X. ...
  jne b05
  cmp al, [board+8] ; ... ... ..X
  je won
b05:
  ; Second horizontal row
  mov al, [board+3] ; ... x.. ...
  cmp al, [board+4] ; ... .x. ...
  jne b02
  cmp al, [board+5] ; ... ..x ...
  je won
b02:
  ; Third horizontal row
  mov al, [board+6] ; ... ... X..
  cmp al, [board+7] ; ... ... .x.
  jne b03
  cmp al, [board+8] ; ... ... ..x
  je won
b03:
  ; Middle vertical row
  mov al, [board+1] ; .x. ... ...
  cmp al, [board+4] ; ... .x. ...
  jne b06
  cmp al, [board+7]
  je won
b06:
 ; Rightmost vertical row
 mov al, [board+2] ; ..x ... ...
 cmp al, [board+5] ; ... ..x ...
 jne b07
 cmp al, [board+8] ; ... ... ..x
 je won
b07:
  ; Second diagonal
  cmp al, [board+4] ; ... .x. ...
  jne b08
  cmp al, [board+6] ; ... ... x..
  je won
b08:
  ret

won:
; At this point AL contains the letter which made the line
call display_letter
mov al, 0x20 ; space
call display_letter
mov al, 0x77 ; w
call display_letter
mov al, 0x69 ; i
call display_letter
mov al, 0x6e ; n
call display_letter
mov al, 0x73
call display_letter

int 0x20

;------------------------------------------
; ---------- LIBRARY 1 --------------------
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
















