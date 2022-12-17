jmp main

;; ====================== MAIN ======================
main:

	loadn r0, #420 ; posicao do personagem
	loadn r2, #0   ; incrementador

	call ColocarPersonagem

	halt

	ColocarPersonagem:
		loadn r1, #'^'
		outchar r1, r0

		push r0
		push r1
		push r2

		jmp inicioJogo
			
inicioJogo:

	loadn r2, #0
	loadn r3, #65535

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

		cmp r2, r3 ; v c o contador bateu o max
		jeq delay
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

	outchar r3, r0  ; coloca espaço vazio na antiga posição do player
	loadn r3, #40   ; número para ir para linha de cima

	sub r0, r0, r3  ; vai para linha de cima
	loadn r3, #'^'  ; 
	outchar r3, r0  ;
	
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

	dec r0
	loadn r3, #'^'
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

	add r0, r0, r3
	loadn r3, #'^'
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

	inc r0
	loadn r3, #'^'
	outchar r3, r0
	
	push r0
	push r1
	push r2
	jmp verificaColisao

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

