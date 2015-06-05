; Copyright (C) 2013-2015  Bryant Moscon - bmoscon@gmail.com
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to 
; deal in the Software without restriction, including without limitation the 
; rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
; sell copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; 1. Redistributions of source code must retain the above copyright notice, 
; this list of conditions, and the following disclaimer.
;
; 2. Redistributions in binary form must reproduce the above copyright notice, 
; this list of conditions and the following disclaimer in the documentation 
; and/or other materials provided with the distribution, and in the same 
; place and form as other copyright, license and disclaimer information.
;
; 3. The end-user documentation included with the redistribution, if any, must 
; include the following acknowledgment: "This product includes software 
; developed by Bryant Moscon (http://www.bryantmoscon.org/)", in the same 
; place and form as other third-party acknowledgments. Alternately, this 
; acknowledgment may appear in the software itself, in the same form and 
; location as other such third-party acknowledgments.
;
; 4. Except as contained in this notice, the name of the author, Bryant Moscon,
; shall not be used in advertising or otherwise to promote the sale, use or 
; other dealings in this Software without prior written authorization from 
; the author.
;
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
; THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
; THE SOFTWARE
	
BITS 16

start:
        mov ax, 0x100
	mov ds, ax
	mov ax, 0x200
	mov ss, ax
	xor sp, sp
	mov si, stage_2	
	call print
        hlt 
        jmp $
	;; todo
	;; * load 64bit kernel to well known address
        ;; * setup page table
        ;; * setup IDT (interrupt descriptor table)
        ;; * Setup Global Descriptor Table (GDT)
        ;; * enable long mode
        ;; * jump to 64bit kernel at well known address
        
print:
	mov ah, 0x0E		
.repeat:
	lodsb			; Get char from DS:SI and stick in AL
	or  al, al              ; is char a zero (i..e end of string)?
	jz .done		; if AL is zero, we're done
	int 0x10		
	jmp .repeat             ; loop til string is printed
.done:
	ret
	


stage_2 db "Stage 2 loaded", 0x0A, 0x0D, 0




TIMES 	1024-($-$$) DB 0

