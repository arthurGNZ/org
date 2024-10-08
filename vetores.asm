	.data 
vet:	.word	-3,2,5,-7,35
espaco: .asciz " "
txt:	.asciz "\nEscolha uma operação: \n1-Imprime vetor;\n2-Mostrar menor valor e posicao; \n3-Mostrar maior valor e posicao; \n4-Swap entre 2 indices; \n5-Ordenar vetor;\n"
quebra:	.asciz	"\n"
txt2: 	.asciz "teste"
.text
main:
	call exibir_menu
	call carrega_parametros
	#escolhendo área do menu:
	li t1, 1
	beq t0,t1,imprime_vetor_auxiliar
	addi t1, t1, 1
	beq t0, t1, menor_valor_aux
	addi t1, t1, 1
	beq t0, t1, maior_valor_aux
	addi t1, t1, 1
	beq t0, t1, swap_aux
	addi t1, t1, 1
	beq t0, t1, ordenar_aux
	j op_invalida

exibir_menu: 
	li a7,4
	la a0, txt
	ecall
	li a7, 5
	ecall
	mv t0,a0
	ret
carrega_parametros:
	la a0, vet #endereço vet
	li a1, 5 #tam vet
	li a2, 3 #indice1 
	li a3, 2 #indice2
	ret

#---------------------
imprime_vetor_auxiliar:
	li t3, 0 #var de controle
	mv t4,a0 #copiando end vet
	call	imprime_vetor
	j main
imprime_vetor:
	beq t3, a1, fim_laco
	add t2, t3,t3
	add t2, t2,t2
	add t2, t4, t2
	lw a0, 0(t2)
	li a7, 1
	ecall
	la a0, espaco
	li a7,4
	ecall
	addi t3,t3,1
	j imprime_vetor
fim_laco:
	ret
#--------------------------
menor_valor_aux:
	li t3, 0 #var de controle
	lw s0, 0(a0)#primeiro elemento
	li t0, 0 #primeiro indíce
	mv t4,a0 #copiando end vet
	call menor_valor
	j main
menor_valor:
	beq t3, a1, fim_menor
	add t2, t3,t3
	add t2, t2,t2
	add t2, t4, t2
	lw a0, 0(t2)
	mv t6, a0
	blt t6,s0, troca_menor
	addi t3,t3,1
	j menor_valor
troca_menor:
	mv s0, t6
	mv t0, t3
	addi t3,t3,1
	j menor_valor
fim_menor:
	mv a0, s0
	li a7, 1
	ecall
	la a0, quebra
	li a7,4,
	ecall
	mv a0, t0
	li a7, 1
	ecall
	ret
#----------------------
maior_valor_aux:
	li t3, 0 #var de controle
	lw s0, 0(a0)#primeiro elemento
	li t0, 0 #primeiro indíce
	mv t4,a0 #copiando end vet
	call maior_valor
	j main
maior_valor:
	beq t3, a1, fim_maior
	add t2, t3,t3
	add t2, t2,t2
	add t2, t4, t2
	lw a0, 0(t2)
	mv t6, a0
	blt s0,t6, troca_maior
	addi t3,t3,1
	j maior_valor
troca_maior:
	mv s0, t6
	mv t0, t3	
	addi t3,t3,1
	j maior_valor
fim_maior:
	mv a0, s0
	li a7, 1
	ecall
	la a0, quebra
	li a7,4,
	ecall
	mv a0, t0
	li a7, 1
	ecall
	ret
#--------------------------
swap_aux:
	call swap
	j main
swap:
	mv t5,a0 #copiando end vet
	li t6, 4
	
	mul t1,t6,a2#pega quantas posições até o 1º indice
	add t1, t5, t1#end 1º indíce
	lw t3, 0(t1)#valor 1º indice	
	
	mul t2, t6,a3 #pega quantas posições até o 2º indice
	add t2, t5, t2#end 2º indíce
	lw t4, 0(t2)#valor 2º indice
	
	sw t3, 0(t2)
	sw t4, 0(t1)
	ret
	
#---------------------
ordenar_aux:
	li s0, 0#var de controle
	li s2,0#var de controle 2 
	#a1 é a var para teste do fim do laço
	mv t0, a0
	call ordenar
	j main
ordenar:
	beq s0, a1, fim_ord
	add s1, s0,s0
	add s1, s1,s1
	add s1, t0, s1
	addi s0,s0,1
	li s2, 0
	j ordenar_2
ordenar_2:
	beq s2, a1, ordenar
	add s3, s2,s2
	add s3, s3,s3
	add s3, t0,s3
	
	addi s7, s3, 4
	lw s5, 0(s3)#elemento atual do 2º loop
	lw s6, 0(s7)#elemento atual+1 do 2º loop
	mv a2, s2
	addi a3, s2, 1
	
	blt s6, s5, chama_swap	

	addi s2,s2,1
	j ordenar_2
chama_swap:
	li t6, 4
	
	mul t1,t6,a2#pega quantas posições até o 1º indice
	add t1, t0, t1#end 1º indíce
	lw t3, 0(t1)#valor 1º indice	
	
	mul t2, t6,a3 #pega quantas posições até o 2º indice
	add t2, t0, t2#end 2º indíce
	lw t4, 0(t2)#valor 2º indice
	
	sw t3, 0(t2)
	sw t4, 0(t1)

	addi s2,s2,1
	j ordenar_2
fim_ord:
	ret
op_invalida:
	li a7,10
	ecall
