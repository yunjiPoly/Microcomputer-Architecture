# Yun Ji Liao(2017113) et Zhao Long Luigi(2010407)
# Multiply, TD3, inf1600, H20

.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp      				# save old base pointer
        mov %esp, %ebp 				# set ebp to current esp



        pushl %ebx                  # Mise des registres sur la pile
    	pushl %ecx
    	pushl %edx
    	pushl %esi
    	pushl %edi

        /* Initialisation des registres */
        subl $16, %esp				# Allouer de l'espace memoire pour r, c, i et elem
        movl $0, -4(%ebp)			# r = 0
      	movl $0, -8(%ebp)			# c = 0
        movl $0, -12(%ebp)			# i = 0
        movl $0, -16(%ebp)          # elem = 0
        movl 20(%ebp), %ebx			# Place matorder dans %ebx

for_l1:
    	cmp -4(%ebp), %ebx 			# Comparaison de matorder avec r
    	je end					    # Si r = matorder -> end

for_l2:
    	cmp -8(%ebp), %ebx 			# Comparaison de matorder avec c
     	movl $0, -16(%ebp)			# elem  =0
    	jne for_l3				    # Si matorder != c -> troisieme for-loop
    	movl $0, -8(%ebp)			# c = 0
    	incl -4(%ebp)				# r++
    	jmp for_l1				    # Jump au debut du premier for-loop
    	
for_l3:
     	cmp -12(%ebp), %ebx 	    # Comparer matorder, i
     	jne multiply    			# Si matorder != i on jump à multiply
     	movl $0, -12(%ebp)			# i = 0
     	incl -8(%ebp)				# c++
    	jmp for_l2				    # Jump a la deuxieme for loop

multiply:
    	movl -4(%ebp), %eax 		# Place r dans %eax
    	mull 20(%ebp)				# r * matorder
    	addl -12(%ebp), %eax	    # i + (r * matorder)
    	movl 8(%ebp), %ecx 		    # place inmapdata1 dans ecx
    	movl (%ecx, %eax, 4), %ecx  # %ecx(inmapdata1) = inmatdata1[i+r*matorder]

    	movl -12(%ebp), %eax		# place i dans %eax
    	mull 20(%ebp)				# i * matorder
    	addl -8(%ebp), %eax			# c + (i * matorder)
    	movl 12(%ebp), %edx			# inmapdata2 place dans edx 
    	movl (%edx, %eax, 4), %edx	# %edx(inmapdata2) = inmatdata2[c+i*matorder]

    	movl %edx, %eax				# %eax = %edx = inmatdata2[c+i*matorder]
    	mull %ecx				    # inmatdata1 * inmatdata2
    	addl %eax, -16(%ebp)		# elem += inmatdata1 * inmatdata2

    	movl -4(%ebp), %eax			# on place r dans %eax
    	mull 20(%ebp)				# r * matorder
    	addl -8(%ebp), %eax			# c + (r * matorder)
    	movl 16(%ebp), %ecx			# %ecx = outmapdata
    	movl -16(%ebp), %edx		# %edx = elem
    	movl %edx, (%ecx, %eax, 4)  # elem = outmatdata[c+r*matorder]

    	incl -12(%ebp)				# i++
    	jmp for_l3				    # Jump a troisieme loop for

end:   
        popl %edi                   # Restaurer la valeur initiales des registres
        popl %edi        
        popl %edx
        popl %ecx
        popl %ebx
        addl $16, %esp				# On libere la memoire allouée aux variables locales
        leave          				# Restore ebp and esp 
        ret            				# Return to the caller 
