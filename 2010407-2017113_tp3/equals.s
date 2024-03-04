# Yun Ji Liao(2017113) et Zhao Long Luigi(2010407)
# Equals, TD3, inf1600, H20

.globl matrix_equals_asm

matrix_equals_asm:

        push %ebp       /* Save old base pointer */
        mov %esp, %ebp  /* Set ebp to current esp */

        pushl %ebx              # Mise des registres sur la pile
        pushl %ecx
        pushl %edx
        pushl %esi
        pushl %edi

        /* Initialisation des registres */
        movl $0, %eax           # Registre de retour
        movl $0, %ebx           # Initialisation de r
        movl $0, %ecx           # Initialisation de c
        movl 8(%ebp), %edx      # inmatdata1
        movl 12(%ebp), %esi     # inmatdata2
        movl 16(%ebp), %edi     # Valeur de matorder
        subl $8, %esp           # Création de 2 variables locales

        jmp for_l1              # Jump -> for_l1

for_l1:
        cmpl %ebx, %edi         # Comparaison de r avec matorder

        jg for_l2               # Jump if greater -> for_l2
        jmp end_loop            # Jump -> end_loop (Jump if not greater)

for_l2:
        cmpl %ecx, %edi         # Comparaison de c avec matorder
        
        jg if_statement         # Jump if greater -> if_statement
        movl $0, %ecx           # Remet c à 0
        incl %ebx               # Incremente r
        jmp for_l1              # Jump -> for_l1 (Jump if not greater)


if_statement:
        movl %ebx, 4(%esp)      # Enregistre les valeurs de r et de c sur la pile
        movl %ecx, 8(%esp)

        /* Index de inmatdata1  et inmatdata2 */
        movl %ebx, %eax         
        imull %edi, %eax        # matorder * r
        addl %ecx, %eax         # c + (matorder * r)

        movl (%edx, %eax, 4), %ebx   # Réaffectation de la valeur de la matrice inmatdata1 à %eax dans r
        movl (%esi, %eax, 4), %ecx   # Réaffectation de la valeur de la matrice inmatdata2 à %eax dans c
        
        cmpl %ebx, %ecx         # Comparaison des valeurs de deux matrices

        jne end_statement       # Jump if not equal -> end_statement

        movl 8(%esp), %ecx      # Reprise des valeurs actuelles de r et de c
        movl 4(%esp), %ebx
        incl %ecx               # Incrémente c

        jmp for_l2              # Jump -> for_l2 (Jump if equal)

end_statement:
        movl $0, %eax           # Retourne 0

        jmp end                 # Jump -> end

end_loop:
        movl $1, %eax           # Retourne 1

        jmp end                 # Jump -> end
        
end:
        addl $8, %esp           # Remettre %esp à "0"

        popl %edi               # Restaurer la valeur initiales des registres
        popl %edi        
        popl %edx
        popl %ecx
        popl %ebx

        leave          /* Restore ebp and esp */
        ret            /* Return to the caller */




