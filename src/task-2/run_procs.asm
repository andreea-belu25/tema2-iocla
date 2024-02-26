%include "../include/io.mac"

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY

mov edx, -1 ; contor vector processes

push ebx ; il pun pe stiva pentru ca de obicei val acestuia nu se modifica
push esi ; la fel aici
push eax

xor esi, esi
mov esi, ebx ; mut lungimea vectorului in esi

initialize_arrays:
    inc edx
    cmp edx, esi
    jge prior_1 ; am ajuns la sfarsitul vectorului => opresc programul
    
    xor eax, eax
    lea eax, [ecx + 4 * edx] ; salvez in eax elem curent (intre elem sunt 4 oct)
    add eax, edx

    xor ebx, ebx ; golesc registrul ebx
    mov bl, byte [eax + 2] ; bl <- prioritatea elem curent

    xor edi, edi

    ; aflu ce prioritate are elem curent
    cmp bl, 1
    je sum_1

    cmp bl, 2
    je sum_2

    cmp bl, 3
    je sum_3

    cmp bl, 4
    je sum_4

    cmp bl, 5
    je sum_5

sum_1:
    ; prioritate 1 => adun timpul la time_result[0]
    mov edi, dword [time_result]
    add di, word [eax + 3]

    push eax

    xor eax, eax
    ; prioritate 1 => cresc nr de val cu prio 1 => prio_result[0]
    mov eax, dword [prio_result]
    add eax, 1

    mov [time_result], edi ; => mut val aflata in vector
    mov [prio_result], eax ; => la fel aici

    pop eax

    jmp initialize_arrays ; ma mut la urm elem in vector

sum_2:
    ; prioritate 2 => adun timpul la time_result[1]
    mov edi, dword [time_result + 4] ; + 4 pt ca e vector de int-uri
    add di, word [eax + 3]

    push eax

    xor eax, eax
    ; prioritate 2 => cresc nr de val cu prio 2 => prio_result[1]
    mov eax, dword [prio_result + 4] ; + 4 pt ca e vector de int-uri
    add eax, 1

    mov [time_result + 4], edi ; => mut val aflata in vector
    mov [prio_result + 4], eax ; la fel aici

    pop eax

    jmp initialize_arrays ; inaintez la urm elem

sum_3:
    ; prioritate 3 => adun timpul la time_result[2]
    mov edi, dword [time_result + 8] ; + 8 fata de adresa de inceput a vect
    add di, word [eax + 3]

    push eax

    xor eax, eax
    ; prioritate 3 => cresc nr de val cu prio 3 => prio_result[2]
    mov eax, dword [prio_result + 8]
    add eax, 1

    mov [time_result + 8], edi ; mut val in vector
    mov [prio_result + 8], eax ; la fel aici

    pop eax

    jmp initialize_arrays ; inaintez la urm elem

sum_4:
    ; prioritate 4 => adun timpul elem curent la time_result[3]
    mov edi, dword [time_result + 12]
    add di, word [eax + 3]

    push eax

    xor eax, eax
    ; prio 4 => cresc nr elem cu prio 4 => prio_result[3]
    mov eax, dword [prio_result + 12]
    add eax, 1

    mov [time_result + 12], edi ; mut valoarea in vector
    mov [prio_result + 12], eax ; la fel aici

    pop eax

    jmp initialize_arrays ; urm elem din for

sum_5:
    ; prio 5 => cresc timpul elem cu prio 5 => time_result[4]
    mov edi, dword [time_result + 16]
    add di, word [eax + 3]

    push eax
    ; prio 5 => cresc nr elem cu prio 5 => prio_result[4]
    xor eax, eax
    mov eax, dword [prio_result + 16]
    add eax, 1

    mov [time_result + 16], edi ; mut valoarea in vector
    mov [prio_result + 16], eax ; la fel aici

    pop eax

    jmp initialize_arrays ; urm elem in for

prior_1:
    pop eax 
    pop esi
    pop ebx

    xor ebx, ebx
    xor edx, edx
    xor esi, esi

    mov esi, dword [time_result] ; in ebx pun time_result[0]
    mov ebx, dword [prio_result] ; in eax pun prio_result[0]
    cmp ebx, 0 ; nu pot imparti la 0 => aflu val pentru urm prio
    je prior_2
    push eax
    xor eax, eax
    mov eax, esi
    div ebx ; quo salvat in eax si remain in edx
    
    xor ecx, ecx
    mov ecx, eax
    pop eax
    mov word [eax], cx ; mut catul in vectorul proc_avg la primul camp
    mov word [eax + 2], dx ; mut restul in vect proc_avg la al doilea camp

prior_2:
    xor ebx, ebx
    xor edx, edx
    xor esi, esi

    mov esi, dword [time_result + 4] ; in ebx pun time_result[1]
    mov ebx, dword [prio_result + 4] ; in eax pun prio_result[1]
    cmp ebx, 0 ; impartitor = 0 => trec la urm prio
    je prior_3
    push eax
    xor eax, eax
    mov eax, esi
    div ebx ; quo salvat in eax si remain in edx
    
    xor ecx, ecx
    mov ecx, eax
    pop eax
    mov word [eax + 4], cx ; mut catul pt a doua prio in proc_avg
    mov word [eax + 6], dx ; mut restul pt a doua prio in proc_avg

prior_3:
    xor ebx, ebx
    xor edx, edx
    xor esi, esi

    mov esi, dword [time_result + 8] ; in ebx pun time_result[2]
    mov ebx, dword [prio_result + 8] ; in eax pun prio_result[2]
    cmp ebx, 0 ; impartitor = 0 => trec la urm prio
    je prior_4
    push eax
    xor eax, eax
    mov eax, esi
    div ebx ; quo salvat in eax si remain in edx
    
    xor ecx, ecx
    mov ecx, eax
    pop eax
    mov word [eax + 8], cx ; mut catul pt a treia prio in proc_avg
    mov word [eax + 10], dx ; mut restul pt a treia prio in proc_avg

prior_4:
    xor ebx, ebx
    xor edx, edx
    xor esi, esi

    mov esi, dword [time_result + 12] ; in ebx pun time_result[3]
    mov ebx, dword [prio_result + 12] ; in eax pun prio_result[3]
    cmp ebx, 0 ; ; impartitor = 0 => trec la urm prio
    je prior_5
    push eax
    xor eax, eax
    mov eax, esi
    div ebx ; quo salvat in eax si remain in edx
    
    xor ecx, ecx
    mov ecx, eax
    pop eax
    mov word [eax + 12], cx ; mut catul pt a patra prio in proc_avg
    mov word [eax + 14], dx ; mut restul pt a patra prio in proc_avg

prior_5:
    xor ebx, ebx
    xor edx, edx
    xor esi, esi

    mov esi, dword [time_result + 16] ; in ebx pun time_result[4]
    mov ebx, dword [prio_result + 16] ; in eax pun prio_result[4]
    cmp ebx, 0 ; impartitor = 0 => termin programul si catul, restul raman 0
    je end
    push eax
    xor eax, eax
    mov eax, esi
    div ebx ; quo salvat in eax si remain in edx
    
    xor ecx, ecx
    mov ecx, eax
    pop eax
    mov word [eax + 16], cx ; mut catul pt a cincea prio in proc_avg
    mov word [eax + 18], dx ; mut restul pt a cincea prio in proc_avg

end:
    popa
    leave
    ret
