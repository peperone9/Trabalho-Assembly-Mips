.data
	msg1: .asciiz "\nprimeiro valor: "
	msg2: .asciiz "\nsegundo valor: "
	erro1: .asciiz "== A DIFERENCA ENTRE OS ANOS PRECISA SER MENOR QUE 1000 ==\n\n"
	erro2: .asciiz "== OS ANOS PRECISAM SER VALORES INTEIROS POSITIVOS ==\n\n"
	msg3: .asciiz " anos nao bissextos entre os valores\n"
.text

.globl main

main:
	li $v0, 4
	la $a0, msg1
	syscall
	
	#le primeiro valor
	li $v0, 5
	syscall
	#valida ano negativo
	blt $v0, 0, anonegativo
	add $t1, $v0, 0
	
	li $v0, 4
	la $a0, msg2
	syscall
	#le segundo valor
	li $v0, 5
	syscall
	
	#valida entradas
	blt $v0, 0, anonegativo
	
	#valida diferença entre os anos
	sub $t2, $t1, $v0
	abs $t2, $t2
	bgt $t2, 1000, errodediferenca
	
	beq $t2, $zero, fim
	j calculo	
	
#erro caso a diferença seja maior que 1000 anos
errodediferenca:
	li $v0, 4
	la $a0, erro1
	syscall
	j main

#erro caso a diferença seja maior que 1000 anos
anonegativo:
	li $v0, 4
	la $a0, erro2
	syscall
	j main
    
calculo:
	#ordena valores:
	
	#maior
    add $t3, $t1, $v0
    sub $t4, $t1, $v0
    abs $t4, $t4
    add $t3, $t3, $t4
    div $t3, $t3, 2 
    
    #MENOR
    add $t4, $t1, $v0
    sub $t5, $t1, $v0
    abs $t5, $t5
    sub $t4, $t4, $t5
    div $t4, $t4, 2 
    
    #Exclui o ano inicial do calculo
    add $t4, $t4, 1
    
    loop:
    rem $t6, $t4, 400 #valida divisibilidade por 400
    beq $t6, $zero, bissexto
    rem $t6, $t6, 100
    beq $t6, $zero, fimbissexto #sai da condicao caso seja divisivel por 100
    rem $t6, $t6, 4
    beq $t6, $zero, bissexto
    
    fimbissexto:
    add $t4,$t4, 1
    blt $t4, $t3, loop
    j fim
    
    
bissexto:
     sub $t2, $t2, 1 
     j fimbissexto
     
fim:
    li $v0, 1 
    add $a0, $t2, 0
    syscall
    
    li $v0, 4
    la $a0, msg3
    syscall