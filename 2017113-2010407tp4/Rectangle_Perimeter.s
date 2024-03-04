.globl	_ZNK9Rectangle12PerimeterAsmEv

factor: .float 2.0 /* use this to mult by two */

_ZNK9Rectangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        mov 8(%ebp), %eax      # on recupere l'objet
        

        fld 4(%eax)             # on push length_ sur st-0
        fld 8(%eax)             # on push width_ sur st-0 et length_ va dans st-1
        faddp                   # on fait une addition avec st-0 et st-1 et la reponse est remis dans st-0 et st-1
        fld factor              # on push 2.0 sur st-0 et la reponse de l'addition est stocke dans st-1
        fmulp                   # on multiplie st-0 et st-1 et la reponse est remplace dans st-0 et st-1
        
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
