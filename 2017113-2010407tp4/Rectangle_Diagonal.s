.globl	_ZNK9Rectangle11DiagonalAsmEv

_ZNK9Rectangle11DiagonalAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        movl 8(%ebp), %eax      # on recupere l'objet
        fld 4(%eax)             # on push 2 fois length_
        fld 4(%eax)
        fmulp                   # on multiplie les 2 length_ ensemble
        fstp 4(%eax)            # on stocke la reponse de la multiplication dans length_
        fld 8(%eax)             # on push 2 fois width_
        fld 8(%eax)
        fmulp                   # on multiplie les 2 width_ ensemble
        fld 4(%eax)             # on push length_ 
        faddp                   # on additionne les 2 variables ensemble
        fsqrt                   # on fait la racine carre de toute l'operation
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
