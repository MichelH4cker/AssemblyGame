;-----Jogos das Naves--------

;---------jogo em si-----------
	;loop
		;tela inicial

	;loop
		;movimentacao da nave1
		
		;movimentacao da nave2
		
		;gera asteroides


;-----tela inicial--------
	;loop
		;mostra o nome do jogo na tela
	
		;opcao de 1 player
		;leitura de tecla "1"
	
		;opcao de 2 players
		;leitura da tecla "2"

;-------movimento jogador 1---------
	;loop
		;leitura da tecla apertada
		;compara com as teclas de movimento ja guardadas

;-------movimento jogador 2---------
	;loop
		;leitura da tecla apertada
		;compara com as teclas de movimento ja guardadas

;--------gera asteroides-----------
	;loop
		;funcao que gera aleatoriamente no eixo x um asteroide no topo da tela
		;movimenta asteroide para baixo verticalmente

	
jmp main	
	
mensagem2 : string "Jogo das Naves"

mensagem3 : string "- 1 jogador -"

mensagem4 : string "-2 jogadores-"

;---- Inicio do Programa Principal -----

main:
	loadn r0, #373		; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #mensagem2	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #3584      ;Seleciona a COR da Mensagem
	
	call Imprimestr   ;  r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"

	loadn r0, #614
	loadn r1, #mensagem3
	loadn r2, #2560
	
	call Imprimestr
	
	loadn r0, #694
	loadn r1, #mensagem4
	loadn r2, #2560
	
	call Imprimestr

	halt
	
;---- Fim do Programa Principal -----
	
;---- Inicio das Subrotinas -----
	
Imprimestr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada
	
ImprimestrLoop:	
	loadi r4, r1
	cmp r4, r3
	jeq ImprimestrSai
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp ImprimestrLoop
	
ImprimestrSai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
