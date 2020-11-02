;
; Модуль main.asm.
;
; Работа с большими числами
;
; Студенты МК-301, начало работы 21:00 02.11.2020
;

.686
.model flat, stdcall
option casemap:none

include c:\masm32\include\msvcrt.inc
include c:\masm32\include\kernel32.inc
include c:\masm32\include\user32.inc

include Strings.mac

big_number struct
	len dd ? : DWORD ; count blocks (1 block = 1 DD)
	number_ptr dd ? : ptr byte
	number_sign db ? : byte
big_number ends


.data


.data?

.const
format db "%s - %d", 13, 10, 0

.code

str_len proc c uses edi ecx pstr:ptr dword
	cld
	mov edi, pstr
	mov ecx, 0FFFFFFFFh
	mov al,0
	repne scasb
	mov eax, 0FFFFFFFFh - 1
	sub eax, ecx	;	(0FFFFFFFFh - 1) - (0FFFFFFFFh - (strlen + 1)) = strlen
	ret
str_len endp

main proc c argc:DWORD, argv:ptr byte, enpv:ptr byte
	local number1:ptr byte
	local number2:ptr byte
	local op:DWORD
	mov ebx, [argv]
	
	add ebx, 4
	mov eax, [ebx]
	mov [number1], eax

	add ebx, 4
	mov eax, [ebx]
	mov ecx, [eax]
	mov [op], ecx
	
	add ebx, 4
	mov eax, [ebx]
	mov [number2], eax
	
	invoke str_len, [number1]
	invoke crt_printf, $CTA0("Number  1: %s (%d)\n"), [number1], eax
	invoke crt_printf, $CTA0("Operation: %c\n"), [op]
	invoke str_len, [number2]
	invoke crt_printf, $CTA0("Number  2: %s (%d)\n"), [number2], eax

	xor eax, eax
	ret

main endp


end
