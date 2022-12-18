welcomestr: string 
"########################################

     BEM VINDO AO ASTEROID ATTACK!  

########################################"

startstr: string 
"         [Press ENTER to start]        "


jmp main
	
;; ====================== MAIN ======================
main:

	;; PRINTA TELA INICIAL
	; printa welcomestr
	loadn r0, #0 ; posicao inicial da string
	loadn r1, #welcomestr ; armazena string
	loadn r2, #0 ; cor da string
	call print

	; printa startstr
    loadn r5, #440
	add r0, r0, r5
	loadn r1, #startstr
	loadn r2, #0
	call print

	call waitForBegin

	;; FUNCIONAMENTO DO JOGO
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

;; ====================== PRINT ======================

print:

	; r0 posicao inicial
	; r1 string
	; r2 é a cor

	push r1	
	push r2	
	push r3	
	push r4	
	
	loadn r3, #'\0'	; criterio de parada

	printLoop:	
		loadi r4, r1    ; r4 <-- r1
		cmp r4, r3      ; r4 == r3?
		jeq printOut    ; se sim, sai da funcao
		add r4, r2, r4  ; coloca cor 
		outchar r4, r0  ; printa
		inc r0   	    ; anda pelo mapa
		inc r1	        ; anda pela string
		jmp printLoop   ;

	printOut:
		pop r4	
		pop r3
		pop r2
		pop r1

		rts

;; ====================== ESPERA INPUT CORRETO PARA COMEÇAR ======================

waitForBegin:

	push r0 
	push r1

	loadn r1, #13

	loopInput:
		inchar r0 ; le input do usuário

		cmp r0, r1 ; compara input com char estabelecido
		
		jne loopInput

		call clearScreen 
	
	pop r1
	pop r0

	rts


;; ====================== CLEAR SCREEN ======================
clearScreen:

	push r5
	push r6

	loadn r5, #1200
	loadn r6, #' '

	clearScreenLoop:
		dec r5
		outchar r6, r5
		jnz clearScreenLoop
	
	pop r6
	pop r5

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
	cmp r0, r1 ; ve se a posicao do meteoro esta na primeira linha ou nao (se sim, gera um novo / se nao, movimenta o q ja existe)
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
; os mesmo comentarios feitos para a funcao MovimentarW serve para as demais funcao de movimento
MovimentarW:
	pop r2
	pop r1
	pop r0

	loadn r3, #' '

	outchar r3, r0  ; coloca espaço vazio na antiga posição do player
	loadn r3, #40   ; número para ir para linha de cima

	sub r0, r0, r3  ; vai para linha de cima
	loadn r3, #'^'  ; 
	outchar r3, r0  ; coloca player na posicao
	
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
	pop r1 ; posicao meteoro
	pop r0 ; posicao nave

	cmp r1, r0
	jeq fimJogo

	push r0
	push r1
	push r2

	jmp inicioJogo

