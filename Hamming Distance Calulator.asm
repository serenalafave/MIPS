# MIPS Assembly Hamming Distance Calculator
# Serena LaFave
# May 2020

.data

num_mess1:	.asciiz "First number: "
num_mess2:	.asciiz "\nSecond number: "
ham_mess:	.asciiz "\n\nHamming distance = "
end_mess:	.asciiz "\n\n---------\n\n"

num1:		.space 3
num2:		.space 3

.text
.globl main

main:		li $v0, 4					# print string syscall code loaded
			la $a0, num_mess1			# num_mess1 loaded into $a0 for syscall
			syscall						# num_mess1 printed

			li $v0, 8					# read string syscall code loaded
			la $a0, num1 				# num1 to be address for read string
			li $a1, 3					# string size = 3
			syscall						# num1 read

			li $v0, 4					# print string syscall code loaded
			la $a0, num_mess2			# num_mess2 loaded into $a0 for syscall
			syscall						# num_mess2 printed

			li $v0, 8					# read string syscall code loaded
			la $a0, num2 				# num2 to be address for read string
			li $a1, 3					# string size = 3
			syscall						# num2 read

			li $s0, 0					# Hamming distance = 0
			li $s3, 0					# index = 0

			la $s1, num1 				# load num1 into $s1
			la $s2, num2 				# load num2 into $s2

Hamming:	lbu $t0, num1($s3)			# load digit of num1 at index $s3 into $t0
			lbu $t1, num2($s3)			# load digit of num2 at index $s3 into $t0

			addi $s3, $s3, 1			# increment index

			bne $t0, $t1, Increment 	# if the digits are not equal, branch to Increment
			bne $s3, 2, Hamming			# if index < length of numbers, branch to Hamming
			beq $s3, 2, End 			# if the index is 2, branch to End

Increment:	addi $s0, $s0, 1			# increment hamming distance
			
			bne $s3, 2, Hamming			# if index < length of numbers, branch to Hamming			

End:		li $v0, 4					# print string syscall code loaded
			la $a0, ham_mess			# ham_mess loaded into $a0 for syscall
			syscall						# print ham_mess

			li $v0, 1					# print integer syscall code loaded
			move $a0, $s0				# move hamming distance into $a0 for syscall
			syscall						# print hamming distance

			li $v0, 4					# print string syscall code loaded
			la $a0, end_mess			# end_mess loaded into $a0 for syscall
			syscall						# end_mess printed

			j main						# restart program


