%include "../include/io.mac"
 
struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc
 
section .text
    global sort_procs
 
sort_procs:
    enter 0,0
    pusha
 
    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length


mov ecx, -1 ; prima instr in compare_elements e de incrementare
push edi
push esi
push eax ; salvez valoarea pe stiva
dec eax ; voi folosi doua for-uri si primul va merge pana la length - 2

compare_elements:
    inc ecx
    xor ebx, ebx
    mov ebx, ecx ; al doilea for incepe de la ecx + 1
    cmp ecx, eax - 1 ; nu am ajuns la sfarsitul primului for
    jl go_to_next ; trec la urmatorul for
    jge end ; am terminat primul for => inchei programul

go_to_next:
    inc ebx

    cmp ebx, eax
    jg compare_elements ; am terminat al doilea for => sar la urm elem

    push eax
    xor eax, eax 
    mov eax, ecx
    imul eax, 5

    lea edi, [edx + eax] ; elem curent
    xor eax, eax
    mov eax, ebx
    imul eax, 5 ; un elem ocupa 5 octeti

    lea esi, [edx + eax] ; urm elem celui curent
    xor eax, eax

    pop eax
    push edx
    xor edx, edx

    ; compar prioritatile
    mov dl, byte [edi + 2]
    cmp dl, byte [esi + 2]
    pop edx ; nu mai am nevoie de var aux => revin la val initiala a registrului
    jg switch_1 ; prio elem 1 > prio elem 2 => interschimbare
    je switch_2 ; prioriatati egale => comparare dupa timp

    jmp go_to_next

switch_1:
    push eax
    push ebx
    push ecx

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

    ; interschimbare prioritati elem curente cu var aux
    mov al, byte [edi + 2]
    mov bl, byte [esi + 2]
    mov cl, al
    mov al, bl
    mov bl, cl
    mov byte [edi + 2], al
    mov byte [esi + 2], bl

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

    ; interschimbare pid-uri elem curente cu var aux
    mov ax, word [edi]
    mov bx, word [esi]
    mov cx, ax
    mov ax, bx
    mov bx, cx
    mov word [edi], ax
    mov word [esi], bx

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

    ; interschimbare timp elem curente cu var aux
    mov ax, word [edi + 3]
    mov bx, word [esi + 3]
    mov cx, ax
    mov ax, bx
    mov bx, cx
    mov word [edi + 3], ax
    mov word [esi + 3], bx

    pop ecx
    pop ebx
    pop eax

    jmp go_to_next
 
switch_2:
    push eax
    xor eax, eax

    ; comparare in fct de timp
    mov ax, word [edi + 3]
    cmp ax, word [esi + 3]

    pop eax

    jg switch_1 ; timp elem 1 > timp elem 2 => interschimbare
    je switch_3 ; timp elem 1 = timp elem 2 => comparare pid-uri

    jmp go_to_next
 
switch_3:
    push eax
    xor eax, eax

    ; comparare pid-uri
    mov ax, word [edi]
    cmp ax, word [esi]

    pop eax

    jg switch_1 ; pid elem 1 > pid elem 2 => interschimbare
    jmp go_to_next
 
end:
    pop eax
    pop esi
    pop edi

    popa
    leave
    ret