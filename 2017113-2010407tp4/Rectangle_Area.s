.globl	_ZNK9Rectangle7AreaAsmEv

_ZNK9Rectangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        mov 8(%ebp), %eax       # on recupere l'objet
        fld 4(%eax)             # on push length_
        fld 8(%eax)             # on push width_
        fmulp                   # on multiplie les deux valeurs ensemble
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
