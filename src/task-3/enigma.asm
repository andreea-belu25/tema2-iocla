%include "../include/io.mac"

;; defining constants, you can use these as immediate values in your code
LETTERS_COUNT EQU 26

section .data
    extern len_plain

section .text
    global rotate_x_positions
    global enigma   
    extern printf

; void rotate_x_positions(int x, int rotor, char config[10][26], int forward);
rotate_x_positions:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; rotor
    mov ecx, [ebp + 16] ; config (address of first element in matrix)
    mov edx, [ebp + 20] ; forward
    ;; DO NOT MODIFY


    ; PAS 1 : verificare ce linii trebuie modificate
    ; PAS 2 : verificare shiftare catre dreapta/ stanga
    ; PAS 3: 
    ; shiftare stanga : permutare prima linie incepand de la poz 0 pt x pasi
    ; shiftare dreapta : permutare prima linie incepand de la poz 25 pt x pasi
    ; swap intre 2 caractere de pe pozitii consecutive, in fct de caz: i, i - 1/ i, i + 1
    ; PAS 4 :
    ; pregatirea celor 2 for-uri pentru cea de-a doua linie:
    ; cel pt x (nr de shiftari catre  o directie)
    ; cel cu parcurgerea sirului de la cap/ coada
    ; PAS 5:
    ; am terminat si linia a doua => opresc executia programului

    cmp ebx, 0 ; index = 0
    je modify_zero_and_one

    cmp ebx, 1 ; index = 1
    je modify_two_and_three

    cmp ebx, 2 ; index = 2
    je modify_four_and_five

modify_zero_and_one:
    xor edi, edi
    mov edi, 0

    cmp edx, 0 ; shiftare stanga
    je increment2

    cmp edx, 1 ; shiftare dreapta
    je increment

increment:
    inc edi

    xor esi, esi
    mov esi, 25

    cmp edi, eax
    jle line_zero_case_one
    jg initialize_for_one_line

line_zero_case_one:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + esi]
    mov bl, byte[ecx + esi - 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + esi], al
    mov byte[ecx + esi - 1], bl

    pop eax
    pop edx
    pop ebx
    
    dec esi
    cmp esi, 1
    jge line_zero_case_one
    jl increment

initialize_for_one_line:
    xor edi, edi
    mov edi, 0
    jmp increment1

increment1:
    inc edi

    xor esi, esi
    mov esi, 25

    cmp edi, eax
    jle line_one_case_one
    jg end

line_one_case_one:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 26 + esi]
    mov bl, byte[ecx + 26 + esi - 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 26 + esi], al
    mov byte[ecx + 26 + esi - 1], bl

    pop eax
    pop edx
    pop ebx
    
    dec esi
    cmp esi, 1
    jge line_one_case_one
    jl increment1

increment2:
    inc edi

    xor esi, esi
    mov esi, 0

    cmp edi, eax
    jle line_zero_case_zero
    jg initialize_for_one_line_next

line_zero_case_zero:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + esi]
    mov bl, byte[ecx + esi + 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + esi], al
    mov byte[ecx + esi + 1], bl

    pop eax
    pop edx
    pop ebx
    
    inc esi
    cmp esi, 24
    jle line_zero_case_zero
    jg increment2

initialize_for_one_line_next:
    xor edi, edi
    mov edi, 0
    jmp increment3

increment3:
    inc edi

    xor esi, esi
    mov esi, 0

    cmp edi, eax
    jle line_one_case_zero
    jg end

line_one_case_zero:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 26 + esi + 1]
    mov bl, byte[ecx + 26 + esi]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 26 + esi + 1], al
    mov byte[ecx + 26 + esi], bl

    pop eax
    pop edx
    pop ebx
    
    inc esi
    cmp esi, 24
    jle line_one_case_zero
    jg increment3

modify_two_and_three:
    xor edi, edi
    mov edi, 0

    cmp edx, 0 ; shiftare stanga
    je increment4

    cmp edx, 1 ; shiftare dreapta
    je increment5

increment5:
    inc edi

    xor esi, esi
    mov esi, 25

    cmp edi, eax
    jle line_two_case_one
    jg initialize_for_three_line

line_two_case_one:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 52 + esi]
    mov bl, byte[ecx + 52 + esi - 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 52 + esi], al
    mov byte[ecx + 52 + esi - 1], bl

    pop eax
    pop edx
    pop ebx
    
    dec esi
    cmp esi, 1
    jge line_two_case_one
    jl increment5

initialize_for_three_line:
    xor edi, edi
    mov edi, 0
    jmp increment6

