# Assembly
<!--ts-->
<!--te-->

## Cheatsheet

```assembly
    ; x86 Assembly Language

section .data
	hello:     db 'Hello, World!',10    ; 'Hello, World!' plus a linefeed character
	helloLen:  equ $-hello             ; Length of the 'Hello world!' string

section .text
	global _start

; syscalls 1-6: htt ps://www.tutori alspoint.com/assembly_programming/assembly_system_calls.htm

_start:
; --- Alter the contents of a string at runtime ---
  mov [hello], byte "Y"   ; Move a character to the beginning of the string
  mov [hello+5], byte "w" ; Move a character to the offset index of the string

; --- Console output ---
	mov eax,4            ; The system call for write (sys_write)
	mov ebx,1            ; File descriptor 1 - standard output
	mov ecx,hello        ; Put the offset of hello in ecx
	mov edx,helloLen     ; helloLen is a constant, so we don't need to say
	                     ;  mov edx,[helloLen] to get it's actual value
	int 80h              ; Call the kernel
	
; --- arithmetic ---
	mov ebx, 123  ; ebx = 123
  mov eax, ebx  ; eax = ebx
	add eax, ecx  ; ebx += ecx
	sub ebx, edx  ; ebx -= edx
	mul ebx       ; eax *= ebx, always applies to the eax register
;	div edx       ; eax /= edx, always applies to the eax register
  dec ecx       ; ecx -= 1

; --- conditionals ---
  ; unconditional jump
  jmp skip1  ; jump to "skip1" label
  ; ...
skip1:       ; skip1 label

  ; conditional jump
  mov ecx, 99   ; set ecx to 99
  cmp ecx, 100  ; compare ecx to 100
  jl skip2      ; jump to "skip2" label if less than
  ; ...
skip2:       ; skip1 label

  ; list of conditional jumps
  ;  je A, B   ; Jump if Equal
  ;  jne A, B  ; Jump if Not Equal
  ;  jg A, B   ; Jump if Greater
  ;  jge A, B  ; Jump if Greater or Equal
  ;  jl A, B   ; Jump if Less
  ;  jle A, B  ; Jump if Less or Equal

; loop
  mov ecx, 4    ; iteration count
loopstart:
  dec ecx       ; ecx -= 1
  cmp ecx, 0    ; compare ecx to 0
  jg loopstart  ; jump to label loopstart if greater

; --- functions ----
  call func   ; function call

; --- write a string to the stack ---
  mov ebp, esp  ; save the currect value of the stack pointer into the base pointer so we can restore it later
  sub esp, 4 ; allocate 4 bytes on the stack by moving the stack pointer
;  mov [esp], byte "H"
;  mov [esp+1], byte "e"
;  mov [esp+2], byte "y"
;  mov [esp+3], byte "!"

  ; Console output
	mov eax,4
	mov ebx,1
	mov ecx, esp
	mov edx, 4
	int 80h
	
	mov esp, ebp  ; restore the stack pointer to the value it had before we stared manipulating the stack, effectively deallocating the same 4 bytes

; --- exit program ---
	mov eax,1            ; The system call for exit (sys_exit)
	mov ebx,0            ; Exit with return "code" of 0 (no error)
	int 80h;

func:         ; function definition 
  mov eax,4
	mov ebx,1
	mov ecx,hello
	mov edx,helloLen
	int 80h
	ret
```
