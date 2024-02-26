section .data
 
section .text
	global checkers
 
checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha
 
    mov eax, [ebp + 8]	; x ; linie
    mov ebx, [ebp + 12]	; y ; coloana
    mov ecx, [ebp + 16] ; table
 
    ;; DO NOT MODIFY
 
    ; tratez toate cele 4 cazuri sa vad daca pot sa pun 1 sau elem ramane 0
 
    xor esi, esi
    mov esi, eax
    sub esi, 1 ; x - 1
    cmp esi, 0 ; sunt in afara matricei
    jl go_to_elem2 ; ma duc la urm elem

    xor edi, edi
    mov edi, ebx
    sub edi, 1 ; y - 1
    cmp edi, 0 ; sunt in afara matricei
    jl go_to_elem2 ; ma duc la urm elem

    ; calculez al catelea elem din matrice e table[x-1][y-1]
    imul esi, 8
    add esi, edi
    mov byte[ecx + esi], 1 ; acest elem devine 1

go_to_elem2:
    xor esi, esi
    mov esi, eax
    add esi, 1 ; x + 1
    cmp esi, 7 ; sunt in afara matricei
    jg go_to_elem3 ; ma duc la urm elem

    xor edi, edi
    mov edi, ebx
    add edi, 1 ; y + 1
    cmp edi, 7 ; sunt in afara matricei
    jg go_to_elem3 ; ma duc la urm elem

    ; calculez al catelea elem din matrice e table[x+1][y+1]
    imul esi, 8
    add esi, edi
    mov byte[ecx + esi], 1 ; acest elem devine 1

go_to_elem3:
    xor esi, esi
    mov esi, eax
    add esi, 1 ; x + 1
    cmp esi, 7 ; sunt in afara matricei
    jg go_to_elem4 ; ma duc la urm elem

    xor edi, edi
    mov edi, ebx
    sub edi, 1 ; y - 1
    cmp edi, 0 ; sunt in afara matricei
    jl go_to_elem4 ; ma duc la urm elem

    ; calculez al catelea elem din matrice e table[x+1][y-1]
    imul esi, 8
    add esi, edi
    mov byte[ecx + esi], 1 ; acest elem devine 1

go_to_elem4:
    xor esi, esi
    mov esi, eax
    sub esi, 1 ; x - 1
    cmp esi, 0 ; sunt in afara matricei
    jl end ; ma duc la sfars programului si elem ramane 0

    xor edi, edi
    mov edi, ebx
    add edi, 1 ; y + 1
    cmp edi, 7 ; sunt in afara matricei
    jg end ; ma duc la sfars programului si elem ramane 0

    ; calculez al catelea elem din matrice e table[x-1][y+1]
    imul esi, 8
    add esi, edi
    mov byte[ecx + esi], 1 ; acest elem devine 1

end:
    popa
    leave
    ret