increment6:
    inc edi

    xor esi, esi
    mov esi, 25

    cmp edi, eax
    jle line_three_case_one
    jg end

line_three_case_one:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 78 + esi]
    mov bl, byte[ecx + 78 + esi - 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 78 + esi], al
    mov byte[ecx + 78 + esi - 1], bl

    pop eax
    pop edx
    pop ebx
    
    dec esi
    cmp esi, 1
    jge line_three_case_one
    jl increment6

increment4:
    inc edi

    xor esi, esi
    mov esi, 0

    cmp edi, eax
    jle line_two_case_zero
    jg initialize_for_three_line_next_step

line_two_case_zero:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 52 + esi]
    mov bl, byte[ecx + 52 + esi + 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 52 + esi], al
    mov byte[ecx + 52 + esi + 1], bl

    pop eax
    pop edx
    pop ebx
    
    inc esi
    cmp esi, 24
    jle line_two_case_zero
    jg increment4

initialize_for_three_line_next_step:
    xor edi, edi
    mov edi, 0
    jmp increment7

increment7:
    inc edi

    xor esi, esi
    mov esi, 0

    cmp edi, eax
    jle line_three_case_zero
    jg end

line_three_case_zero:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 78 + esi + 1]
    mov bl, byte[ecx + 78 + esi]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 78 + esi + 1], al
    mov byte[ecx + 78 + esi], bl

    pop eax
    pop edx
    pop ebx
    
    inc esi
    cmp esi, 24
    jle line_three_case_zero
    jg increment7

modify_four_and_five:
    xor edi, edi
    mov edi, 0

    cmp edx, 0 ; shiftare stanga
    je increment8

    cmp edx, 1 ; shiftare dreapta
    je increment9

increment9:
    inc edi

    xor esi, esi
    mov esi, 25

    cmp edi, eax
    jle line_four_case_one
    jg initialize_for_five_line

line_four_case_one:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 104 + esi]
    mov bl, byte[ecx + 104 + esi - 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 104 + esi], al
    mov byte[ecx + 104 + esi - 1], bl

    pop eax
    pop edx
    pop ebx
    
    dec esi
    cmp esi, 1
    jge line_four_case_one
    jl increment9

initialize_for_five_line:
    xor edi, edi
    mov edi, 0
    jmp increment10

increment10:
    inc edi

    xor esi, esi
    mov esi, 25

    cmp edi, eax
    jle line_five_case_one
    jg end

line_five_case_one:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 130 + esi]
    mov bl, byte[ecx + 130 + esi - 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 130 + esi], al
    mov byte[ecx + 130 + esi - 1], bl

    pop eax
    pop edx
    pop ebx
    
    dec esi
    cmp esi, 1
    jge line_five_case_one
    jl increment10

increment8:
    inc edi

    xor esi, esi
    mov esi, 0

    cmp edi, eax
    jle line_four_case_zero
    jg initialize_for_five_line_next_step

line_four_case_zero:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 104 + esi]
    mov bl, byte[ecx + 104 + esi + 1]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 104 + esi], al
    mov byte[ecx + 104 + esi + 1], bl

    pop eax
    pop edx
    pop ebx
    
    inc esi
    cmp esi, 24
    jle line_four_case_zero
    jg increment8

initialize_for_five_line_next_step:
    xor edi, edi
    mov edi, 0
    jmp increment11

increment11:
    inc edi

    xor esi, esi
    mov esi, 0

    cmp edi, eax
    jle line_five_case_zero
    jg end

line_five_case_zero:
    push ebx
    push edx
    push eax

    xor ebx, ebx
    xor edx, edx
    xor eax, eax

    mov al, byte[ecx + 130 + esi + 1]
    mov bl, byte[ecx + 130 + esi]
    mov dl, bl
    mov bl, al
    mov al, dl
    mov byte[ecx + 130 + esi + 1], al
    mov byte[ecx + 130 + esi], bl

    pop eax
    pop edx
    pop ebx
    
    inc esi
    cmp esi, 24
    jle line_five_case_zero
    jg increment11

end:
    popa
    leave
    ret

; void enigma(char *plain, char key[3], char notches[3], char config[10][26], char *enc);
enigma:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; plain (address of first element in string)
    mov ebx, [ebp + 12] ; key
    mov ecx, [ebp + 16] ; notches
    mov edx, [ebp + 20] ; config (address of first element in matrix)
    mov edi, [ebp + 24] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement enigma
    ;; FREESTYLE STARTS HERE


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY