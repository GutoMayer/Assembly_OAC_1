.data
	v: .float 1.01, 2.24, 3.36, 0.91, 0.26, 0.0  # Vetor de floats
	tam: .word 6                               # Número de elementos no vetor v
	k: .word 1                               # Posição inicial k, pode ser ajustada conforme o necessário
	retorno: .word 0
	espaco: .asciiz "\n Indice "
.text
	main:
	la $a0, v # carrego o endereço do vetor
	lw $t1, tam # tam do vetor
	lw $t2, k # valor do indice k
	add $t0, $t2, $zero #inicio do contador em K
	li $t3, 4 # nmro de bits de cada posição do vetor
	mul $t4, $t2, $t3 #calcula deslocamento
	add $a1, $a0, $t4 # indice k, resultado
	lwc1 $f1, 0($a1) # conteúdo do indice K
	
	addi $sp, $sp, -16   # reserva espaço para 4 palavras (4 * 4 bytes)
	sw $ra, 12($sp)      # salva o registrador de retorno (link) na pilha
        sw $t0, 8($sp)       # salva $t0 na pilha
	sw $a1, 4($sp)       # salva $a1 na pilha
	sw $t1, 0($sp)       # salva $t1 na pilha

	jal loop_compare
	
	lw $t1, 0($sp)       # restaura $t1
	lw $a1, 4($sp)       # restaura $a1
	lw $t0, 8($sp)       # restaura $t0
	lw $ra, 12($sp)      # restaura $ra
	addi $sp, $sp, 16    # libera o espaço alocado na pilha
	
	li $v0, 10
	syscall
	
	update:
	mov.s $f1, $f3
	addi $t5, $t0, 0
	bgt, $t1, $t0, loop_compare
	
	loop_compare:
	lwc1 $f3, 0($a1) #carrega o valor float de k+1
	addi $a1,$a1, 4 # passo p proxima posição do vetor)
	addi $t0, $t0, 1 # acrescento o contador
	c.lt.s $f3, $f1 #comparo, se a condição for vdd, vou para a sub rotina sem_att, que verifica se o vetor cehegou ao fim, se chegou, imprime e volta pra o jal, encerrando 
	bc1t update # atualiza o valor se a condição retornar verdadeira
	bgt, $t1, $t0, loop_compare # compara se o contador n passou o tamanho max do vetor

	
	print_min_value:
    	li $v0, 4 
    	la $a0, espaco
    	syscall
    	
    	li $v0, 1
    	move $a0, $t5
 	syscall
	
	jr $ra 
	 
