#Ryan Donnohue
#Homework 7

#########PseudoCode###########
#get user string
#pass addresses to function
#cycle through string and do conversion
#increment both addresses each interation of the loop
#Repeat for both upper and lower
.data
	lowerStringInput: .space 100
	lowerStringPrompt: .asciiz "Enter a string to convert to lowercase: "
	lowerconvertedString:  .space 100   
	
	upperStringInput: .space 100
	upperStringPrompt: .asciiz "\nEnter a string to convert to uppercase: "
	upperconvertedString: .space 100
	
	numTranslations: .asciiz "The number of translations is: "
	convertedStringPrompt: .asciiz "The converted string is: "
	
.text
	main: 
		#prompting user
		li $v0, 4
		la $a0, lowerStringPrompt
		syscall
		
		#getting user string
		li $v0, 8
		la $a1, 100
		la $a0, lowerStringInput
		syscall
		
		#initializing values that will be passed to the procedure "toLower"
		la $a0, lowerStringInput
		la $a1, lowerconvertedString
		li $v0, 0
		
		#jumping to lower
		jal toLower
		
		#vaing $v0 value (which was returned)
		move $t0, $v0
		
		#prompting
		li $v0, 4
		la $a0, convertedStringPrompt
		syscall
		
		#printing the string that was converted
		li $v0, 4
		la $a0, lowerconvertedString
		syscall
		
		#printing the number of translations string
		li $v0, 4
		la $a0, numTranslations
		syscall 
		
		#printing the number of translations
		li $v0, 1
		move $a0, $t0
		syscall
		
		#begining lower section
		
		#prompting user
		li $v0, 4
		la $a0, upperStringPrompt
		syscall
		
		#getting user input
		li $v0, 8
		la $a1, 100
		la $a0, upperStringInput
		syscall
		
		#initializing arguments
		la $a0, upperStringInput
		la $a1, upperconvertedString
		li $v0, 0
		
		#jumping
		jal toUpper
		
		#saving number of translations
		move $t0, $v0
		
		#converting string prompt
		li $v0, 4
		la $a0, convertedStringPrompt
		syscall
		
		#printing the new converted string
		li $v0, 4
		la $a0, upperconvertedString
		syscall
		
		
		li $v0, 4
		la $a0, numTranslations
		syscall 
		
		#printing the number of translations
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 10
		syscall
		
		
	#please notice that this procedure DOES USE a jr to get back to main!!!!!!!!!!!!!!!!!!!!!
	#I even renamed perfectly re-useable methods so that it will be entirely self-contained
	
	#Purpose translates a string to lower case and saves each character to the data location
	#Accepts: $a0 (string to be converted), $a1 (string to hold conversion)
	#Returns: $v0 (Number of conversions)
	toLower: 
		lbu $t0, ($a0)
		
		#Checks for the NULL terminator
		beq $t0, $zero, lowerisNull
		#if both conditions fail, it is an uppercase character
		blt $t0, 65, lowernext
		bgt $t0, 90, lowernext
		
		addi $t0, $t0, 32
		addi $a0, $a0, 1
		sb $t0, ($a1)
		addi $a1, $a1, 1
		
		addi $v0, $v0, 1
		
		b toLower
		
		
		lowernext: 
			addi $a0, $a0, 1
			sb $t0, ($a1)
			addi $a1, $a1, 1
			b toLower
			
		lowerisNull: 
			sb $t0, ($a1)
			jr $ra #<<<<<<<<<<<<<<<<<<JUMPS BACK>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	
	#ENTIRELY SELF CONTAINED!!!!!
	
	#Purpose translates a string to upper case and saves each character to the data location
	#Accepts: $a0 (string to be converted), $a1 (string to hold conversion)
	#Returns: $v0 (Number of conversions)
	toUpper: 
		lbu $t0, ($a0)
		
		#Checks for the NULL terminator
		beq $t0, $zero, upperisNull
		#if both conditions fail, it is a lower case character
		blt $t0, 97, uppernext
		bgt $t0, 122, uppernext
		
		addi $t0, $t0, -32 #converting
		addi $a0, $a0, 1 #incrementing address
		sb $t0, ($a1) #saving
		addi $a1, $a1, 1 
		
		addi $v0, $v0, 1
		
		b toUpper
		
			uppernext: 
				addi $a0, $a0, 1
				sb $t0, ($a1)
				addi $a1, $a1, 1
				b toUpper
			
			upperisNull: 
				sb $t0, ($a1)
				jr $ra #<<<<<<<<JUMPS BACK>>>>>>>>>>
			
		
		
	
	
		
		
		
	
		
		