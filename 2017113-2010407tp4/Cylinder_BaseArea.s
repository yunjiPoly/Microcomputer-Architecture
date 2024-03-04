.globl	_ZNK8Cylinder11BaseAreaAsmEv

_ZNK8Cylinder11BaseAreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        //M_PI * radius_ * radius_;
        /* Write your solution here */
        mov 8(%ebp),%eax        /* eax = radius_*/
        fld 4(%eax)             /*mettre radius_ sur le float stack*/
        fldpi                   /*mettre la valeur pi sur le float stack*/
        fmulp                   /*multiplier st[1] et st[0],c-a-d radius*pi*/
        fld 4(%eax)             /*ettre radius_ sur le float stack*/
        fmulp                   /*multiplier st[1] et st[0],c-a-d radius*pi*radius*/

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
