#Alunos: 
#Arthur Henrique Paulini Grasnievicz - 2311100002
#Gabriel Gois - 2311100030
.data 
tabuleiro:        .space    54     #0 de ninguém, 1 - Jogador 1, 2 - Jogador 2
num_jogador:      .word     1
tamanho_tab:      .word     7
dificuldade:      .word     1         
vit_jogador1:     .word     0
vit_jogador2:     .word     0

txt_menu:         .asciz "\n1) Configuração \n2) Jogar \n3) Sair\n"
txt_submenu:      .asciz "\n1) Quantidade de jogadores: \n2) Tamanho do tabuleiro \n3) Modo de dificuldade \n4) Zerar contadores \n5) Mostrar configurações atuais\n"
txt_jogadores:    .asciz "\nDigite a quantidade de jogadores (1 ou 2):\n"
txt_tabuleiro:    .asciz "\nEscolha a largura do tabuleiro (7 ou 9):\n"
txt_dificuldade:  .asciz "\nEscolha a dificuldade (1 para fácil ou 2 para médio):\n"
txt_config:       .asciz "\nAs configurações atuais são:\n"
txt_config_dif:   .asciz "\n  - Dificuldade atual: "
txt_config_qnt:   .asciz "\n  - Quantidade de jogadores: "
txt_config_tam:   .asciz "\n  - Tamanho do tabuleiro: "
txt_config_con:   .asciz "\n  - Placar (Jogador 1 vs Jogador 2): "
txt_opcao_inv:    .asciz "\nEscolha inválida! Voltando para o menu inicial\n"
espaco:           .asciz " "

quebra:	.asciz	"\n"

.text
main_menu:
    la a0, txt_menu
    li a7, 4
    ecall

    li a7, 5
    ecall

    li t0, 1
    beq a0, t0, config_submenu
    li t1, 2
    beq a0, t1, game_menu
    li t2, 3
    beq a0, t2, finish

    j error
#--------------------	

config_submenu:

    la a0, clear_cmd
    li a7, 4
    ecall
    
    la a0, txt_submenu
    li a7, 4
    ecall

    li a7, 5
    ecall

    li t0, 1
    beq a0, t0, config_jogadores
    li t1, 2
    beq a0, t1, config_tabuleiro
    li t2, 3
    beq a0, t2, config_dificuldade
    li t3, 4
    beq a0, t3, zerar_contadores
    li t4, 5
    beq a0, t4, mostrar_config

    j error

#--------------------	
config_jogadores:
    la a0, txt_jogadores
    li a7, 4
    ecall

    li a7, 5
    ecall
    
    la a1,num_jogador
    li t0, 1
    beq a0, t0, altera_word
    li t1, 2
    beq a0, t1, altera_word
    

    j error
    
#--------------------	  

config_tabuleiro:
    la a0, txt_tabuleiro
    li a7, 4
    ecall

    li a7,5
    ecall
    la a1, tamanho_tab
    li t0, 7
    beq a0, t0, altera_word
    li t1, 9
    beq a0, t1, altera_word

    j error


#--------------------	
config_dificuldade:
    la a0, txt_dificuldade
    li a7, 4
    ecall

    li a7, 5
    ecall
    la a1, dificuldade
    li t0,1
    beq a0, t0, altera_word
    li t1, 2
    beq a0, t1, altera_word

    j error

#--------------------	
altera_word:
	sw  a0, 0(a1)
	j main_menu
#--------------------	

zerar_contadores:
    li t0, 0
    la t1, vit_jogador1
    sw t0, 0(t1)
    la t1, vit_jogador2
    sw t0, 0(t1)
    j main_menu

#--------------------	
mostrar_config:
    la a0, txt_config
    li a7, 4
    ecall


    la a0, txt_config_qnt
    li a7, 4
    ecall

    lw a0, num_jogador
    li a7, 1
    ecall


    la a0, txt_config_tam
    li a7, 4
    ecall

    lw a0, tamanho_tab
    li a7, 1
    ecall


    la a0, txt_config_dif
    li a7, 4
    ecall

    lw a0, dificuldade
    li a7, 1
    ecall


    la a0, txt_config_con
    li a7, 4
    ecall

    lw a0, vit_jogador1
    li a7, 1
    ecall

    la a0, espaco
    li a7, 4
    ecall

    lw a0, vit_jogador2
    li a7, 1
    ecall

    j main_menu

#--------------------	
game_menu:
	la a0, tabuleiro #pos. de memória da matriz do tabuleiro
	la a1, tamanho_tab 
	lb a1, 0(a0) #quantidade de colunas do tabuleiro
	call inicializa_tabuleiro
	call imprime_tabuleiro
	j main_menu
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
error:
    la a0, txt_opcao_inv
    li a7, 4
    ecall
    j main_menu
    
