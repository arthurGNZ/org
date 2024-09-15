	.data 
tabuleiro:		.space	54 #0 de ninguém, X - Jogador 1, # - Jogador 2
num_jogador:	.word	1
tamanho_tab:	.word	7
dificuldade:	.word	1
vit_jogador1:	.word	0
vit_jogador2:	.word	0
txt_menu:	.asciz "\n1)Configuração \n2)Jogar\n3)Sair"
txt_submenu:	.asciz "\n1)Quantidade de jogadores: \n2)Tamanho do tabuleiro \n3)Modo de dificuldade \n4)Zerar contadores \n5)Mostrar configurações atuais"
txt_jogadores:	.asciz "\nDigite a quantide de jogadores (1 ou 2):"
txt_tabuleiro:  .asciz "\nEscolha a largura do tabuleiro (7 ou 9):"
txt_dificuldade:.asciz	"\nEscolha a dificuldade(1 para fácil ou 2 para médio):"
txt_config:	.asciz	"\nA configurações atuais são:"
txt_config_dif:	.asciz	"\n	- Dificuldade atual:"	
txt_config_qnt:	.asciz	"\n	- Quantidade de jogadores:"
txt_config_tam:	.asciz	"\n	- Tamanho do tabuleiro:"
txt_config_con:	.asciz	"\n	- Placar:"
txt_opcao_inv:	.asciz	"\nEscolha Inválida! Voltando para o menu inicial"
quebra:	.asciz	"\n"
espaco:	.asciz	" "
txt2: 	.asciz "teste"
	.text

main:
	la a0, tabuleiro #pos. de memória da matriz do tabuleiro
	la a1, tamanho_tab 
	lb a1, 0(a0) #quantidade de colunas do tabuleiro
	call inicializa_tabuleiro
	call imprime_tabuleiro
	j finaliza_programa
#--------------------
inicializa_tabuleiro:
	li t0, 53 #tamanho do tabuleiro
	li t1, 0 #var de controle do loop
	j loop_inicializa
loop_inicializa:
	beq t0,t1,final_inicializa
	add t2, t1, a0 #salvando a posição de memória da variável atual do loop em t2
	li t3,0 #salvando 0 em t3 para salvar na posição de t2 futuramente
	sb t3, 0(t2)
	addi t1,t1,1 #andando 1 posição no loop
	j loop_inicializa
final_inicializa:
	ret
#--------------------	
imprime_tabuleiro:
	li t0, 6 #tamanho do primeiro loop(número de linhas)
	li t1, 0 #variavel de controle do primeiro loop
	
	la t2, tamanho_tab
	lb t2, 0(t2)#tamanho do segundo loop(número de colunas: 9 ou 7)

	mv t6, a0 #tirando a posição inicial do tabuleiro de a0, pois ele será usado para fazer ecall

	j loop1_imprimir
	
loop1_imprimir:
	beq t0,t1, final_imprimir
	li t3, 0 #variável de controle do segundo loop
	j loop2_imprimir
	
loop2_imprimir:	
	beq t2,t3, final_l2
	mul t4, t1, t2 #t4 recebe linha_atual*tam_linha
	add t4, t4, t3 #t4 recebe as linhas andadas + coluna atual
	add t4, t4, t6 #t4 recebe pos_inicial do tabuleiro+quantidades de casa necessária para chegar na pos atual 

	#ecall para imprimir valor atual 
	lb a0, 0(t4)
	li a7, 1
	ecall
	
	#ecall para imprimir espaço
	la a0, espaco
	li a7, 4
	ecall
	
	addi t3, t3, 1 #fazendo loop andar 1 posição
	j loop2_imprimir
final_l2:
	addi t1,t1,1
	la a0, quebra
	li a7, 4
	ecall
	j loop1_imprimir
final_imprimir:
	ret
#--------------------	
finaliza_programa:
	li a7, 10
	ecall
