jmp main

Msn0: string "V O C E   V E N C E U !!!"
Msn1: string "Quer jogar novamente? <s/n>"

Letra: var #1		; Contem a letra que foi digitada

Pontos: var #1

posNave: var #1			; Contem a posicao atual da Nave
posAntNave: var #1		; Contem a posicao anterior da Nave

posMeteoro: var #1		; Contem a posicao atual do Meteoro

posTiro: var #1			; Contem a posicao atual do Tiro
posAntTiro: var #1		; Contem a posicao anterior do Tiro
FlagTiro: var #1		; Flag para ver se Atirou ou nao (Barra de Espaco!!)


main:

	Loadn R0, #0			
	store posNave, R0		; Zera Posicao Atual da Nave
	store posAntNave, R0	; Zera Posicao Anterior da Nave

	; MUDANCAS AQUI 
    store FlagTiro, r0      ; Zera o Flag para marcar que ainda nao Atirou!
    store posTiro, r0       ; Zera Posicao Atual do Tiro
    store posAntTiro, r0    ; Zera Posicao Anterior do Tiro


	loadn r0, #420
	loadn r1, #20 ; posicao
	loadn r2, #0 ; incrementado

	call ColocarPersonagem

	halt

	ColocarPersonagem:
		loadn r1, #'$'
		outchar r1, r0

		push r0
		push r1
		push r2

		jmp inicioJogo
			
inicioJogo:

	loadn r2, #0
	loadn r3, #65535
	loadn r4, #0

	loopJogo:


		inchar r0

		loadn r1, #'w'
		cmp r0, r1
		jeq MovimentarW

		loadn r1, #'a'
		cmp r0, r1
		jeq MovimentarA


		loadn r1, #'s'
		cmp r0, r1
		jeq MovimentarS


		loadn r1, #'d'
		cmp r0, r1
		jeq MovimentarD

		loadn r1, #' '
		cmp r0, r1
		jeq Atira_tiro

		cmp r2, r3 ; v c o contador bateu o max
		jeq delay

		loadn r1, #1
		mod r1, r2, r1
		cmp r1, r4		; if (mod(c/2)==0
		ceq MoveTiro	; Chama Rotina de movimentacao do Tiro

		inc r2

		jmp loopJogo

fimJogo:
	
	loadn r2, #' ' ; apaga o meteoro
	outchar r2, r0
	outchar r2, r1

	loadn r2, #40
	mod r0, r0, r2 ; volta ate a posicao da exclamacao

	loadn r2, #' '
	outchar r2, r0 ; apaga a exclamacao

	rts

;; ====================== METEORO ======================

delay:

	pop r1 ; incrementador
	loadn r0, #10
	cmp r1, r0 ; v c o incrementador bateu 10 (655350 ~ 0.6 segundo)
	jeq geraMeteoro

	inc r1 ; incrementa o incrementador
	push r1
	loadn r0, #0 ; volta o contador a 0
	loadn r1, #65535 ; max do resistrador
	jmp inicioJogo

geraMeteoro:

	pop r0 ; posicao meteoro gerado

	loadn r1, #39
	cmp r0, r1 ; v c a posicao do meteoro esta na primeira linha ou nao (se sim, gera um novo / se nao, movimenta o q ja existe)
	jgr moveMeteoro

	loadn r1, #'!' ; coloca oa exclamacao de aviso 
	outchar r1, r0

	loadn r1, #40
	add r0, r0, r1

	loadn r1, #0
	push r0
	push r1
	loadn r0, #0 ; volta o contador a 0
	loadn r1, #65535

	jmp inicioJogo

moveMeteoro:

	loadn r1, #1000 ; v c o meteoro chegou no fim da tela
	cmp r0, r1
	jgr apagaMeteoro
	
	loadn r1, #' ' ; apaga o meteoro
	outchar r1, r0

	loadn r1, #40 ; movimenta o meteoro
	add r0, r0, r1

	loadn r1, #'*' ; coloca o meteoro
	outchar r1, r0

	store posMeteoro, r0;		;armazena a posicao do Meteoro

	loadn r1, #0
	push r0
	push r1

	loadn r0, #0 ; volta o contador a 0
	loadn r1, #65535

	jmp verificaColisao

apagaMeteoro:

	loadn r1, #' ' ; apaga o meteoro
	outchar r1, r0

	loadn r1, #40
	mod r0, r0, r1 ; volta ate a posicao da exclamacao

	loadn r1, #' '
	outchar r1, r0 ; apaga a exclamacao

	jmp geraNumero

geraNumero:

	loadn r1, #55 ; gera um numero nem um pouco aleatorio
	add r0, r0, r1

	loadn r1, #40
	mod r0, r0, r1

	loadn r1, #0
	push r0
	jmp geraMeteoro
	

;; ====================== MOVIMENTACAO ======================

MovimentarW:
	pop r2
	pop r1
	pop r0

	loadn r3, #' '

	outchar r3, r0
	loadn r3, #40

	store posAntNave, r0
	sub r0, r0, r3
	store posNave, r0

	loadn r3, #'$'
	outchar r3, r0
	
	push r0
	push r1
	push r2
	jmp verificaColisao

MovimentarA:
	pop r2
	pop r1
	pop r0

	loadn r3, #' '
	outchar r3, r0

	store posAntNave, r0
	dec r0
	store posNave, r0

	loadn r3, #'$'
	outchar r3, r0
	
	push r0
	push r1
	push r2
	jmp verificaColisao

MovimentarS:
	pop r2
	pop r1
	pop r0

	loadn r3, #' '

	outchar r3, r0
	loadn r3, #40

	store posAntNave, r0
	add r0, r0, r3
	store posNave, r0

	loadn r3, #'$'
	outchar r3, r0
	
	push r0
	push r1
	push r2
	jmp verificaColisao

MovimentarD:
	pop r2
	pop r1
	pop r0

	loadn r3, #' '
	outchar r3, r0

	store posAntNave, r0
	inc r0
	store posNave, r0

	loadn r3, #'$'
	outchar r3, r0
	
	push r0
	push r1
	push r2
	jmp verificaColisao

Atira_tiro:
	push r2
	push r1
	push r0

	loadn r1, #1
	store FlagTiro, r1		; FlagTiro = 1
	store posTiro, r0		; postiro = posNave
	jmp verificaColisao

	pop r2
	pop r1
	pop r0

;; ====================== COLISAO ======================

verificaColisao:

	pop r2 ; incrementador
	pop r1 ; posaicao meteoro
	pop r0 ; posicao nave

	cmp r1, r0
	jeq fimJogo

	push r0
	push r1
	push r2

	jmp inicioJogo

;; ==================== TIRO ==========================

MoveTiro:

	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	load r0, FlagTiro
	loadn r1, #1
	cmp r0, r1
	jeq MoveTiro_Apaga_Fim

	load r2, posTiro
	loadn r3, #40
	cmp r2, r3
	jle MoveTiro_Apaga

	load r0, posAntTiro
	loadn r1, #' '
	outchar r1, r0		;; apaga a posicao anterior do tiro	

	load r4, posTiro
	store posAntTiro, r4

	loadn r1, #'^'
	outchar r1, r4
	loadn r3, #40
	sub r4, r4, r3		;; soma 40 na posicao atual para o tiro subir
	store posTiro, r4
	jmp MoveTiro_Apaga_Fim

MoveTiro_Apaga:
	load r0, posAntNave
	loadn r1, #' '
	outchar r1, r0
	loadn r7, #0
	store FlagTiro, r7
	jmp MoveTiro_Apaga_Fim

MoveTiro_Apaga_Fim:
	pop r7
	pop r6
	pop r5
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; =================================== APAGA TELA ===============================
ApagaTela:
	push r0
	push r1

	loadn r0, #1200		; apaga todas as 1200 posicoes da tela
	loadn r1, #' '

	ApagaTela_loop:
		dec r0
		outchar r1, r0
		jnz ApagaTela_loop
	
	pop r1
	pop r0
	rts



jmp main

;=====================================================================
; Declara uma tela vazia para ser preenchida em tempo de execussao:

tela0Linha0  : string "                                        "
tela0Linha1  : string "                                        "
tela0Linha2  : string "                                        "
tela0Linha3  : string "                                        "
tela0Linha4  : string "                                        "
tela0Linha5  : string "                                        "
tela0Linha6  : string "                                        "
tela0Linha7  : string "                                        "
tela0Linha8  : string "                                        "
tela0Linha9  : string "                                        "
tela0Linha10 : string "                                        "
tela0Linha11 : string "                                        "
tela0Linha12 : string "                                        "
tela0Linha13 : string "                                        "
tela0Linha14 : string "                                        "
tela0Linha15 : string "                                        "
tela0Linha16 : string "                                        "
tela0Linha17 : string "                                        "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "

jmp main
