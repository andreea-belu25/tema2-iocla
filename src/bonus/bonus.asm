%include "../include/io.mac"

section .data

section .text
    global bonus
    extern printf

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x ; linia
    mov ebx, [ebp + 12]	; y ; coloana
    mov ecx, [ebp + 16] ; board

    ; tratez toate cele 4 cazuri, daca pot sa pun 1 => shiftez

    xor esi, esi
    mov esi, eax ; linia
    dec esi ; x - 1
    cmp esi, 0 ; sunt in afara matricei
    jl go_to_elem2 ; ma duc la urm caz

    xor edi, edi
    mov edi, ebx ; coloana
    dec edi ; y - 1
    cmp edi, 0 ; sunt in afara matricei
    jl go_to_elem2 ; ma duc la urm caz

    ; la al catelea elem din matrice trebuie sa pun 1
    xor edx, edx
    mov edx, esi
    imul edx, 8
    add edx, edi

    cmp edx, 31 ; 0-31 -> val in board[1], 32-64 -> val in board[0]
    jle put_the_value_board_1_first
    jmp put_the_value_board_0_first

put_the_value_board_1_first:
    push ecx
    xor ecx, ecx
    mov ecx, edx
 
    xor edi, edi
    mov edi, 1
    shl edi, cl ; 1 << pozitia elem la care trebuie sa pun 1
    xor esi, esi
 
    pop ecx
    or [ecx + 4], edi ; [ecx + 4] | (1 << pozitie elem)
    jmp go_to_elem2 ; ma duc la urm caz

put_the_value_board_0_first:
    xor edx, edx
    mov edx, 7
    sub edx, esi
    imul edx, 8 ; (7 - linie) * 8

    xor esi, esi
    mov esi, 7
    sub esi, edi ; (7 - coloana)

    push ecx
    xor ecx, ecx

    ; 31 - (7 - linie) * 8 - (7 - coloana) = poz 
    ; indicele lin sunt in ord desc
    mov ecx, 31
    sub ecx, edx
    sub ecx, esi

    xor edi, edi
    mov edi, 1
    shl edi, cl ; 1 << poz
    xor esi, esi
 
    pop ecx
 
    or [ecx], edi ; [ecx] | (1 << poz)
    jmp go_to_elem2 ; ma duc la urm caz

go_to_elem2:
    xor esi, esi
    mov esi, eax ; linia
    inc esi ; x + 1
    cmp esi, 7 ; sunt in afara matricei
    jg go_to_elem3 ; ma duc la urm caz

    xor edi, edi
    mov edi, ebx ; coloana
    inc edi ; y + 1
    cmp edi, 7 ; sunt in afara matricei
    jg go_to_elem3 ; ma duc la urm caz
 
    ; aflu la al catela elem trebuie sa pun 1
    xor edx, edx
    mov edx, esi
    imul edx, 8
    add edx, edi

    cmp edx, 31 ; aflu unde trebuie sa pun 1
    jle put_the_value_board_1_second
    jg put_the_value_board_0_second

put_the_value_board_1_second:
    push ecx
    xor ecx, ecx
    mov ecx, edx
 
    xor edi, edi
    mov edi, 1
    shl edi, cl ; 1 << nr_elem in matrice
    xor esi, esi
 
    pop ecx
 
    or [ecx + 4], edi ; [ecx + 4] | (1 << nr_elem)
    jmp go_to_elem3 ; ma duc la urm elem
 
put_the_value_board_0_second:
    xor edx, edx
    mov edx, 7
    sub edx, esi
    imul edx, 8 ; (7 - linie) * 8

    xor esi, esi
    mov esi, 7
    sub esi, edi ; (7 - coloana)

    push ecx
    xor ecx, ecx
    mov ecx, 31
    sub ecx, edx
    sub ecx, esi

    xor edi, edi
    mov edi, 1
    shl edi, cl
    xor esi, esi
 
    pop ecx
 
    or [ecx], edi ; [ecx] | (1 << nr_elem)
    jmp go_to_elem3 ; urm elem

go_to_elem3:
    xor esi, esi
    mov esi, eax ; linia
    dec esi ; x - 1
    cmp esi, 0 ; sunt afara din matrice
    jl go_to_elem4 ; urm caz
 
    xor edi, edi
    mov edi, ebx ; coloana
    inc edi ;  y + 1
    cmp edi, 7 ; sunt afara din matrice
    jg go_to_elem4 ; urm caz
 
    ; al catelea elem din matrice devine 1
    xor edx, edx
    mov edx, esi
    imul edx, 8
    add edx, edi
 
    cmp edx, 31 ; unde trebuie sa pun 1
    jle put_the_value_board_1_third
    jg put_the_value_board_0_third

put_the_value_board_1_third:

    ; sunt in board[1] => pun 1 cu rel aflata mai sus la celalate cazuri

    push ecx
    xor ecx, ecx
    mov ecx, edx
 
    
    xor edi, edi
    mov edi, 1
    shl edi, cl
    xor esi, esi
 
    pop ecx
 
    or [ecx + 4], edi
    jmp go_to_elem4
 
put_the_value_board_0_third:

    ; sunt in board[0] => pun 1 cu rel aflata mai sus la celalalte cazuri

    xor edx, edx
    mov edx, 7
    sub edx, esi
    imul edx, 8 ; (7 - linie) * 8

    xor esi, esi
    mov esi, 7
    sub esi, edi ; (7 - coloana)

    push ecx
    xor ecx, ecx
    mov ecx, 31
    sub ecx, edx
    sub ecx, esi

    xor edi, edi
    mov edi, 1
    shl edi, cl
    xor esi, esi
 
    pop ecx
 
    or [ecx], edi
    jmp go_to_elem4

go_to_elem4:
    xor esi, esi
    mov esi, eax ; linia
    inc esi ; x + 1
    cmp esi, 7 ; sunt in afara matricei
    jg end ; ma duc la sfarsitul program
 
    xor edi, edi
    mov edi, ebx ; coloana
    dec edi ; y - 1
    cmp edi, 0 ; sunt in afara matricei
    jl end ; ma duc la sfars matricei
 
    ; la al catelea elem pune 1 in matrice

    xor edx, edx
    mov edx, esi
    imul edx, 8
    add edx, edi
 
    cmp edx, 31 ; in care parte a matricei trebuie sa pun 1
    jle put_the_value_board_1_fourth
    jg put_the_value_board_0_fourth

put_the_value_board_1_fourth:

    ; pun 1 in board[1] pt elem 4 dupa rel aflata mai sus

    push ecx
    xor ecx, ecx
    mov ecx, edx
 
    xor edi, edi
    mov edi, 1
    shl edi, cl
    xor esi, esi
 
    pop ecx
 
    or [ecx + 4], edi
    jmp end
 
 put_the_value_board_0_fourth:

    ; pun 1 in board[0] pt elem 4 dupa rel aflata mai sus

    xor edx, edx
    mov edx, 7
    sub edx, esi
    imul edx, 8 ; (7 - linie) * 8

    xor esi, esi
    mov esi, 7
    sub esi, edi ; (7 - coloana)

    push ecx
    xor ecx, ecx
    mov ecx, 31
    sub ecx, edx
    sub ecx, esi

    xor edi, edi
    mov edi, 1
    shl edi, cl
    xor esi, esi
 
    pop ecx
 
    or [ecx], edi
    jmp end

end:
    popa
    leave
    ret