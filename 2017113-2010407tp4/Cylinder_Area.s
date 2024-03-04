.globl	_ZNK8Cylinder7AreaAsmEv

_ZNK8Cylinder7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
   
        
        mov 8(%ebp),%eax        /*copier la classe dans eax*/
        push %eax               /*mettre la class sur la pile */
        
        mov (%eax),%ebx         /*copier la class dans ebx pour acceder au vtable */
        call *28(%ebx)          /*appeler BaseAreaCpp et le mettre le st[0]*/
        call *20(%ebx)          /*appeler LateralAreaCpp et le mettre le st[0]*/
        faddp                   /*addition de st[1] et st[0]:LateralAreaCpp() + BaseAreaCpp()*/


        leave          /* restore ebp and esp */
        ret            /* return to the caller */
