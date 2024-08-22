	.data 
vet:	.word	-3,2,5,-7,35
espaco: .asciz " "
txt:	.asciz "Escolha uma operação: \n1-Imprime vetor;\n2-Mostrar menor valor e posicao; \n3-Mostrar maior valor e posicao; \n4-Swap entre 2 indices; \n5-Ordenar vetor;\n"
txt1: 	.asciz "teste"
.text
main:
	call exibir_menu
	li a7, 5
	ecall
	mv t0,a0	
	#carregando parâmetros:
	la a0, vet #endereço vet
	li a1, 5 #tam vet
	li a2, 3 #indice1 
	li a3, 2 #indice2
	li t3, 0 #var de controle
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
	beq t0, t1, ordenar
	j op_invalida

exibir_menu: 
	li a7,4
	la a0, txt
	ecall
	ret
#---------------------
imprime_vetor_auxiliar:
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
	lw s0, 0(a0)#primeiro elemento
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
	addi t3,t3,1
	blt t6,s0, troca_menor
	j menor_valor
troca_menor:
	mv s0, t6
	j menor_valor
fim_menor:
	mv a0, s0
	li a7, 1
	ecall
	ret
#----------------------
maior_valor_aux:
	lw s0, 0(a0)#primeiro elemento
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
	addi t3,t3,1
	blt s0,t6, troca_maior
	j maior_valor
troca_maior:
	mv s0, t6
	j maior_valor
fim_maior:
	mv a0, s0
	li a7, 1
	ecall
	ret
#--------------------------
swap_aux:
	call swap
swap:
	lw t0, 0(a0)
	
	
	
#---------------------
ordenar:
	beq t3, a1, main
	add t2, t3,t3
	add t2, t2,t2
	add t2, t4, t2
	lw a0, 0(t2)
	mv t6, a0
	addi t3,t3,1
	blt s0,t6, troca_maior
	j maior_valor
op_invalida:
	call exibir_menu
	li a7,10
	ecall

	
	
	
