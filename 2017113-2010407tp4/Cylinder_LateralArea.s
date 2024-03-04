.globl	_ZNK8Cylinder14LateralAreaAsmEv

_ZNK8Cylinder14LateralAreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        // PerimeterCpp() * height_;

        /* Write your solution here */
        mov 8(%ebp),%eax        /*copier la classe dans eax*/
        fld 8(%eax)             /*mettre height_ sur le float stack*/   
        push %eax               /*mettre la class sur la pile */
        mov (%eax),%ebx         /*copier la class dans ebx pour acceder au vtable */
        call *12(%ebx)          /*appeler PerimeterCpp et le mettre le st[0]/*
        fmulp                   /*multiplier st[1] et st[0]:PerimeterCpp() * height_*/

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
