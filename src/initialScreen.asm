jmp main	
	
gameName : string "JOGO DAS NAVES"

singleplayer : string "-  1 jogador  -"

multiplayer : string "- 2 jogadores -"

;---- Inicio do Programa Principal -----

main:
	loadn r0, #373		; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #gameName	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #3584      ;Seleciona a COR da Mensagem
	
	call showString   ;  r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"

	loadn r0, #614
	loadn r1, #singleplayer
	loadn r2, #2560
	
	call showString
	
	loadn r0, #694
	loadn r1, #multiplayer
	loadn r2, #2560
	
	call showString

	halt
	
;---- Fim do Programa Principal -----
	
;---- Inicio das Subrotinas -----
	
showString:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada
	
showStringLoop:	
	loadi r4, r1
	cmp r4, r3
	jeq exitShowString
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp showStringLoop
	
exitShowString:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts