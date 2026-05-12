.data
	msg1: .asciiz "primeiro valor: "
	msg2: .asciiz "segundo valor: "
	erro1: .asciiz "== A DIFERENCA ENTRE OS ANOS PRECISA SER MENOR QUE 1000 ==\n\n"
	erro2: .asciiz "== OS ANOS PRECISAM SER VALORES INTEIROS POSITIVOS ==\n\n"
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
	blt $v0, 0, anonegativo
	#valida diferença entre os anos
	sub $t2, $t1, $v0
	abs $t2, $t2
	bgt $t2, 1000, errodediferenca
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
	
	