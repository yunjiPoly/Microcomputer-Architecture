.globl	_ZNK8Cylinder12PerimeterAsmEv

factor: .float 2.0 /* use this to mult by two */

_ZNK8Cylinder12PerimeterAsmEv:


        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        //    2.0f * M_PI * radius_;

        /* Write your solution here */
        mov 8(%ebp),%eax        /*copier la classe dans eax*/
        fld 4(%eax)             /*mettre radius_ sur le float stack*/
        fldpi                   /*mettre la valeur pi sur le float stack*/
        fmulp                   /*multiplier st[1] et st[0],c-a-d radius*pi */
        fld factor              /*mettre le factor(2.0f) sur le float stck*/
        fmulp                   /*multiplier st[1] et st[0]:radius*pi*factor*/

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
