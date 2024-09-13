	.data 
vet:		.space	54 #0 de ninguém, X - Jogador 1, # - Jogador 2
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
