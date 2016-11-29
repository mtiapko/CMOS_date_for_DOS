@echo off

..\tasm\bin\tasm /zi lab_6_1.asm
..\tasm\bin\tasm /zi lab_6_2.asm

..\tasm\bin\tlink /v lab_6_1.obj lab_6_2.obj

@echo on