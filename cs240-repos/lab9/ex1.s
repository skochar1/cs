
  	.text
  	.globl main
  
main:  	#setup
sub     $0x8,%rsp  

#prompt for index of element in array
mov    $prompt_string,%edi  
mov    $0x0,%eax
call     printf

	#accept input 
mov    $aindex,%esi 
mov    $format_string1,%edi
mov    $0x0,%eax
call     scanf

	#call function to return specified element of array
mov    aindex,%rsi        
mov    $elements,%edi
call    getElement

	#print specified array element
mov    %eax,%esi
mov    $format_string2,%edi
mov    $0x0,%eax
call     printf
 	
	#cleanup and return from main
mov    $0x0,%eax
add    $0x8,%rsp
ret
