bits 32 


global start        

extern exit, scanf, printf              
import exit msvcrt.dll    
import scanf msvcrt.dll
import printf msvcrt.dll
                          


segment data use32 class=data
    x dd 0
    n dd 0
    sw db 0
    arr times 100 dd 0       ; the maximum amount of elements in the array
    format_init db "Introduce the number of elements in the array: ", 0 
    format_init2 db "Introduce the integer elements of the array: ", 0
    format db "%d", 0
    format_space db "%d",32 , 0
    format_print db "The sorted array: ", 0
    
segment code use32 class=code
    start:
        push dword format_init       
        call [printf]                
        add esp, 4 * 1               
        
        push dword n
        push dword format            
        call [scanf]                 
        add esp, 4 * 2
        
        push dword format_init2
        call [printf]
        add esp, 4 * 1
        
        mov ECX, [n]                 
        
        mov ESI, dword arr        
        
        input:
            pushad                   ; pushes the contents of the general-purpose registers onto the stack
            push dword x
            push dword format
            call [scanf]
            add esp, 4 * 2
            
            popad                    ; pops doublewords from the stack into the general-purpose registers
            
            mov eax, [x]             ; moving the read value into the eax register
            
            mov [esi], eax           ; moving the value from eax into the array
            add esi, 4               ; modifying the index for the next element
        loop input
        
        
        repeat1:
            mov [sw], byte 0
            mov esi, arr
            mov ecx, [n]
            dec ecx                  ; we decrement before, because the indices start from 0
            repeat2:
                mov eax, [esi]       ; moving in eax the element from the current index
                cmp eax, [esi+4]     ; comparing it with the next element
                jle pass             ; if the two elements found at esi and esi+4 are in ascending order, we must not swap them
                mov [sw], byte 1     ; sw=1 means that at least one swap has been made
                mov ebx, [esi+4]     ; swapping the elements found at esi and esi+4
                mov [esi], ebx       
                mov [esi+4], eax
        
                pass:
            add esi, 4    
            loop repeat2
            
            cmp byte [sw], 1        ; continuation condition
            je repeat1
        
        
        push dword format_print
        call [printf]
        add esp, 4 * 1
        
        mov ecx, [n]
        mov esi, dword arr 
        
        output:
            pushad
            push dword [esi]
            push dword format_space
            call [printf]
            add esp, 4 * 2
            
            popad
            add esi, 4
        loop output
                
        push dword 0     
        call [exit]              