#--------------------	
verifica_vencedor:
    # a0: endereço da matriz_jogo
    # a1: quantidade de colunas
    # a2: jogador que realizou a última jogada
    # a3: linha da última jogada
    # a4: coluna da última jogada

    mv t5, a0
    mv t6, a1


    jal ra, verifica_linha
    li t0, 4
    beq a0, t0, vencedor_encontrado


    mv a0, t5
    mv a1, t6


    jal ra, verifica_coluna
    li t0, 4
    beq a0, t0, vencedor_encontrado


    mv a0, t5
    mv a1, t6


    jal ra, verifica_diagonal_decrescente
    li t0, 4
    beq a0, t0, vencedor_encontrado


    mv a0, t5
    mv a1, t6


    jal ra, verifica_diagonal_crescente
    li t0, 4
    beq a0, t0, vencedor_encontrado


    li a0, -1
    ret

vencedor_encontrado:
    li a0, 1
    mv a1, a2  
    ret

#---------------------------
verifica_linha:
    li t0, 0  
    mv t1, a4  

verifica_esquerda:
    bltz t1, fim_esquerda
    mul t2, a3, a1
    add t2, t2, t1
    add t2, t2, a0
    lb t3, 0(t2)
    bne t3, a2, fim_esquerda
    addi t0, t0, 1
    addi t1, t1, -1
    j verifica_esquerda

fim_esquerda:
    mv t1, a4
    addi t1, t1, 1

verifica_direita:
    bge t1, a1, fim_direita
    mul t2, a3, a1
    add t2, t2, t1
    add t2, t2, a0
    lb t3, 0(t2)
    bne t3, a2, fim_direita
    addi t0, t0, 1
    addi t1, t1, 1
    j verifica_direita

fim_direita:
    mv a0, t0
    ret

#---------------------------

verifica_coluna:
    li t0, 0  
    mv t1, a3  


verifica_baixo:
    li t2, 6  
    bge t1, t2, fim_baixo
    mul t2, t1, a1
    add t2, t2, a4
    add t2, t2, a0
    lb t3, 0(t2)
    bne t3, a2, fim_baixo
    addi t0, t0, 1
    addi t1, t1, 1
    j verifica_baixo

fim_baixo:
    mv t1, a3
    addi t1, t1, -1


verifica_cima:
    bltz t1, fim_cima
    mul t2, t1, a1
    add t2, t2, a4
    add t2, t2, a0
    lb t3, 0(t2)
    bne t3, a2, fim_cima
    addi t0, t0, 1
    addi t1, t1, -1
    j verifica_cima

fim_cima:
    mv a0, t0
    ret

#---------------------------
verifica_diagonal_decrescente:
    li t0, 0  
    mv t1, a3  
    mv t2, a4  


verifica_baixo_direita:
    li t3, 6  
    bge t1, t3, fim_baixo_direita
    bge t2, a1, fim_baixo_direita
    mul t3, t1, a1
    add t3, t3, t2
    add t3, t3, a0
    lb t4, 0(t3)
    bne t4, a2, fim_baixo_direita
    addi t0, t0, 1
    addi t1, t1, 1
    addi t2, t2, 1
    j verifica_baixo_direita

fim_baixo_direita:
    mv t1, a3
    mv t2, a4
    addi t1, t1, -1
    addi t2, t2, -1


verifica_cima_esquerda:
    bltz t1, fim_cima_esquerda
    bltz t2, fim_cima_esquerda
    mul t3, t1, a1
    add t3, t3, t2
    add t3, t3, a0
    lb t4, 0(t3)
    bne t4, a2, fim_cima_esquerda
    addi t0, t0, 1
    addi t1, t1, -1
    addi t2, t2, -1
    j verifica_cima_esquerda

fim_cima_esquerda:
    mv a0, t0
    ret

#---------------------------
verifica_diagonal_crescente:
    li t0, 0  
    mv t1, a3  
    mv t2, a4  


verifica_baixo_esquerda:
    li t3, 6  
    bge t1, t3, fim_baixo_esquerda
    bltz t2, fim_baixo_esquerda
    mul t3, t1, a1
    add t3, t3, t2
    add t3, t3, a0
    lb t4, 0(t3)
    bne t4, a2, fim_baixo_esquerda
    addi t0, t0, 1
    addi t1, t1, 1
    addi t2, t2, -1
    j verifica_baixo_esquerda

fim_baixo_esquerda:
    mv t1, a3
    mv t2, a4
    addi t1, t1, -1
    addi t2, t2, 1


verifica_cima_direita:
    bltz t1, fim_cima_direita
    bge t2, a1, fim_cima_direita
    mul t3, t1, a1
    add t3, t3, t2
    add t3, t3, a0
    lb t4, 0(t3)
    bne t4, a2, fim_cima_direita
    addi t0, t0, 1
    addi t1, t1, -1
    addi t2, t2, 1
    j verifica_cima_direita

fim_cima_direita:
    mv a0, t0
    ret
#---------------------------
finish:
    li a7, 10
    ecall
