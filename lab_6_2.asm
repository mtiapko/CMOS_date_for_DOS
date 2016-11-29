DATA_SEG SEGMENT COMMON 'DATA_SEG'
    century db ?
    year    db ?
    month   db ?
    day     db ?
DATA_SEG ENDS

CODE_SEG SEGMENT
    PUBLIC  GET_DATE
    ASSUME  cs:CODE_SEG, ds:DATA_SEG

GET_DATE PROC FAR
BEGIN:
    mov ax, DATA_SEG
    mov ds, ax

    mov ah, 04h  ;  get CMOS date
    int 1ah      ;  from BIOS

    mov century,    ch
    mov year,       cl
    mov month,      dh
    mov day,        dl

    ret
GET_DATE ENDP

CODE_SEG ENDS
END BEGIN