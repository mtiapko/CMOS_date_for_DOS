DATA_SEG SEGMENT COMMON 'DATA_SEG'
    century db ?
    year    db ?
    month   db ?
    day     db ?
DATA_SEG ENDS

CODE_SEG SEGMENT
    EXTRN   GET_DATE:FAR
    ASSUME  cs:CODE_SEG, ds:DATA_SEG

    PRINT_SPACE MACRO
        mov ah, 02h
        mov dl, ' '
        int 21h
    ENDM
BEGIN:
    mov ax, DATA_SEG
    mov ds, ax

    call GET_DATE

    mov dl, day
    call PRINT_PACKED_BCD
    PRINT_SPACE

    mov dl, month
    call PRINT_PACKED_BCD
    PRINT_SPACE

    mov dl, century
    call PRINT_PACKED_BCD

    mov dl, year
    call PRINT_PACKED_BCD

    mov ah, 4ch
    int 21h

PRINT_PACKED_BCD PROC
    push ax

    xor dh, dh
    mov ax, dx  ;  ax <- dx

    mov dl, 10h
    div dl  ;  div by 16 (higher value in al -> dl - first print dl)

    add ax, 3030h
    mov dx, ax  ;  dx <- ax

    mov ah, 02h
    int 21h  ;  print higher value in dl

    mov dl, dh  ;  mov lower value from dh to dl
    int 21h  ;  print lower value in dl

    pop ax
    ret
PRINT_PACKED_BCD ENDP

CODE_SEG ENDS
END BEGIN