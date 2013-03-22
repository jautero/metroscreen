; Ottaa seuraavat parametrit: DE=pointeri asciiz tekstiin
; H=sijainti näytöllä 01, 02 tai 03
; L = kummalla puolella teksti on.
L4000:
        jmp     L59A1	; Hyppää osoitteeseen 59A1

L56E4:
        push    b ; pistä pinoon bc=L 
        push    b ; pistä pinoon bc=L
        push    b ; pistä pinoon bc=L = varaa pinosta 3*2 tavua
        lhld    X4026 ; Lataa HL:ään X4026:n sisältö (0040H)
        mov     e,m  ; lataa e:hen osoitteen [HL] sisältö. (3)
        mvi     d,000H ; lataa d:hen 0
        lxi     h,0000AH ; lataa hl:ään 000AH
        dad     sp ; lataa hl:ään SP+10
        mov     l,m ; lue hl:ään sp+10=00hh= sijanti näytöllä
        mvi     h,000H ; nolla ylin tavu
        ; Kutsu L5B52 HL=parametri h (sijainti näytöllä) DE=0003H
        call    L5B52 ;Kutsu rutiinia  L5B52 
        jnz     L570E
        lhld    X4026
        inx     h
        mov     e,m
        mvi     d,000H
        lxi     h,0000CH
        dad     sp
        mov     l,m
        mvi     h,000H
        call    L5B52
        jz      L5711

L59A1: ; Kopioi parametrit pinoon ja kutsu osoitetta 56E4
        mov     c,l 	; Kopioi l-rekisteri c:hen
        mvi     b,000H  ; Nollaa b rekisteri
        push    b		; työnnä bc pinoon (00ll)
        mov     c,h 	; kopioi h-rekisteri c:hen
        push    b 		; työnnä bc pinoon (00hh)
        push    d 		; työnnä de pinoon (ddee)
        call    L56E4   ; Kutsu rutiinia L56E4
        pop     b 		; poista pinoon työnnetyt 3 16-bittistä lukua
        pop     b
        pop     b
        ret 			; palaa (L4000) kutsuneeseen rutiiniin

L5B52:
        xchg ; Vaihda de ja hl
L5B53:
        mov     a,d ; parametri a:han
        xra     h ; 
        jm      L5B62
        mov     a,l
        sub     e
        mov     a,h
        sbb     d
        lxi     h,00001H
        rc
        dcr     l
        ret
;
L5B62:
        ana     h
        lxi     h,00001H
        rm
        dcr     l
        ret