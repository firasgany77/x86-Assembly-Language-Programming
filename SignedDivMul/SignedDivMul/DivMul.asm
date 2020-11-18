.386
.model flat,c
.code

;return : 0 Error (Division by zero)
;       : 1 Success
;
;Computation *prod = a*b
;            *quo = a/b
;            *rem = a%b


IntegerMulDiv proc 
              push ebp
              mov ebp, esp  
              push ebx      ;the code must preserve the values of ebx, esi, edi, ebp
                            ; these registers are called non-volatile regs.

                            ;Non-volatile (Callee-Saved) registers are guaranteed to be preserved by the
                            ;function. The called function is responsible for saving the
                            ;state of those registers and restoring those registers on exit.

                            ;Volatile-Regs (Caller Saved): eax, ecx, edx (need not to be preserved
                            ;across function calls) - caller-saved

              
