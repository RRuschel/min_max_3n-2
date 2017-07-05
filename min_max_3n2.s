.data
N: .word 11 # number of elements in the array
X: .word 1, -4, 7, -3, 14, 1, -32, 49, 11, 7, -1 # array of numbers in which to find min and max
MIN: .word 0 # storage for min value
MAX: .word 0 # storage for max value
min: .asciiz "The minimum is "
max: .asciiz "\nThe maximum is "
.text
.globl main
main: # start writing your code here 

la $t0, X #$t0 will be the register with the address to read
la $t1, N
lw $t1, 0($t1) #$t1 will be the register with the length of the array
beq $t1, $zero, fim2 #Check is the list is empty
addi $t1, $t1, -1
beq $t1, $zero, only_one #Jump if the array have only one element
addi $t7, $t7, 2


lw $t4, 0($t0) #$t4 will receive the value read from the memory
addi $t0,$t0,4 #To get next value
lw $t5, 0($t0)
addi $t0,$t0,4 #Get ready to get the next one after
slt $t6, $t4, $t5
beq $t6, $zero, greater #IF first value is greater than the second
addi $t2, $t4, 0
addi $t3, $t5, 0 
j for_loop

greater:
addi $t2, $t5, 0
addi $t3, $t4, 0

for_loop:
slt $t6, $t7, $t1 #IF t7 < t1 continue
beq $t6, $zero, fim #If the for counter is bigger than the size of the vector, jump
lw $t4, 0($t0) #Load A[i]
addi $t0,$t0,4 
lw $t5, 0($t0) #Load A[i+1]
slt $t6, $t4, $t5 #Will set if the second read value is greater
beq $t6, $zero, FG #Will jump if the first value is greater (A[i] > A[i+1])

#Else
addi $t0, $t0, 4 
addi $t7, $t7, 2 #Increment the "for" counter
slt $t6, $t4, $t2 #Set if t2<t4
beq $t6, $zero, min_min #Will jump if the actual min in smaller than t4
addi $t2, $t4, 0 #Min will receive t4

min_min: #If the minimum is still the minimum just have to compare the maximum
slt $t6, $t3, $t5
beq $t6, $zero, for_loop #If the actual maximum is still greater, just return to compare the next
addi $t3, $t5, 0
j for_loop
#End Else 

#if
FG:
addi $t0, $t0, 4 
addi $t7, $t7, 2 #Increment the "for" counter
slt $t6, $t5, $t2 #Check is t5 is smaller than the actual minimum
beq $t6, $zero, min_min2 #If t6 is not set, our minimum is still smaller
addi $t2, $t5, 0

min_min2:
slt $t6, $t3, $t4 #Check if t4 is greater than maximum
beq $t6, $zero, for_loop #if t3 is greater just return to the loop
addi $t3, $t4, 0
j for_loop
#end if


fim:
addi $t1, $t1, 1
andi $t1, $t1, 0x00000001
beq $t1, $zero, fim2 #If is even - ends, else compare the last elements
lw $t4, 0($t0)
slt $t6, $t4, $t2
beq $t6, $zero, LGM #Last is greater than min
addi $t2, $t4, 0x00000000

LGM:
slt $t6, $t3, $t4
beq $t6, $zero, fim2
addi $t3, $t4, 0x00000000
j fim2
  
only_one:
lw $t2, 0($t0)
lw $t3, 0($t0)

  
fim2:
la $t4, MIN
la $t5, MAX
sw $t2, 0($t4)
sw $t3, 0($t5)

#Print the messages
la $a0, min
li $v0, 4
syscall
add $a0, $t2, $zero
li $v0, 1
syscall

la $a0, max
li $v0, 4
syscall
add $a0, $t3, $zero
li $v0, 1
syscall

li $v0, 10
syscall






