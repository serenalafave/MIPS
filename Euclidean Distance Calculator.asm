# MIPS Assembly Euclidean Distance Calculator
# Serena LaFave
# May 2020

.data 

mess_x1:	.asciiz "Enter x1: "
mess_x2:	.asciiz "\nEnter x2: "
mess_y1:	.asciiz "\nEnter y1: "
mess_y2:	.asciiz "\nEnter y2: "
ans_mess:	.asciiz "\nEuclidean distance = "
end_mess:	.asciiz "\n\n----------\n\n"

.text
.globl main

main:		# x1
			li $v0, 4					# load syscall code for print string
			la $a0, mess_x1				# load mess_x1 as the string to print
			syscall						# print mess_x1

			li $v0, 6					# load syscall code for read float 
			syscall						# read float

			mov.s $f1, $f0				# move the value of x1 to $f1

			# x2
			li $v0, 4					# load syscall code for print string
			la $a0, mess_x2				# load mess_x2 as the string to print
			syscall						# print mess_x2

			li $v0, 6					# load syscall code for read float 
			syscall						# read float

			mov.s $f2, $f0				# move the value of x2 to $f2

			# y1
			li $v0, 4					# load syscall code for print string
			la $a0, mess_y1				# load mess_y1 as the string to print
			syscall						# print mess_y1

			li $v0, 6					# load syscall code for read float 
			syscall						# read float

			mov.s $f3, $f0				# move the value of y1 to $f3

			# y2
			li $v0, 4					# load syscall code for print string
			la $a0, mess_y2				# load mess_y2 as the string to print
			syscall						# print mess_y2

			li $v0, 6					# load syscall code for read float 
			syscall						# read float

			mov.s $f4, $f0				# move the value of y2 to $f4

			# --
			sub.s $f0, $f1, $f3			# $f0 = x1 - y1
			mul.s $f0, $f0, $f0			# $f0 = (x1 - y1)^2

			sub.s $f5, $f2, $f4			# $f5 = x2 - y2
			mul.s $f5, $f5, $f5			# $f0 = (x2 - y2)^2

			add.s $f6, $f0, $f5			# f6 = $f0 + $f5

			sqrt.s $f0, $f6				# $f0 = sqrt($f6)

			li $v0, 4
			la $a0, ans_mess
			syscall

			li $v0, 2
			mov.s $f12, $f0
			syscall

			li $v0, 4
			la $a0, end_mess
			syscall

			j main
