# Yun Ji Liao(2017113) et Zhao Long Luigi(2010407)
# Diagonal, TD3, inf1600, H20

.globl matrix_diagonal_asm

matrix_diagonal_asm :

	push %ebp       /* Save old base pointer */
	movl %esp, %ebp  /* Set ebp to current esp */
	
	pushl %ebx              # Mise des registres sur la pile
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi

	/* Initialisation les registre */
	movl $0, %eax           # Registre de retour
	movl $0, %ebx           # Initialisation de r
	movl $0, %ecx           # Initialisation de c
	movl 8(%ebp), %edx      # inmatdata1
	movl 12(%ebp), %esi     # inmatdata2
	movl 16(%ebp), %edi     # Valeur de matorder
	subl $8, %esp           # Création de 2 variables locales

	jmp for_l1              # Jump to for_l1

for_l1 :
	cmpl %ebx, %edi         # Comparaison de r avec matorder

	jg for_l2               # Jump if greater -> for_l2
	jmp end	                # Jump -> end_loop (Jump if not greater)

for_l2 :
	cmpl %ecx, %edi         # Comparaison de c avec matorder

	jg if_statement         # Jump if greater -> if_statement
	movl $0, %ecx           # Remet c à 0
	incl %ebx               # Incrémente r
	jmp for_l1              # Jump -> for_l1 (Jump if not greater)


if_statement :
	cmpl %ebx, %ecx			# Comparaison de r avec c
	jne else_statement      # Jump if not equal -> else_statement
	
	movl %ebx, 4(%esp)      # Mise de r et c sur la pile
    movl %ecx, 8(%esp)


    /* Index de inmatdata */
    movl %ecx, %eax        
    imull %edi, %eax        # matorder * c
    addl %ebx, %eax         # r + (matorder * c)

    movl (%edx, %eax, 4), %eax         # Réaffectation de la valeur de inmatdata à %eax vers %eax

    /* Index de outmatdata */        
    imull %edi, %ebx        # matorder * r
    addl %ecx, %ebx         # c + (matorder * r)

    movl %eax, (%esi, %ebx, 4)         # Réaffectation de la valeur contenue dans %eax vers outmatdata à %ebx

    movl 4(%esp), %ebx      # Reprise des valeurs actuelles de r et de c
    movl 8(%esp), %ecx
	
	incl %ecx               # Incrémente c

	jmp for_l2              # Jump -> for_l2

else_statement :
	/* Index de outmatdata */
    movl %ebx, %eax
	imull %edi, %eax	    # matorder * r
    addl %ecx, %eax		    # c + (matorder * r)

	movl $0, (%esi, %eax, 4)	       # Réaffectation de la valeur 0 vers outmatdata à %eax
	
	incl %ecx		# Incrémente c

	jmp for_l2		# Jump -> for_l2

end :
	addl $8, %esp

	popl %edi               # Restaurer la valeur initiales des registres
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx

	leave          /* Restore ebp and esp */
	ret            /* Return to the caller */

