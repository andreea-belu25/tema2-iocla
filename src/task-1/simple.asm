%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

mov eax, 0 ; contor pentru parcurgere string

label:
    cmp eax, ecx
    jge end ; daca am ajuns la sfarsitul string-ului => inchei programul

    xor ebx, ebx ; golesc registrul la fiecare pas
    mov bl, byte [esi + eax] ; salvez in registru litera curenta din sir
    add bl, dl ; adaug la litera curenta step

    cmp bl, byte 'Z'
    jle go_next_loop ; < Z => mut litera in sirul rezultat si trec la urm litera
    sub bl, 26 ; daca e Z => scad 26

go_next_loop:
    mov byte [edi + eax], bl
    inc eax
    jmp label
    
end:
    popa
    leave
    ret
