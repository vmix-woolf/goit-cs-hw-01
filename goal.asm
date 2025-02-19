.global _start
.align 4

.section __DATA,__data
a:          .byte 5
b:          .byte 3
c:          .byte 2
resultMsg:  .asciz "Result: "

.section __BSS,__bss
res:        .skip 2   ; 1 byte for number + 1 byte for NULL-terminator

.section __TEXT,__text
_start:
    ;load variables
    adrp x9, a@PAGE
    add x9, x9, a@PAGEOFF
    ldrb w0, [x9]

    adrp x10, b@PAGE
    add x10, x10, b@PAGEOFF
    ldrb w1, [x10]

    adrp x11, c@PAGE
    add x11, x11, c@PAGEOFF
    ldrb w2, [x11]

    ;calculate (b - c + a)
    sub w2, w1, w2
    add w0, w0, w2

    ; convert the number to ASCII
    add w0, w0, #0x30  ; now W0 contains the symbol '6'

    ; write ASCII digit to `res`
    adrp x12, res@PAGE
    add x12, x12, res@PAGEOFF
    strb w0, [x12]        ; res[0] = '6'
    mov w1, #0
    strb w1, [x12, #1]    ; res[1] = '\0' (NULL-terminator)

    ; output the string “Result: ”
    mov x0, 1
    adrp x1, resultMsg@PAGE
    add x1, x1, resultMsg@PAGEOFF
    mov x2, 8
    mov x16, 4
    svc #0x80

    ; output `res`
    mov x0, 1
    adrp x1, res@PAGE
    add x1, x1, res@PAGEOFF
    mov x2, 1     ; output only 1 symbol
    mov x16, 4
    svc #0x80

    ; finish the program
    mov x0, 0
    mov x16, 1
    svc #0x80
