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
                            ; the EAX, EDX, and ECX are to be free for use within a procedure or function,
                            ;and need not be preserved[citation needed].
                            #As the name implies, these general-purpose registers usually hold temporary (volatile) information,
                            ;that can be overwritten by any subroutine.

                            ;lTherefore, it is the caller's responsibility to push each of these registers onto the stack, 
                            ;if it would like to restore their values after a subroutine call.

              xor eax, eax ; to make sure eax is not zero
              mov ecx, [ebp+8]     ;ecx = 'a'
              mov edx, [ebp+12]    ;edx = 'b'

              or edx, edi          ; we are checking the argument 'b' in order to avoid division by zero condition.
              jz InvalidDivisor

              imul  edx,ecx        ;edx = 'a'*'b'
                                  
              ; if 'b' is not zero we continue
              mov ebx, [ebp+16]    ;ebx = 'prod'
              mov [ebx], edx

              mov eax, ecx         ; eax = 'a' 
              cdq                  ; edx:eax contains the divednd ( cdq convert double word to quad word)
                                   ; cdq Doubles the size of the operand in register AX or EAX (depending on the operand size) by means 
                                   ; of sign extension and stores the result in registers DX:AX or EDX:EAX, respectively.


             ; idiv ebx              ; EDX:EAX / EBX. Quotient saved to EAX, remainder in EDX
             ; idiv DWORD PTR [var]  ; EDX:EAX / 32-bit value stored at memory location var. Quotient in EAX, remainder in EDX
                                   
                                   ; cdq convert double word to quad word
                                   ; on x86 processor Signed Integer Division using 32 operands should be performed
                                   ; usuing a 64 wide dividend

              idiv dword ptr[ebp+12]
              mov ebx, [ebp+20]
              mov [ebx], eax
              mov [ebx], [ebp+24]
              mov [ebx], edx
              mov eax, 1           ;it means we have successfuly done the work.


              ; Epilouge
    InvalidDivisor:             
              pop ebx
              pop ebp
              ret

    IntegerMulDiv endp

end

