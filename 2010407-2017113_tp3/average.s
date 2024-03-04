# Yun Ji Liao(2017113) et Zhao Long Luigi(2010407)
# Average, TD3, inf1600, H20

.global matrix_row_aver_asm

matrix_row_aver_asm:
    push %ebp      			/* Save old base pointer */
    mov %esp, %ebp 			/* Set ebp to current esp */


        /* Initialisation des registres */		
        subl $12, %esp				# Allouer de l'espace memoire pour r, c et elem
        movl $0, -4(%ebp)			# r = 0
      	movl $0, -8(%ebp)			# c = 0
        movl $0, -12(%ebp)			# elem = 0
        movl 16(%ebp), %ebx			# Place matorder dans %ebx

for_l1:
    	cmp -4(%ebp), %ebx 			# Compararer matorder,r
    	je end					    # Si r=matorder,  fin de la fonction
        movl $0, -12(%ebp)			# elem  =0
for_l2:
    	cmp -8(%ebp), %ebx 			# Comparer matorder, c
        je outmatdata               # Si c == matorder, jump a outmatdata

        movl -4(%ebp), %eax 		        # place r dans %eax
        movl 12(%ebp), %edi                 # %edi =outmatdata
    	mull 20(%ebp)				        # r * matorder
    	addl -8(%ebp), %eax	            	# c + (r * matorder)
    	movl 8(%ebp), %ecx 		         	# place inmapdata dans ecx
    	movl (%ecx, %eax, 4), %ecx      	# %ecx= inmatdata[c+r*matorder]
        addl %ecx, -12(%ebp)	        	# elem += inmatdata[c+r*matorder]
    	incl -8(%ebp)				        # c++
    	jmp for_l2				            # on jump au debut de la premier for loop

outmatdata:
		movl -12(%ebp),%eax			# on met elem dans %eax 
		divl %ebx					# elem / matorder
		movl -4(%ebp),%edx			# %edx = r
		movl  %eax, (%edi,%edx,4)	# outmapdata[r]
		movl $0, %edx  				# on reinitialise r
		movl $0, -8(%ebp)   		# on reinitialise c
		incl -4(%ebp)       		# r++ 
		movl 16(%ebp),%ebx 			# %ebx = matorder
		jmp for_l1					# on jump au debut de la boucle for1
end:
        leave          			/* Restore ebp and esp */
        ret           			/* Return to the caller */

