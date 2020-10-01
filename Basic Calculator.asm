# MIPS Assembly Basic Calculator
# Serena LaFave
# May 2020

.data

int1_mess:	.asciiz "Integer 1: "
int2_mess:	.asciiz "\nInteger 2: "
op_mess:	.asciiz "\nOperator (+, -, /, *): "
op_err:		.asciiz "\nOperator error.\n"
ans_mess:	.asciiz "\n\nAnswer = "
div0_mess:	.asciiz "\nError: Division by zero."
end_mess:	.asciiz "\n\n----------\n\n"
plus:		.ascii "+"
minus:		.ascii "-"
divide:		.ascii "/"
multiply:	.ascii "*"

int1:		.word 1
int2:		.word 1

.text
.globl main

main: 		li $v0, 4					# print string syscall code loaded
			la $a0, int1_mess			# int_mess loaded into argument for syscall
			syscall						# int_mess printed

			li $v0, 5					# read int syscall code loaded	
			syscall						# Integer read

			la $s0, int1 				# load address of int1 into $s0
			sw $v0, 0($s0)				# store integer into int1 ($s0)

			li $v0, 4					# print string syscall code loaded
			la $a0, int2_mess			# int2_mess loaded into argument for syscall
			syscall						# int2_mess printed

			li $v0, 5					# read int syscall code loaded	
			syscall						# integer read

			la $s1, int2				# load address of int2 into $s1
			sw $v0, 0($s1)				# store integer into int2 ($s1)

			li $v0, 4					# print string syscall code loaded
			la $a0, op_mess				# op_mess loaded into argument for syscall
			syscall						# op_mess printed

			li $v0, 12					# read char syscall code loaded
			syscall						# op char read

			move $s2, $v0				# move op char into $s2

			lw $s3, int1 				# load value of int1 into $s3
			lw $s4, int2 				# load value of int2 into $s4

			lbu $t0, plus				# load "+" into $t0
			beq $s2, $t0, Addition		# branch to Addition if op ($s2) = "+" ($t0)

			lbu $t0, minus				# load "-" into $t0
			beq $s2, $t0, Subtract		# branch to Subtract if op ($s2) = "-" ($t0)

			lbu $t0, divide				# load "/" into $t0
			beq $s2, $t0, Division		# branch to Division if op ($s2) = "/" ($t0)

			lbu $t0, multiply			# load "*" into $t0
			beq $s2, $t0, Multiplic		# branch to Multiplic if op ($s2) = "*" ($t0)

			# If unrecognized op is read:

			li $v0, 4					# print string syscall code loaded
			la $a0, op_err				# load op_err as argument for syscall
			syscall						# print op_err

			j end 						# jump to the end of the program

Addition:	add $t3, $s3, $s4			# add int1 and int2, store into $t3
			
			li $v0, 4					# print string syscall code loaded
			la $a0, ans_mess			# ans_mess loaded into argument for syscall
			syscall						# ans_mess printed

			li $v0, 1					# print integer syscall code loaded
			move $a0, $t3				# move value of sum into argument for syscall
			syscall						# print sum

			j end 						# jump to the end of the program

Subtract:	sub $t3, $s3, $s4			# subtract int1 by int2, store into $t3
			
			li $v0, 4					# print string syscall code loaded
			la $a0, ans_mess			# ans_mess loaded into argument for syscall
			syscall						# ans_mess printed

			li $v0, 1					# print integer syscall code loaded
			move $a0, $t3				# move value of sum into argument for syscall
			syscall						# print sum

			j end 						# jump to the end of the program

Division:	beq $s4, $zero, Div_0 		# if the divisor = 0, jump to Div_0 
			
			div $t3, $s3, $s4			# divide int1 by int2, store into $t3
			
			li $v0, 4					# print string syscall code loaded
			la $a0, ans_mess			# ans_mess loaded into argument for syscall
			syscall						# ans_mess printed

			li $v0, 1					# print integer syscall code loaded
			move $a0, $t3				# move value of quotient into argument for syscall
			syscall						# print quotient

			j end 						# jump to the end of the program

Multiplic:	mul $t3, $s3, $s4			# multiply int1 and int2, store into $t3
			
			li $v0, 4					# print string syscall code loaded
			la $a0, ans_mess			# ans_mess loaded into argument for syscall
			syscall						# ans_mess printed

			li $v0, 1					# print integer syscall code loaded
			move $a0, $t3				# move value of product into $a0 for syscall
			syscall						# print sum

			j end 						# jump to the end of the program

Div_0:		li $v0, 4					# print string syscall code loaded
			la $a0, div0_mess			# div0_mess loaded into argument for syscall
			syscall	

end:		li $v0, 4					# print string syscall code loaded
			la $a0, end_mess			# end_mess loaded into argument for syscall
			syscall						# print end_mess print

			j main						# restart program
				
