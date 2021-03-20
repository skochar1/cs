	.file	"practice.c"
	.text
.Ltext0:
	.globl	string_length_a
	.type	string_length_a, @function
string_length_a:
.LFB19:
	.file 1 "practice.c"
	.loc 1 23 0
	.cfi_startproc
.LVL0:
	.loc 1 25 0
	cmpb	$0, (%rdi)
	je	.L4
	.loc 1 24 0
	movl	$0, %eax
.LVL1:
.L3:
	.loc 1 26 0
	addl	$1, %eax
.LVL2:
	.loc 1 25 0
	movslq	%eax, %rdx
	cmpb	$0, (%rdi,%rdx)
	jne	.L3
	rep ret
.LVL3:
.L4:
	.loc 1 24 0
	movl	$0, %eax
	.loc 1 29 0
	ret
	.cfi_endproc
.LFE19:
	.size	string_length_a, .-string_length_a
	.globl	string_length_p
	.type	string_length_p, @function
string_length_p:
.LFB20:
	.loc 1 40 0
	.cfi_startproc
.LVL4:
	.loc 1 42 0
	cmpb	$0, (%rdi)
	je	.L8
	.loc 1 41 0
	movq	%rdi, %rax
.LVL5:
.L7:
	.loc 1 43 0
	addq	$1, %rax
.LVL6:
	.loc 1 42 0
	cmpb	$0, (%rax)
	jne	.L7
	jmp	.L6
.LVL7:
.L8:
	.loc 1 41 0
	movq	%rdi, %rax
.LVL8:
.L6:
	.loc 1 45 0
	subq	%rdi, %rax
.LVL9:
	.loc 1 46 0
	ret
	.cfi_endproc
.LFE20:
	.size	string_length_p, .-string_length_p
	.globl	contains_char_a
	.type	contains_char_a, @function
contains_char_a:
.LFB21:
	.loc 1 59 0
	.cfi_startproc
.LVL10:
	movl	%esi, %ecx
.LVL11:
	.loc 1 61 0
	movzbl	(%rdi), %eax
	testb	%al, %al
	je	.L13
	.loc 1 62 0
	cmpb	%sil, %al
	je	.L14
	.loc 1 60 0
	movl	$0, %eax
	jmp	.L11
.LVL12:
.L12:
	.loc 1 62 0
	cmpb	%cl, %dl
	je	.L15
.LVL13:
.L11:
	.loc 1 65 0
	addl	$1, %eax
.LVL14:
	.loc 1 61 0
	movslq	%eax, %rdx
	movzbl	(%rdi,%rdx), %edx
	testb	%dl, %dl
	jne	.L12
	.loc 1 67 0
	movl	$0, %eax
.LVL15:
	ret
.LVL16:
.L13:
	movl	$0, %eax
	ret
.L14:
	.loc 1 63 0
	movl	$1, %eax
	ret
.LVL17:
.L15:
	movl	$1, %eax
.LVL18:
	.loc 1 68 0
	ret
	.cfi_endproc
.LFE21:
	.size	contains_char_a, .-contains_char_a
	.globl	contains_char_p
	.type	contains_char_p, @function
contains_char_p:
.LFB22:
	.loc 1 80 0
	.cfi_startproc
.LVL19:
	movl	%esi, %edx
.LVL20:
	.loc 1 82 0
	movzbl	(%rdi), %eax
	testb	%al, %al
	je	.L20
	.loc 1 83 0
	cmpb	%sil, %al
	jne	.L18
	jmp	.L21
.LVL21:
.L19:
	cmpb	%dl, %al
	.p2align 4,,6
	je	.L22
.LVL22:
.L18:
	.loc 1 86 0
	addq	$1, %rdi
.LVL23:
	.loc 1 82 0
	movzbl	(%rdi), %eax
	testb	%al, %al
	jne	.L19
	.loc 1 88 0
	movl	$0, %eax
	ret
.LVL24:
.L20:
	movl	$0, %eax
	ret
.L21:
	.loc 1 84 0
	movl	$1, %eax
	ret
.LVL25:
.L22:
	movl	$1, %eax
	.loc 1 89 0
	ret
	.cfi_endproc
.LFE22:
	.size	contains_char_p, .-contains_char_p
	.globl	contains_string
	.type	contains_string, @function
contains_string:
.LFB24:
	.loc 1 129 0
	.cfi_startproc
.LVL26:
	.loc 1 130 0
	movzbl	(%rsi), %r9d
	.loc 1 131 0
	movl	$1, %eax
	.loc 1 130 0
	testb	%r9b, %r9b
	je	.L24
.LVL27:
	.loc 1 134 0 discriminator 1
	cmpb	$0, (%rdi)
	je	.L30
	.loc 1 134 0 is_stmt 0
	movl	$0, %r8d
	jmp	.L25
.LVL28:
.L26:
.LBB2:
	.loc 1 137 0 is_stmt 1
	cmpb	$0, 1(%rsi,%rdx)
	je	.L31
.LVL29:
.L28:
	.loc 1 139 0
	addl	$1, %eax
.LVL30:
	.loc 1 136 0
	movslq	%eax, %rdx
	leal	(%r8,%rax), %ecx
	movslq	%ecx, %rcx
	movzbl	(%rsi,%rdx), %r10d
	cmpb	%r10b, (%rdi,%rcx)
	je	.L26
.LVL31:
.L27:
	.loc 1 141 0
	addl	$1, %r8d
.LVL32:
.LBE2:
	.loc 1 134 0
	movslq	%r8d, %rax
	cmpb	$0, (%rdi,%rax)
	je	.L32
.LVL33:
.L25:
.LBB3:
	.loc 1 136 0 discriminator 1
	movslq	%r8d, %rax
	cmpb	(%rdi,%rax), %r9b
	jne	.L27
	.loc 1 137 0
	cmpb	$0, 1(%rsi)
	je	.L33
	movl	$0, %eax
	jmp	.L28
.LVL34:
.L30:
.LBE3:
	.loc 1 143 0
	movl	$0, %eax
	ret
.LVL35:
.L31:
.LBB4:
	.loc 1 138 0
	movl	$1, %eax
.LVL36:
	ret
.LVL37:
.L32:
.LBE4:
	.loc 1 143 0
	movl	$0, %eax
	ret
.LVL38:
.L33:
.LBB5:
	.loc 1 138 0
	movl	$1, %eax
.LVL39:
.L24:
.LBE5:
	.loc 1 144 0
	rep ret
	.cfi_endproc
.LFE24:
	.size	contains_string, .-contains_string
	.globl	substring
	.type	substring, @function
substring:
.LFB23:
	.loc 1 107 0
	.cfi_startproc
.LVL40:
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %r12
	movl	%esi, %ebx
	movl	%edx, %ebp
	.loc 1 108 0
	movslq	%edx, %rdi
.LVL41:
	movslq	%esi, %rax
	subq	%rax, %rdi
	call	malloc
.LVL42:
.LBB6:
	.loc 1 109 0
	cmpl	%ebx, %ebp
	jle	.L35
	movl	%ebx, %ecx
.LVL43:
.L36:
	.loc 1 110 0 discriminator 2
	movslq	%ecx, %rdx
	movzbl	(%r12,%rdx), %r9d
	movl	%ecx, %r8d
	subl	%ebx, %r8d
	movslq	%r8d, %r8
	movb	%r9b, (%rax,%r8)
	.loc 1 109 0 discriminator 2
	addl	$1, %ecx
.LVL44:
	cmpl	%ebp, %ecx
	jne	.L36
.LVL45:
.L35:
.LBE6:
	.loc 1 112 0
	subl	%ebx, %ebp
.LVL46:
	movslq	%ebp, %rbp
	movb	$0, (%rax,%rbp)
	.loc 1 114 0
	popq	%rbx
	.cfi_def_cfa_offset 24
.LVL47:
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
.LVL48:
	ret
	.cfi_endproc
.LFE23:
	.size	substring, .-substring
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"PASS"
.LC1:
	.string	"FAIL"
.LC2:
	.string	"Testing %s\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"[%s]  %s(\"%s\") = %d; expected %d\n"
	.section	.rodata.str1.1
.LC4:
	.string	"Of %4d tests of %s\n"
.LC5:
	.string	"   %4d PASS\n"
.LC6:
	.string	"   %4d FAIL\n\n"
	.text
	.globl	test_string_length
	.type	test_string_length, @function
test_string_length:
.LFB25:
	.loc 1 169 0
	.cfi_startproc
.LVL49:
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdi, 8(%rsp)
	movq	%rsi, %r15
	.loc 1 170 0
	movq	%rdi, %rsi
.LVL50:
	movl	$.LC2, %edi
.LVL51:
	movl	$0, %eax
	call	printf
.LVL52:
	movl	$test_strings, %ebp
	.loc 1 171 0
	movl	$0, %ebx
.LVL53:
.L42:
.LBB7:
.LBB8:
	.loc 1 174 0
	leal	1(%rbx), %r14d
.LVL54:
	.loc 1 175 0
	movq	0(%rbp), %r12
	movq	%r12, %rdi
	movl	$0, %eax
	movq	$-1, %rcx
	repnz scasb
	notq	%rcx
	leaq	-1(%rcx), %r13
	movl	%r13d, 4(%rsp)
.LVL55:
	.loc 1 176 0
	movq	%r12, %rdi
	call	*%r15
.LVL56:
	.loc 1 177 0
	cmpl	%r13d, %eax
	sete	%dl
	movzbl	%dl, %ecx
	addl	%ecx, %ebx
.LVL57:
	.loc 1 178 0
	cmpl	%r14d, %ebx
	je	.L39
	.loc 1 179 0
	testb	%dl, %dl
	movl	$.LC0, %edx
	movl	$.LC1, %esi
	cmovne	%rdx, %rsi
	movl	4(%rsp), %r9d
	movl	%eax, %r8d
	movq	%r12, %rcx
	movq	8(%rsp), %rdx
	movl	$.LC3, %edi
	movl	$0, %eax
.LVL58:
	call	printf
.LVL59:
	.loc 1 182 0
	jmp	.L41
.LVL60:
.L39:
	addq	$8, %rbp
.LBE8:
	.loc 1 173 0
	cmpq	$test_strings+128, %rbp
	jne	.L42
.LBB9:
	.loc 1 177 0
	movl	%ebx, %r14d
.LVL61:
.L41:
.LBE9:
.LBE7:
	.loc 1 185 0
	movq	8(%rsp), %rdx
	movl	%r14d, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
.LVL62:
	.loc 1 186 0
	movl	%ebx, %esi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
.LVL63:
	.loc 1 187 0
	movl	%r14d, %esi
	subl	%ebx, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
.LVL64:
	.loc 1 188 0
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
.LVL65:
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
.LVL66:
	popq	%r14
	.cfi_def_cfa_offset 16
.LVL67:
	popq	%r15
	.cfi_def_cfa_offset 8
.LVL68:
	ret
	.cfi_endproc
.LFE25:
	.size	test_string_length, .-test_string_length
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"[%s]  %s(\"%s\", '%c') = %d; expected %d\n"
	.text
	.globl	test_contains_char
	.type	test_contains_char, @function
test_contains_char:
.LFB26:
	.loc 1 191 0
	.cfi_startproc
.LVL69:
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%rdi, 24(%rsp)
	movq	%rsi, 16(%rsp)
	.loc 1 192 0
	movq	%rdi, %rsi
.LVL70:
	movl	$.LC2, %edi
.LVL71:
	movl	$0, %eax
	call	printf
.LVL72:
	movl	$test_strings, %r15d
	.loc 1 193 0
	movl	$0, %ebp
.LVL73:
.L52:
.LBB10:
.LBB11:
	.loc 1 197 0
	movb	$0, 33(%rsp)
.LVL74:
	movl	$97, %ebx
.LVL75:
.L51:
.LBB12:
.LBB13:
	.loc 1 199 0
	leal	1(%rbp), %r14d
.LVL76:
	movb	%bl, 32(%rsp)
	.loc 1 201 0
	movq	(%r15), %r12
	leaq	32(%rsp), %rsi
	movq	%r12, %rdi
	call	strstr
.LVL77:
	testq	%rax, %rax
	setne	%r13b
	movzbl	%r13b, %r13d
.LVL78:
	.loc 1 202 0
	movl	%ebx, 12(%rsp)
	movl	%ebx, %esi
	movq	%r12, %rdi
	movq	16(%rsp), %rax
	call	*%rax
.LVL79:
	.loc 1 203 0
	cmpl	%r13d, %eax
	sete	%dl
	movzbl	%dl, %ecx
	addl	%ecx, %ebp
.LVL80:
	.loc 1 204 0
	cmpl	%r14d, %ebp
	je	.L47
	.loc 1 205 0
	testb	%dl, %dl
	movl	$.LC0, %edx
	movl	$.LC1, %esi
	cmovne	%rdx, %rsi
	movl	%r13d, (%rsp)
	movl	%eax, %r9d
	movl	12(%rsp), %r8d
	movq	%r12, %rcx
	movq	24(%rsp), %rdx
	movl	$.LC7, %edi
	movl	$0, %eax
.LVL81:
	call	printf
.LVL82:
	jmp	.L49
.LVL83:
.L47:
	addl	$1, %ebx
.LVL84:
.LBE13:
	.loc 1 198 0
	cmpl	$123, %ebx
	jne	.L51
	.p2align 4,,5
	jmp	.L50
.L54:
.LBB14:
	.loc 1 203 0
	movl	%ebp, %r14d
.LVL85:
.L49:
.LBE14:
.LBE12:
.LBE11:
.LBE10:
	.loc 1 213 0
	movq	24(%rsp), %rdx
	movl	%r14d, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
.LVL86:
	.loc 1 214 0
	movl	%ebp, %esi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
.LVL87:
	.loc 1 215 0
	movl	%r14d, %esi
	subl	%ebp, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
.LVL88:
	jmp	.L55
.LVL89:
.L50:
	addq	$8, %r15
.LBB15:
	.loc 1 195 0
	cmpq	$test_strings+128, %r15
	jne	.L52
	jmp	.L54
.LVL90:
.L55:
.LBE15:
	.loc 1 216 0
	addq	$56, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
.LVL91:
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
.LVL92:
	popq	%r14
	.cfi_def_cfa_offset 16
.LVL93:
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE26:
	.size	test_contains_char, .-test_contains_char
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"[%s]  %s(\"%s\", \"%s\") = %d; expected %d\n"
	.text
	.globl	test_contains_string
	.type	test_contains_string, @function
test_contains_string:
.LFB27:
	.loc 1 219 0
	.cfi_startproc
.LVL94:
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%rdi, 24(%rsp)
	movq	%rsi, 16(%rsp)
	.loc 1 220 0
	movq	%rdi, %rsi
.LVL95:
	movl	$.LC2, %edi
.LVL96:
	movl	$0, %eax
	call	printf
.LVL97:
	movq	$test_strings, 8(%rsp)
	.loc 1 221 0
	movl	$0, %ebx
	jmp	.L58
.LVL98:
.L64:
.LBB16:
.LBB17:
.LBB18:
	.loc 1 225 0
	leal	1(%rbx), %r15d
.LVL99:
	.loc 1 226 0
	movq	0(%rbp), %r13
	movq	8(%rsp), %rax
	movq	(%rax), %r12
	movq	%r13, %rsi
	movq	%r12, %rdi
	call	strstr
.LVL100:
	testq	%rax, %rax
	setne	%r14b
	movzbl	%r14b, %r14d
.LVL101:
	.loc 1 227 0
	movq	%r13, %rsi
	movq	%r12, %rdi
	movq	16(%rsp), %rax
	call	*%rax
.LVL102:
	.loc 1 228 0
	cmpl	%r14d, %eax
	sete	%dl
	movzbl	%dl, %ecx
	addl	%ecx, %ebx
.LVL103:
	.loc 1 229 0
	cmpl	%r15d, %ebx
	je	.L59
	.loc 1 230 0
	testb	%dl, %dl
	movl	$.LC0, %edx
	movl	$.LC1, %esi
	cmovne	%rdx, %rsi
	movl	%r14d, (%rsp)
	movl	%eax, %r9d
	movq	%r13, %r8
	movq	%r12, %rcx
	movq	24(%rsp), %rdx
	movl	$.LC8, %edi
	movl	$0, %eax
.LVL104:
	call	printf
.LVL105:
	jmp	.L61
.LVL106:
.L59:
	addq	$8, %rbp
.LBE18:
	.loc 1 224 0
	cmpq	$test_strings+128, %rbp
	jne	.L64
	jmp	.L67
.LVL107:
.L58:
.LBE17:
.LBE16:
	.loc 1 219 0 discriminator 1
	movl	$test_strings, %ebp
	jmp	.L64
.LVL108:
.L61:
	.loc 1 238 0
	movq	24(%rsp), %rdx
	movl	%r15d, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
.LVL109:
	.loc 1 239 0
	movl	%ebx, %esi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
.LVL110:
	.loc 1 240 0
	movl	%r15d, %esi
	subl	%ebx, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
.LVL111:
	jmp	.L68
.LVL112:
.L67:
	addq	$8, 8(%rsp)
.LBB21:
	.loc 1 223 0
	cmpq	$test_strings+128, 8(%rsp)
	jne	.L58
.LBB20:
.LBB19:
	.loc 1 228 0
	movl	%ebx, %r15d
	jmp	.L61
.LVL113:
.L68:
.LBE19:
.LBE20:
.LBE21:
	.loc 1 241 0
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
.LVL114:
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
.LVL115:
	popq	%r15
	.cfi_def_cfa_offset 8
.LVL116:
	ret
	.cfi_endproc
.LFE27:
	.size	test_contains_string, .-test_contains_string
	.section	.rodata.str1.1
.LC9:
	.string	"substring"
.LC10:
	.string	"compaction"
	.section	.rodata.str1.8
	.align 8
.LC11:
	.string	"[FAIL]  substring(\"%s\", %d, %d) = NULL; expected a string\n"
	.align 8
.LC12:
	.string	"[FAIL]  substring(\"%s\", %d, %d) result is missing '\\0' terminator in expected position\n"
	.align 8
.LC13:
	.string	"[FAIL]  substring(\"%s\", %d, %d) = %s  [FAIL] mismatch at index %d of result\n"
	.align 8
.LC14:
	.string	"[PASS]  substring(\"%s\", %d, %d) = %s; expected %s\n"
	.section	.rodata.str1.1
.LC15:
	.string	"Of  %d tests of %s\n"
.LC16:
	.string	"    %d PASS\n"
.LC17:
	.string	"    %d FAIL\n\n"
	.text
	.globl	test_substring
	.type	test_substring, @function
test_substring:
.LFB28:
	.loc 1 244 0
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.loc 1 245 0
	movl	$.LC9, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
.LVL117:
.LBB22:
	.loc 1 250 0
	movl	$0, 28(%rsp)
	movl	$0, (%rsp)
.LBE22:
	.loc 1 246 0
	movl	$0, %eax
	jmp	.L71
.LVL118:
.L84:
	movl	12(%rsp), %r15d
	addl	4(%rsp), %r15d
.LVL119:
.LBB31:
.LBB23:
.LBB24:
	.loc 1 252 0
	addl	$1, 8(%rsp)
.LVL120:
	.loc 1 253 0
	movl	%r15d, %edx
	movl	(%rsp), %esi
	movl	$.LC10, %edi
	call	substring
.LVL121:
	movq	%rax, %r13
.LVL122:
	.loc 1 254 0
	testq	%rax, %rax
	jne	.L72
	.loc 1 255 0
	movl	%r15d, %ecx
	movl	(%rsp), %edx
	movl	$.LC10, %esi
	movl	$.LC11, %edi
	movl	$0, %eax
.LVL123:
	call	printf
.LVL124:
	.loc 1 257 0
	jmp	.L73
.LVL125:
.L72:
	.loc 1 258 0
	movl	%r14d, %ebp
	movslq	%r14d, %rax
.LVL126:
	cmpb	$0, 0(%r13,%rax)
	jne	.L74
.LVL127:
.LBB25:
	.loc 1 265 0 discriminator 1
	testl	%r14d, %r14d
	jle	.L85
	.loc 1 266 0
	movq	16(%rsp), %rax
	movzbl	.LC10(%rax), %eax
	cmpb	%al, 0(%r13)
	je	.L89
	jmp	.L86
.LVL128:
.L74:
.LBE25:
	.loc 1 259 0
	movl	%r15d, %ecx
	movl	(%rsp), %edx
	movl	$.LC10, %esi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
.LVL129:
	.loc 1 261 0
	movq	%r13, %rdi
	call	free
.LVL130:
	.loc 1 262 0
	jmp	.L73
.LVL131:
.L79:
.LBB26:
	.loc 1 266 0
	movzbl	(%rax), %ecx
	addq	$1, %rax
	leal	(%rbx,%r12), %edx
	movslq	%edx, %rdx
	cmpb	.LC10(%rdx), %cl
	je	.L78
	jmp	.L76
.LVL132:
.L86:
	movl	$0, %ebx
.LVL133:
.L76:
	.loc 1 267 0
	movl	%ebx, %r9d
	movq	%r13, %r8
	movl	%r15d, %ecx
	movl	(%rsp), %edx
	movl	$.LC10, %esi
	movl	$.LC13, %edi
	movl	$0, %eax
	call	printf
.LVL134:
	.loc 1 269 0
	movq	%r13, %rdi
	call	free
.LVL135:
	.loc 1 270 0
	jmp	.L75
.LVL136:
.L89:
	leaq	1(%r13), %rax
	.loc 1 266 0
	movl	$0, %ebx
.LVL137:
.L78:
	.loc 1 265 0
	addl	$1, %ebx
.LVL138:
	cmpl	%ebp, %ebx
	jne	.L79
	jmp	.L80
.LVL139:
.L85:
	movl	$0, %ebx
.LVL140:
.L75:
	.loc 1 273 0
	cmpl	%ebp, %ebx
	jne	.L73
.L80:
	.loc 1 274 0
	movq	%r13, %r9
	movq	%r13, %r8
	movl	%r15d, %ecx
	movl	(%rsp), %edx
	movl	$.LC10, %esi
	movl	$.LC14, %edi
	movl	$0, %eax
	call	printf
.LVL141:
	.loc 1 276 0
	movq	%r13, %rdi
	call	free
.LVL142:
	.loc 1 277 0
	addl	$1, 4(%rsp)
.LVL143:
	addl	$1, %r14d
.LBE26:
.LBE24:
	.loc 1 251 0
	cmpl	24(%rsp), %r14d
	jne	.L84
.LVL144:
.L73:
.LBE23:
	.loc 1 283 0
	movl	8(%rsp), %eax
	cmpl	%eax, 4(%rsp)
	je	.L83
	jmp	.L82
.LVL145:
.L88:
.LBB29:
	.loc 1 251 0
	movl	%eax, 4(%rsp)
.LVL146:
.L83:
.LBE29:
	.loc 1 250 0
	movl	28(%rsp), %eax
	addl	$1, %eax
	movl	%eax, (%rsp)
.LVL147:
	cmpl	$10, %eax
	je	.L87
	movl	%eax, 28(%rsp)
	movl	4(%rsp), %eax
.LVL148:
.L71:
.LBB30:
	.loc 1 251 0 discriminator 1
	movl	(%rsp), %esi
	cmpl	$10, %esi
	jg	.L88
	movl	%esi, %r12d
	movl	$11, %edi
	subl	%esi, %edi
	movl	%edi, 24(%rsp)
	.loc 1 251 0 is_stmt 0
	movl	%eax, 8(%rsp)
	movl	%eax, 4(%rsp)
	movl	$0, %r14d
	movl	%esi, %edi
	subl	%eax, %edi
	movl	%edi, 12(%rsp)
.LBB28:
.LBB27:
	.loc 1 266 0 is_stmt 1
	movslq	%esi, %rax
.LVL149:
	movq	%rax, 16(%rsp)
	jmp	.L84
.LVL150:
.L87:
.LBE27:
.LBE28:
.LBE30:
	movl	4(%rsp), %eax
.LVL151:
	movl	%eax, 8(%rsp)
.LVL152:
.L82:
.LBE31:
	.loc 1 285 0
	movl	$.LC9, %edx
	movl	8(%rsp), %ebx
	movl	%ebx, %esi
	movl	$.LC15, %edi
	movl	$0, %eax
	call	printf
.LVL153:
	.loc 1 286 0
	movl	4(%rsp), %r14d
	movl	%r14d, %esi
	movl	$.LC16, %edi
	movl	$0, %eax
	call	printf
.LVL154:
	.loc 1 287 0
	movl	%ebx, %esi
	subl	%r14d, %esi
	movl	$.LC17, %edi
	movl	$0, %eax
	call	printf
.LVL155:
	.loc 1 288 0
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
.LVL156:
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE28:
	.size	test_substring, .-test_substring
	.section	.rodata.str1.1
.LC18:
	.string	"string_length_a"
.LC19:
	.string	"string_length_p"
.LC20:
	.string	"contains_char_a"
.LC21:
	.string	"contains_char_p"
.LC22:
	.string	"contains_string"
	.text
	.globl	main
	.type	main, @function
main:
.LFB29:
	.loc 1 293 0
	.cfi_startproc
.LVL157:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	.loc 1 295 0
	movl	$string_length_a, %esi
.LVL158:
	movl	$.LC18, %edi
.LVL159:
	call	test_string_length
.LVL160:
	.loc 1 296 0
	movl	$string_length_p, %esi
	movl	$.LC19, %edi
	call	test_string_length
.LVL161:
	.loc 1 299 0
	movl	$contains_char_a, %esi
	movl	$.LC20, %edi
	call	test_contains_char
.LVL162:
	.loc 1 300 0
	movl	$contains_char_p, %esi
	movl	$.LC21, %edi
	call	test_contains_char
.LVL163:
	.loc 1 303 0
	movl	$0, %eax
	call	test_substring
.LVL164:
	.loc 1 306 0
	movl	$contains_string, %esi
	movl	$.LC22, %edi
	call	test_contains_string
.LVL165:
	.loc 1 307 0
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE29:
	.size	main, .-main
	.section	.rodata.str1.1
.LC23:
	.string	"act"
.LC24:
	.string	"actual"
.LC25:
	.string	"face"
.LC26:
	.string	"face the action"
.LC27:
	.string	"face the faction"
.LC28:
	.string	"factual"
.LC29:
	.string	"facet"
.LC30:
	.string	"facetious"
.LC31:
	.string	"face facet"
.LC32:
	.string	"face facts facetiously"
.LC33:
	.string	"effacing"
.LC34:
	.string	"efface"
.LC35:
	.string	"aaabb"
.LC36:
	.string	"aabb"
.LC37:
	.string	""
	.section	.rodata
	.align 32
	.type	test_strings, @object
	.size	test_strings, 128
test_strings:
	.quad	.LC23
	.quad	.LC10
	.quad	.LC24
	.quad	.LC25
	.quad	.LC26
	.quad	.LC27
	.quad	.LC28
	.quad	.LC29
	.quad	.LC30
	.quad	.LC31
	.quad	.LC32
	.quad	.LC33
	.quad	.LC34
	.quad	.LC35
	.quad	.LC36
	.quad	.LC37
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-redhat-linux/4.8.5/include/stddef.h"
	.file 3 "/usr/include/bits/types.h"
	.file 4 "/usr/include/libio.h"
	.file 5 "/usr/include/stdio.h"
	.file 6 "/usr/include/stdlib.h"
	.file 7 "/usr/include/string.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xeba
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF76
	.byte	0x1
	.long	.LASF77
	.long	.LASF78
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF8
	.byte	0x2
	.byte	0xd4
	.long	0x38
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF1
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF2
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF3
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF4
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF5
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0x2
	.long	.LASF9
	.byte	0x3
	.byte	0x8c
	.long	0x46
	.uleb128 0x2
	.long	.LASF10
	.byte	0x3
	.byte	0x8d
	.long	0x46
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF11
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.long	0x9c
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF12
	.uleb128 0x7
	.long	.LASF42
	.byte	0xd8
	.byte	0x4
	.byte	0xf6
	.long	0x224
	.uleb128 0x8
	.long	.LASF13
	.byte	0x4
	.byte	0xf7
	.long	0x3f
	.byte	0
	.uleb128 0x8
	.long	.LASF14
	.byte	0x4
	.byte	0xfc
	.long	0x96
	.byte	0x8
	.uleb128 0x8
	.long	.LASF15
	.byte	0x4
	.byte	0xfd
	.long	0x96
	.byte	0x10
	.uleb128 0x8
	.long	.LASF16
	.byte	0x4
	.byte	0xfe
	.long	0x96
	.byte	0x18
	.uleb128 0x8
	.long	.LASF17
	.byte	0x4
	.byte	0xff
	.long	0x96
	.byte	0x20
	.uleb128 0x9
	.long	.LASF18
	.byte	0x4
	.value	0x100
	.long	0x96
	.byte	0x28
	.uleb128 0x9
	.long	.LASF19
	.byte	0x4
	.value	0x101
	.long	0x96
	.byte	0x30
	.uleb128 0x9
	.long	.LASF20
	.byte	0x4
	.value	0x102
	.long	0x96
	.byte	0x38
	.uleb128 0x9
	.long	.LASF21
	.byte	0x4
	.value	0x103
	.long	0x96
	.byte	0x40
	.uleb128 0x9
	.long	.LASF22
	.byte	0x4
	.value	0x105
	.long	0x96
	.byte	0x48
	.uleb128 0x9
	.long	.LASF23
	.byte	0x4
	.value	0x106
	.long	0x96
	.byte	0x50
	.uleb128 0x9
	.long	.LASF24
	.byte	0x4
	.value	0x107
	.long	0x96
	.byte	0x58
	.uleb128 0x9
	.long	.LASF25
	.byte	0x4
	.value	0x109
	.long	0x25c
	.byte	0x60
	.uleb128 0x9
	.long	.LASF26
	.byte	0x4
	.value	0x10b
	.long	0x262
	.byte	0x68
	.uleb128 0x9
	.long	.LASF27
	.byte	0x4
	.value	0x10d
	.long	0x3f
	.byte	0x70
	.uleb128 0x9
	.long	.LASF28
	.byte	0x4
	.value	0x111
	.long	0x3f
	.byte	0x74
	.uleb128 0x9
	.long	.LASF29
	.byte	0x4
	.value	0x113
	.long	0x77
	.byte	0x78
	.uleb128 0x9
	.long	.LASF30
	.byte	0x4
	.value	0x117
	.long	0x5b
	.byte	0x80
	.uleb128 0x9
	.long	.LASF31
	.byte	0x4
	.value	0x118
	.long	0x69
	.byte	0x82
	.uleb128 0x9
	.long	.LASF32
	.byte	0x4
	.value	0x119
	.long	0x268
	.byte	0x83
	.uleb128 0x9
	.long	.LASF33
	.byte	0x4
	.value	0x11d
	.long	0x278
	.byte	0x88
	.uleb128 0x9
	.long	.LASF34
	.byte	0x4
	.value	0x126
	.long	0x82
	.byte	0x90
	.uleb128 0x9
	.long	.LASF35
	.byte	0x4
	.value	0x12f
	.long	0x94
	.byte	0x98
	.uleb128 0x9
	.long	.LASF36
	.byte	0x4
	.value	0x130
	.long	0x94
	.byte	0xa0
	.uleb128 0x9
	.long	.LASF37
	.byte	0x4
	.value	0x131
	.long	0x94
	.byte	0xa8
	.uleb128 0x9
	.long	.LASF38
	.byte	0x4
	.value	0x132
	.long	0x94
	.byte	0xb0
	.uleb128 0x9
	.long	.LASF39
	.byte	0x4
	.value	0x133
	.long	0x2d
	.byte	0xb8
	.uleb128 0x9
	.long	.LASF40
	.byte	0x4
	.value	0x135
	.long	0x3f
	.byte	0xc0
	.uleb128 0x9
	.long	.LASF41
	.byte	0x4
	.value	0x137
	.long	0x27e
	.byte	0xc4
	.byte	0
	.uleb128 0xa
	.long	.LASF79
	.byte	0x4
	.byte	0x9b
	.uleb128 0x7
	.long	.LASF43
	.byte	0x18
	.byte	0x4
	.byte	0xa1
	.long	0x25c
	.uleb128 0x8
	.long	.LASF44
	.byte	0x4
	.byte	0xa2
	.long	0x25c
	.byte	0
	.uleb128 0x8
	.long	.LASF45
	.byte	0x4
	.byte	0xa3
	.long	0x262
	.byte	0x8
	.uleb128 0x8
	.long	.LASF46
	.byte	0x4
	.byte	0xa7
	.long	0x3f
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x22b
	.uleb128 0x6
	.byte	0x8
	.long	0xa3
	.uleb128 0xb
	.long	0x9c
	.long	0x278
	.uleb128 0xc
	.long	0x8d
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x224
	.uleb128 0xb
	.long	0x9c
	.long	0x28e
	.uleb128 0xc
	.long	0x8d
	.byte	0x13
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x294
	.uleb128 0xd
	.long	0x9c
	.uleb128 0xe
	.long	.LASF47
	.byte	0x1
	.byte	0x17
	.long	0x3f
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0x2d7
	.uleb128 0xf
	.string	"str"
	.byte	0x1
	.byte	0x17
	.long	0x96
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x10
	.long	.LASF49
	.byte	0x1
	.byte	0x18
	.long	0x3f
	.long	.LLST0
	.byte	0
	.uleb128 0xe
	.long	.LASF48
	.byte	0x1
	.byte	0x28
	.long	0x3f
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0x315
	.uleb128 0xf
	.string	"str"
	.byte	0x1
	.byte	0x28
	.long	0x96
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x10
	.long	.LASF50
	.byte	0x1
	.byte	0x29
	.long	0x96
	.long	.LLST1
	.byte	0
	.uleb128 0xe
	.long	.LASF51
	.byte	0x1
	.byte	0x3b
	.long	0x3f
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0x362
	.uleb128 0x11
	.long	.LASF52
	.byte	0x1
	.byte	0x3b
	.long	0x96
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x12
	.long	.LASF53
	.byte	0x1
	.byte	0x3b
	.long	0x9c
	.long	.LLST2
	.uleb128 0x10
	.long	.LASF50
	.byte	0x1
	.byte	0x3c
	.long	0x3f
	.long	.LLST3
	.byte	0
	.uleb128 0xe
	.long	.LASF54
	.byte	0x1
	.byte	0x50
	.long	0x3f
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x3af
	.uleb128 0x12
	.long	.LASF52
	.byte	0x1
	.byte	0x50
	.long	0x96
	.long	.LLST4
	.uleb128 0x12
	.long	.LASF53
	.byte	0x1
	.byte	0x50
	.long	0x9c
	.long	.LLST5
	.uleb128 0x13
	.long	.LASF50
	.byte	0x1
	.byte	0x51
	.long	0x96
	.uleb128 0x1
	.byte	0x55
	.byte	0
	.uleb128 0xe
	.long	.LASF55
	.byte	0x1
	.byte	0x81
	.long	0x3f
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x40f
	.uleb128 0x11
	.long	.LASF52
	.byte	0x1
	.byte	0x81
	.long	0x96
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x11
	.long	.LASF53
	.byte	0x1
	.byte	0x81
	.long	0x96
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x10
	.long	.LASF50
	.byte	0x1
	.byte	0x85
	.long	0x3f
	.long	.LLST6
	.uleb128 0x14
	.long	.Ldebug_ranges0+0
	.uleb128 0x10
	.long	.LASF56
	.byte	0x1
	.byte	0x87
	.long	0x3f
	.long	.LLST7
	.byte	0
	.byte	0
	.uleb128 0xe
	.long	.LASF57
	.byte	0x1
	.byte	0x6b
	.long	0x96
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x4b1
	.uleb128 0x12
	.long	.LASF52
	.byte	0x1
	.byte	0x6b
	.long	0x96
	.long	.LLST8
	.uleb128 0x12
	.long	.LASF58
	.byte	0x1
	.byte	0x6b
	.long	0x3f
	.long	.LLST9
	.uleb128 0x15
	.string	"end"
	.byte	0x1
	.byte	0x6b
	.long	0x3f
	.long	.LLST10
	.uleb128 0x16
	.string	"str"
	.byte	0x1
	.byte	0x6c
	.long	0x96
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x17
	.quad	.LBB6
	.quad	.LBE6-.LBB6
	.long	0x48d
	.uleb128 0x18
	.string	"i"
	.byte	0x1
	.byte	0x6d
	.long	0x3f
	.long	.LLST11
	.byte	0
	.uleb128 0x19
	.quad	.LVL42
	.long	0xe67
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x11
	.byte	0x76
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x1c
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF62
	.byte	0x1
	.byte	0xa9
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0x632
	.uleb128 0x12
	.long	.LASF59
	.byte	0x1
	.byte	0xa9
	.long	0x96
	.long	.LLST12
	.uleb128 0x15
	.string	"fp"
	.byte	0x1
	.byte	0xa9
	.long	0x641
	.long	.LLST13
	.uleb128 0x10
	.long	.LASF60
	.byte	0x1
	.byte	0xab
	.long	0x3f
	.long	.LLST14
	.uleb128 0x10
	.long	.LASF61
	.byte	0x1
	.byte	0xac
	.long	0x3f
	.long	.LLST15
	.uleb128 0x17
	.quad	.LBB7
	.quad	.LBE7-.LBB7
	.long	0x594
	.uleb128 0x18
	.string	"i"
	.byte	0x1
	.byte	0xad
	.long	0x3f
	.long	.LLST16
	.uleb128 0x14
	.long	.Ldebug_ranges0+0x50
	.uleb128 0x18
	.string	"len"
	.byte	0x1
	.byte	0xaf
	.long	0x3f
	.long	.LLST17
	.uleb128 0x18
	.string	"s"
	.byte	0x1
	.byte	0xb0
	.long	0x3f
	.long	.LLST18
	.uleb128 0x1c
	.quad	.LVL56
	.long	0x560
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL59
	.long	0xe7d
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC3
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x91
	.sleb128 -72
	.byte	0x6
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x5
	.byte	0x91
	.sleb128 -76
	.byte	0x94
	.byte	0x4
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL52
	.long	0xe7d
	.long	0x5bb
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x4
	.byte	0x91
	.sleb128 -72
	.byte	0x6
	.byte	0
	.uleb128 0x1d
	.quad	.LVL62
	.long	0xe7d
	.long	0x5e8
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x7e
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x91
	.sleb128 -72
	.byte	0x6
	.byte	0
	.uleb128 0x1d
	.quad	.LVL63
	.long	0xe7d
	.long	0x60d
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC5
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL64
	.long	0xe7d
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x5
	.byte	0x7e
	.sleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x1c
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x3f
	.long	0x641
	.uleb128 0x1f
	.long	0x96
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x632
	.uleb128 0x1b
	.long	.LASF63
	.byte	0x1
	.byte	0xbf
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.long	0x82d
	.uleb128 0x12
	.long	.LASF59
	.byte	0x1
	.byte	0xbf
	.long	0x96
	.long	.LLST19
	.uleb128 0x15
	.string	"fp"
	.byte	0x1
	.byte	0xbf
	.long	0x841
	.long	.LLST20
	.uleb128 0x10
	.long	.LASF60
	.byte	0x1
	.byte	0xc1
	.long	0x3f
	.long	.LLST21
	.uleb128 0x10
	.long	.LASF61
	.byte	0x1
	.byte	0xc2
	.long	0x3f
	.long	.LLST22
	.uleb128 0x20
	.long	.Ldebug_ranges0+0x80
	.long	0x78f
	.uleb128 0x18
	.string	"i"
	.byte	0x1
	.byte	0xc3
	.long	0x3f
	.long	.LLST23
	.uleb128 0x21
	.quad	.LBB11
	.quad	.LBE11-.LBB11
	.uleb128 0x13
	.long	.LASF53
	.byte	0x1
	.byte	0xc4
	.long	0x847
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x21
	.quad	.LBB12
	.quad	.LBE12-.LBB12
	.uleb128 0x18
	.string	"c"
	.byte	0x1
	.byte	0xc6
	.long	0x9c
	.long	.LLST24
	.uleb128 0x14
	.long	.Ldebug_ranges0+0xb0
	.uleb128 0x10
	.long	.LASF64
	.byte	0x1
	.byte	0xc9
	.long	0x3f
	.long	.LLST25
	.uleb128 0x18
	.string	"s"
	.byte	0x1
	.byte	0xca
	.long	0x3f
	.long	.LLST26
	.uleb128 0x1d
	.quad	.LVL77
	.long	0xe94
	.long	0x733
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.byte	0
	.uleb128 0x22
	.quad	.LVL79
	.uleb128 0x4
	.byte	0x91
	.sleb128 -96
	.byte	0x6
	.long	0x752
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL82
	.long	0xe7d
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x91
	.sleb128 -88
	.byte	0x6
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x5
	.byte	0x91
	.sleb128 -100
	.byte	0x94
	.byte	0x4
	.uleb128 0x1a
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL72
	.long	0xe7d
	.long	0x7b6
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x4
	.byte	0x91
	.sleb128 -88
	.byte	0x6
	.byte	0
	.uleb128 0x1d
	.quad	.LVL86
	.long	0xe7d
	.long	0x7e3
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x7e
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x91
	.sleb128 -88
	.byte	0x6
	.byte	0
	.uleb128 0x1d
	.quad	.LVL87
	.long	0xe7d
	.long	0x808
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC5
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL88
	.long	0xe7d
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x5
	.byte	0x7e
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1c
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x3f
	.long	0x841
	.uleb128 0x1f
	.long	0x96
	.uleb128 0x1f
	.long	0x9c
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x82d
	.uleb128 0xb
	.long	0x9c
	.long	0x857
	.uleb128 0xc
	.long	0x8d
	.byte	0x1
	.byte	0
	.uleb128 0x1b
	.long	.LASF65
	.byte	0x1
	.byte	0xdb
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.long	0xa0c
	.uleb128 0x12
	.long	.LASF59
	.byte	0x1
	.byte	0xdb
	.long	0x96
	.long	.LLST27
	.uleb128 0x15
	.string	"fp"
	.byte	0x1
	.byte	0xdb
	.long	0xa20
	.long	.LLST28
	.uleb128 0x10
	.long	.LASF60
	.byte	0x1
	.byte	0xdd
	.long	0x3f
	.long	.LLST29
	.uleb128 0x10
	.long	.LASF61
	.byte	0x1
	.byte	0xde
	.long	0x3f
	.long	.LLST30
	.uleb128 0x20
	.long	.Ldebug_ranges0+0xe0
	.long	0x96e
	.uleb128 0x18
	.string	"i"
	.byte	0x1
	.byte	0xdf
	.long	0x3f
	.long	.LLST31
	.uleb128 0x14
	.long	.Ldebug_ranges0+0x110
	.uleb128 0x18
	.string	"j"
	.byte	0x1
	.byte	0xe0
	.long	0x3f
	.long	.LLST32
	.uleb128 0x14
	.long	.Ldebug_ranges0+0x140
	.uleb128 0x10
	.long	.LASF64
	.byte	0x1
	.byte	0xe2
	.long	0x3f
	.long	.LLST33
	.uleb128 0x18
	.string	"s"
	.byte	0x1
	.byte	0xe3
	.long	0x3f
	.long	.LLST34
	.uleb128 0x1d
	.quad	.LVL100
	.long	0xe94
	.long	0x916
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.uleb128 0x22
	.quad	.LVL102
	.uleb128 0x4
	.byte	0x91
	.sleb128 -80
	.byte	0x6
	.long	0x935
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL105
	.long	0xe7d
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC8
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x91
	.sleb128 -72
	.byte	0x6
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.uleb128 0x2
	.byte	0x7e
	.sleb128 0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL97
	.long	0xe7d
	.long	0x995
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x4
	.byte	0x91
	.sleb128 -72
	.byte	0x6
	.byte	0
	.uleb128 0x1d
	.quad	.LVL109
	.long	0xe7d
	.long	0x9c2
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x7f
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x91
	.sleb128 -72
	.byte	0x6
	.byte	0
	.uleb128 0x1d
	.quad	.LVL110
	.long	0xe7d
	.long	0x9e7
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC5
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL111
	.long	0xe7d
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x5
	.byte	0x7f
	.sleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x1c
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x3f
	.long	0xa20
	.uleb128 0x1f
	.long	0x96
	.uleb128 0x1f
	.long	0x96
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0xa0c
	.uleb128 0x23
	.long	.LASF80
	.byte	0x1
	.byte	0xf4
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.long	0xcf9
	.uleb128 0x10
	.long	.LASF60
	.byte	0x1
	.byte	0xf6
	.long	0x3f
	.long	.LLST35
	.uleb128 0x10
	.long	.LASF61
	.byte	0x1
	.byte	0xf7
	.long	0x3f
	.long	.LLST36
	.uleb128 0x16
	.string	"str"
	.byte	0x1
	.byte	0xf8
	.long	0x96
	.uleb128 0xa
	.byte	0x3
	.quad	.LC10
	.byte	0x9f
	.uleb128 0x24
	.string	"len"
	.byte	0x1
	.byte	0xf9
	.long	0x3f
	.byte	0xa
	.uleb128 0x20
	.long	.Ldebug_ranges0+0x170
	.long	0xc4b
	.uleb128 0x10
	.long	.LASF58
	.byte	0x1
	.byte	0xfa
	.long	0x3f
	.long	.LLST37
	.uleb128 0x14
	.long	.Ldebug_ranges0+0x1a0
	.uleb128 0x18
	.string	"end"
	.byte	0x1
	.byte	0xfb
	.long	0x3f
	.long	.LLST38
	.uleb128 0x14
	.long	.Ldebug_ranges0+0x1e0
	.uleb128 0x10
	.long	.LASF66
	.byte	0x1
	.byte	0xfd
	.long	0x96
	.long	.LLST39
	.uleb128 0x20
	.long	.Ldebug_ranges0+0x210
	.long	0xb93
	.uleb128 0x25
	.string	"i"
	.byte	0x1
	.value	0x108
	.long	0x3f
	.long	.LLST40
	.uleb128 0x1d
	.quad	.LVL134
	.long	0xe7d
	.long	0xb20
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC13
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x77
	.sleb128 0
	.byte	0x94
	.byte	0x4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7f
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL135
	.long	0xeaf
	.long	0xb38
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL141
	.long	0xe7d
	.long	0xb7e
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC14
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x77
	.sleb128 0
	.byte	0x94
	.byte	0x4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7f
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL142
	.long	0xeaf
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL121
	.long	0x40f
	.long	0xbc0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x4
	.byte	0x77
	.sleb128 0
	.byte	0x94
	.byte	0x4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7f
	.sleb128 0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL124
	.long	0xe7d
	.long	0xbfa
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC11
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x77
	.sleb128 0
	.byte	0x94
	.byte	0x4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7f
	.sleb128 0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL129
	.long	0xe7d
	.long	0xc34
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC12
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x77
	.sleb128 0
	.byte	0x94
	.byte	0x4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7f
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL130
	.long	0xeaf
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1d
	.quad	.LVL117
	.long	0xe7d
	.long	0xc77
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC9
	.byte	0
	.uleb128 0x1d
	.quad	.LVL153
	.long	0xe7d
	.long	0xcac
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC15
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x5
	.byte	0x91
	.sleb128 -88
	.byte	0x94
	.byte	0x4
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	.LC9
	.byte	0
	.uleb128 0x1d
	.quad	.LVL154
	.long	0xe7d
	.long	0xcd1
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC16
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x7e
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL155
	.long	0xe7d
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC17
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x8
	.byte	0x91
	.sleb128 -88
	.byte	0x94
	.byte	0x4
	.byte	0x7e
	.sleb128 0
	.byte	0x1c
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	.LASF67
	.byte	0x1
	.value	0x125
	.long	0x3f
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.long	0xe21
	.uleb128 0x27
	.long	.LASF68
	.byte	0x1
	.value	0x125
	.long	0x3f
	.long	.LLST41
	.uleb128 0x27
	.long	.LASF69
	.byte	0x1
	.value	0x125
	.long	0xe21
	.long	.LLST42
	.uleb128 0x1d
	.quad	.LVL160
	.long	0x4b1
	.long	0xd67
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC18
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	string_length_a
	.byte	0
	.uleb128 0x1d
	.quad	.LVL161
	.long	0x4b1
	.long	0xd93
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC19
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	string_length_p
	.byte	0
	.uleb128 0x1d
	.quad	.LVL162
	.long	0x647
	.long	0xdbf
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC20
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	contains_char_a
	.byte	0
	.uleb128 0x1d
	.quad	.LVL163
	.long	0x647
	.long	0xdeb
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC21
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	contains_char_p
	.byte	0
	.uleb128 0x28
	.quad	.LVL164
	.long	0xa26
	.uleb128 0x19
	.quad	.LVL165
	.long	0x857
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC22
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	contains_string
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x96
	.uleb128 0xb
	.long	0x96
	.long	0xe37
	.uleb128 0xc
	.long	0x8d
	.byte	0xf
	.byte	0
	.uleb128 0x13
	.long	.LASF70
	.byte	0x1
	.byte	0x95
	.long	0xe4c
	.uleb128 0x9
	.byte	0x3
	.quad	test_strings
	.uleb128 0xd
	.long	0xe27
	.uleb128 0x29
	.long	.LASF71
	.byte	0x5
	.byte	0xa8
	.long	0x262
	.uleb128 0x29
	.long	.LASF72
	.byte	0x5
	.byte	0xa9
	.long	0x262
	.uleb128 0x2a
	.long	.LASF73
	.byte	0x6
	.value	0x1d1
	.long	0x94
	.long	0xe7d
	.uleb128 0x1f
	.long	0x2d
	.byte	0
	.uleb128 0x2a
	.long	.LASF74
	.byte	0x5
	.value	0x16a
	.long	0x3f
	.long	0xe94
	.uleb128 0x1f
	.long	0x28e
	.uleb128 0x2b
	.byte	0
	.uleb128 0x2a
	.long	.LASF75
	.byte	0x7
	.value	0x152
	.long	0x96
	.long	0xeaf
	.uleb128 0x1f
	.long	0x28e
	.uleb128 0x1f
	.long	0x28e
	.byte	0
	.uleb128 0x2c
	.long	.LASF81
	.byte	0x6
	.value	0x1e2
	.uleb128 0x1f
	.long	0x94
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2113
	.uleb128 0x18
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.quad	.LVL0-.Ltext0
	.quad	.LVL1-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL1-.Ltext0
	.quad	.LVL3-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL3-.Ltext0
	.quad	.LFE19-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST1:
	.quad	.LVL4-.Ltext0
	.quad	.LVL5-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL5-.Ltext0
	.quad	.LVL7-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL7-.Ltext0
	.quad	.LVL8-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL8-.Ltext0
	.quad	.LVL9-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST2:
	.quad	.LVL10-.Ltext0
	.quad	.LVL13-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL13-.Ltext0
	.quad	.LFE21-.Ltext0
	.value	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST3:
	.quad	.LVL11-.Ltext0
	.quad	.LVL12-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL12-.Ltext0
	.quad	.LVL15-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL16-.Ltext0
	.quad	.LVL17-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL17-.Ltext0
	.quad	.LVL18-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST4:
	.quad	.LVL19-.Ltext0
	.quad	.LVL21-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL21-.Ltext0
	.quad	.LVL24-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	.LVL24-.Ltext0
	.quad	.LVL25-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL25-.Ltext0
	.quad	.LFE22-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LLST5:
	.quad	.LVL19-.Ltext0
	.quad	.LVL22-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL22-.Ltext0
	.quad	.LFE22-.Ltext0
	.value	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST6:
	.quad	.LVL27-.Ltext0
	.quad	.LVL28-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL28-.Ltext0
	.quad	.LVL34-.Ltext0
	.value	0x1
	.byte	0x58
	.quad	.LVL34-.Ltext0
	.quad	.LVL35-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL35-.Ltext0
	.quad	.LVL39-.Ltext0
	.value	0x1
	.byte	0x58
	.quad	0
	.quad	0
.LLST7:
	.quad	.LVL28-.Ltext0
	.quad	.LVL31-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL33-.Ltext0
	.quad	.LVL34-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL35-.Ltext0
	.quad	.LVL36-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL36-.Ltext0
	.quad	.LVL37-.Ltext0
	.value	0x1
	.byte	0x51
	.quad	.LVL38-.Ltext0
	.quad	.LVL39-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST8:
	.quad	.LVL40-.Ltext0
	.quad	.LVL41-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL41-.Ltext0
	.quad	.LVL48-.Ltext0
	.value	0x1
	.byte	0x5c
	.quad	.LVL48-.Ltext0
	.quad	.LFE23-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LLST9:
	.quad	.LVL40-.Ltext0
	.quad	.LVL42-1-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL42-1-.Ltext0
	.quad	.LVL47-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL47-.Ltext0
	.quad	.LFE23-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	0
	.quad	0
.LLST10:
	.quad	.LVL40-.Ltext0
	.quad	.LVL42-1-.Ltext0
	.value	0x1
	.byte	0x51
	.quad	.LVL42-1-.Ltext0
	.quad	.LVL46-.Ltext0
	.value	0x1
	.byte	0x56
	.quad	.LVL46-.Ltext0
	.quad	.LFE23-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST11:
	.quad	.LVL42-.Ltext0
	.quad	.LVL43-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL43-.Ltext0
	.quad	.LVL45-.Ltext0
	.value	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST12:
	.quad	.LVL49-.Ltext0
	.quad	.LVL51-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL51-.Ltext0
	.quad	.LVL52-1-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL52-1-.Ltext0
	.quad	.LFE25-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -72
	.quad	0
	.quad	0
.LLST13:
	.quad	.LVL49-.Ltext0
	.quad	.LVL50-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL50-.Ltext0
	.quad	.LVL68-.Ltext0
	.value	0x1
	.byte	0x5f
	.quad	.LVL68-.Ltext0
	.quad	.LFE25-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	0
	.quad	0
.LLST14:
	.quad	.LVL52-.Ltext0
	.quad	.LVL53-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL53-.Ltext0
	.quad	.LVL65-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LLST15:
	.quad	.LVL52-.Ltext0
	.quad	.LVL53-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL53-.Ltext0
	.quad	.LVL54-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL54-.Ltext0
	.quad	.LVL60-.Ltext0
	.value	0x1
	.byte	0x5e
	.quad	.LVL60-.Ltext0
	.quad	.LVL61-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL61-.Ltext0
	.quad	.LVL67-.Ltext0
	.value	0x1
	.byte	0x5e
	.quad	0
	.quad	0
.LLST16:
	.quad	.LVL52-.Ltext0
	.quad	.LVL53-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST17:
	.quad	.LVL55-.Ltext0
	.quad	.LVL66-.Ltext0
	.value	0x1
	.byte	0x5d
	.quad	.LVL66-.Ltext0
	.quad	.LFE25-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -76
	.quad	0
	.quad	0
.LLST18:
	.quad	.LVL56-.Ltext0
	.quad	.LVL58-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL58-.Ltext0
	.quad	.LVL59-1-.Ltext0
	.value	0x1
	.byte	0x58
	.quad	.LVL60-.Ltext0
	.quad	.LVL61-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST19:
	.quad	.LVL69-.Ltext0
	.quad	.LVL71-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL71-.Ltext0
	.quad	.LVL72-1-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL72-1-.Ltext0
	.quad	.LFE26-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -88
	.quad	0
	.quad	0
.LLST20:
	.quad	.LVL69-.Ltext0
	.quad	.LVL70-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL70-.Ltext0
	.quad	.LFE26-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -96
	.quad	0
	.quad	0
.LLST21:
	.quad	.LVL72-.Ltext0
	.quad	.LVL73-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL73-.Ltext0
	.quad	.LVL91-.Ltext0
	.value	0x1
	.byte	0x56
	.quad	0
	.quad	0
.LLST22:
	.quad	.LVL72-.Ltext0
	.quad	.LVL73-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL73-.Ltext0
	.quad	.LVL76-.Ltext0
	.value	0x1
	.byte	0x56
	.quad	.LVL76-.Ltext0
	.quad	.LVL83-.Ltext0
	.value	0x1
	.byte	0x5e
	.quad	.LVL83-.Ltext0
	.quad	.LVL85-.Ltext0
	.value	0x1
	.byte	0x56
	.quad	.LVL85-.Ltext0
	.quad	.LVL89-.Ltext0
	.value	0x1
	.byte	0x5e
	.quad	.LVL89-.Ltext0
	.quad	.LVL90-.Ltext0
	.value	0x1
	.byte	0x56
	.quad	.LVL90-.Ltext0
	.quad	.LVL93-.Ltext0
	.value	0x1
	.byte	0x5e
	.quad	0
	.quad	0
.LLST23:
	.quad	.LVL72-.Ltext0
	.quad	.LVL73-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST24:
	.quad	.LVL74-.Ltext0
	.quad	.LVL75-.Ltext0
	.value	0x3
	.byte	0x8
	.byte	0x61
	.byte	0x9f
	.quad	.LVL75-.Ltext0
	.quad	.LVL83-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL83-.Ltext0
	.quad	.LVL84-.Ltext0
	.value	0x3
	.byte	0x73
	.sleb128 1
	.byte	0x9f
	.quad	0
	.quad	0
.LLST25:
	.quad	.LVL78-.Ltext0
	.quad	.LVL92-.Ltext0
	.value	0x1
	.byte	0x5d
	.quad	0
	.quad	0
.LLST26:
	.quad	.LVL79-.Ltext0
	.quad	.LVL81-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL81-.Ltext0
	.quad	.LVL82-1-.Ltext0
	.value	0x1
	.byte	0x59
	.quad	.LVL83-.Ltext0
	.quad	.LVL85-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL89-.Ltext0
	.quad	.LVL90-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST27:
	.quad	.LVL94-.Ltext0
	.quad	.LVL96-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL96-.Ltext0
	.quad	.LVL97-1-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL97-1-.Ltext0
	.quad	.LFE27-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -72
	.quad	0
	.quad	0
.LLST28:
	.quad	.LVL94-.Ltext0
	.quad	.LVL95-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL95-.Ltext0
	.quad	.LFE27-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -80
	.quad	0
	.quad	0
.LLST29:
	.quad	.LVL97-.Ltext0
	.quad	.LVL98-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL98-.Ltext0
	.quad	.LVL114-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LLST30:
	.quad	.LVL97-.Ltext0
	.quad	.LVL98-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL98-.Ltext0
	.quad	.LVL99-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL99-.Ltext0
	.quad	.LVL106-.Ltext0
	.value	0x1
	.byte	0x5f
	.quad	.LVL106-.Ltext0
	.quad	.LVL108-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL108-.Ltext0
	.quad	.LVL112-.Ltext0
	.value	0x1
	.byte	0x5f
	.quad	.LVL112-.Ltext0
	.quad	.LVL113-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL113-.Ltext0
	.quad	.LVL116-.Ltext0
	.value	0x1
	.byte	0x5f
	.quad	0
	.quad	0
.LLST31:
	.quad	.LVL97-.Ltext0
	.quad	.LVL98-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST32:
	.quad	.LVL107-.Ltext0
	.quad	.LVL108-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST33:
	.quad	.LVL101-.Ltext0
	.quad	.LVL107-.Ltext0
	.value	0x1
	.byte	0x5e
	.quad	.LVL108-.Ltext0
	.quad	.LVL115-.Ltext0
	.value	0x1
	.byte	0x5e
	.quad	0
	.quad	0
.LLST34:
	.quad	.LVL102-.Ltext0
	.quad	.LVL104-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL104-.Ltext0
	.quad	.LVL105-1-.Ltext0
	.value	0x1
	.byte	0x59
	.quad	.LVL106-.Ltext0
	.quad	.LVL107-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL112-.Ltext0
	.quad	.LVL113-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST35:
	.quad	.LVL117-.Ltext0
	.quad	.LVL118-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL118-.Ltext0
	.quad	.LVL145-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -92
	.quad	.LVL145-.Ltext0
	.quad	.LVL146-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL146-.Ltext0
	.quad	.LVL148-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -92
	.quad	.LVL148-.Ltext0
	.quad	.LVL149-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL149-.Ltext0
	.quad	.LFE28-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -92
	.quad	0
	.quad	0
.LLST36:
	.quad	.LVL117-.Ltext0
	.quad	.LVL118-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL118-.Ltext0
	.quad	.LVL145-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -88
	.quad	.LVL145-.Ltext0
	.quad	.LVL146-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL147-.Ltext0
	.quad	.LVL148-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -92
	.quad	.LVL148-.Ltext0
	.quad	.LVL149-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL149-.Ltext0
	.quad	.LVL152-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -92
	.quad	.LVL152-.Ltext0
	.quad	.LFE28-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -88
	.quad	0
	.quad	0
.LLST37:
	.quad	.LVL117-.Ltext0
	.quad	.LVL118-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL118-.Ltext0
	.quad	.LVL145-.Ltext0
	.value	0x1
	.byte	0x5c
	.quad	.LVL145-.Ltext0
	.quad	.LVL146-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL146-.Ltext0
	.quad	.LVL147-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 0
	.quad	.LVL147-.Ltext0
	.quad	.LVL148-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL148-.Ltext0
	.quad	.LVL150-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 0
	.quad	.LVL150-.Ltext0
	.quad	.LVL151-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL151-.Ltext0
	.quad	.LVL156-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 0
	.quad	.LVL156-.Ltext0
	.quad	.LFE28-.Ltext0
	.value	0x3
	.byte	0x91
	.sleb128 -96
	.quad	0
	.quad	0
.LLST38:
	.quad	.LVL119-.Ltext0
	.quad	.LVL143-.Ltext0
	.value	0x1
	.byte	0x5f
	.quad	.LVL143-.Ltext0
	.quad	.LVL144-.Ltext0
	.value	0xa
	.byte	0x77
	.sleb128 0
	.byte	0x94
	.byte	0x4
	.byte	0x76
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x1
	.byte	0x9f
	.quad	.LVL145-.Ltext0
	.quad	.LVL146-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL148-.Ltext0
	.quad	.LVL150-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 0
	.quad	0
	.quad	0
.LLST39:
	.quad	.LVL122-.Ltext0
	.quad	.LVL123-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL123-.Ltext0
	.quad	.LVL125-.Ltext0
	.value	0x1
	.byte	0x5d
	.quad	.LVL125-.Ltext0
	.quad	.LVL126-.Ltext0
	.value	0x1
	.byte	0x50
	.quad	.LVL126-.Ltext0
	.quad	.LVL145-.Ltext0
	.value	0x1
	.byte	0x5d
	.quad	0
	.quad	0
.LLST40:
	.quad	.LVL127-.Ltext0
	.quad	.LVL128-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL131-.Ltext0
	.quad	.LVL132-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL132-.Ltext0
	.quad	.LVL133-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL136-.Ltext0
	.quad	.LVL137-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL137-.Ltext0
	.quad	.LVL139-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	.LVL139-.Ltext0
	.quad	.LVL140-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST41:
	.quad	.LVL157-.Ltext0
	.quad	.LVL159-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL159-.Ltext0
	.quad	.LFE29-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LLST42:
	.quad	.LVL157-.Ltext0
	.quad	.LVL158-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL158-.Ltext0
	.quad	.LFE29-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	0
	.quad	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.LBB2-.Ltext0
	.quad	.LBE2-.Ltext0
	.quad	.LBB3-.Ltext0
	.quad	.LBE3-.Ltext0
	.quad	.LBB4-.Ltext0
	.quad	.LBE4-.Ltext0
	.quad	.LBB5-.Ltext0
	.quad	.LBE5-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB8-.Ltext0
	.quad	.LBE8-.Ltext0
	.quad	.LBB9-.Ltext0
	.quad	.LBE9-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB10-.Ltext0
	.quad	.LBE10-.Ltext0
	.quad	.LBB15-.Ltext0
	.quad	.LBE15-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB13-.Ltext0
	.quad	.LBE13-.Ltext0
	.quad	.LBB14-.Ltext0
	.quad	.LBE14-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB16-.Ltext0
	.quad	.LBE16-.Ltext0
	.quad	.LBB21-.Ltext0
	.quad	.LBE21-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB17-.Ltext0
	.quad	.LBE17-.Ltext0
	.quad	.LBB20-.Ltext0
	.quad	.LBE20-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB18-.Ltext0
	.quad	.LBE18-.Ltext0
	.quad	.LBB19-.Ltext0
	.quad	.LBE19-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB22-.Ltext0
	.quad	.LBE22-.Ltext0
	.quad	.LBB31-.Ltext0
	.quad	.LBE31-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB23-.Ltext0
	.quad	.LBE23-.Ltext0
	.quad	.LBB29-.Ltext0
	.quad	.LBE29-.Ltext0
	.quad	.LBB30-.Ltext0
	.quad	.LBE30-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB24-.Ltext0
	.quad	.LBE24-.Ltext0
	.quad	.LBB28-.Ltext0
	.quad	.LBE28-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB25-.Ltext0
	.quad	.LBE25-.Ltext0
	.quad	.LBB26-.Ltext0
	.quad	.LBE26-.Ltext0
	.quad	.LBB27-.Ltext0
	.quad	.LBE27-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF21:
	.string	"_IO_buf_end"
.LASF66:
	.string	"result"
.LASF29:
	.string	"_old_offset"
.LASF77:
	.string	"practice.c"
.LASF76:
	.string	"GNU C 4.8.5 20150623 (Red Hat 4.8.5-39) -m64 -mtune=generic -march=x86-64 -g -O -std=c99"
.LASF56:
	.string	"cursor2"
.LASF24:
	.string	"_IO_save_end"
.LASF7:
	.string	"short int"
.LASF8:
	.string	"size_t"
.LASF80:
	.string	"test_substring"
.LASF11:
	.string	"sizetype"
.LASF34:
	.string	"_offset"
.LASF18:
	.string	"_IO_write_ptr"
.LASF13:
	.string	"_flags"
.LASF64:
	.string	"contains"
.LASF20:
	.string	"_IO_buf_base"
.LASF25:
	.string	"_markers"
.LASF15:
	.string	"_IO_read_end"
.LASF81:
	.string	"free"
.LASF53:
	.string	"needle"
.LASF2:
	.string	"long long int"
.LASF73:
	.string	"malloc"
.LASF33:
	.string	"_lock"
.LASF1:
	.string	"long int"
.LASF57:
	.string	"substring"
.LASF30:
	.string	"_cur_column"
.LASF46:
	.string	"_pos"
.LASF69:
	.string	"argv"
.LASF45:
	.string	"_sbuf"
.LASF42:
	.string	"_IO_FILE"
.LASF51:
	.string	"contains_char_a"
.LASF3:
	.string	"unsigned char"
.LASF50:
	.string	"cursor"
.LASF49:
	.string	"counter"
.LASF38:
	.string	"__pad4"
.LASF68:
	.string	"argc"
.LASF6:
	.string	"signed char"
.LASF48:
	.string	"string_length_p"
.LASF54:
	.string	"contains_char_p"
.LASF55:
	.string	"contains_string"
.LASF5:
	.string	"unsigned int"
.LASF43:
	.string	"_IO_marker"
.LASF32:
	.string	"_shortbuf"
.LASF70:
	.string	"test_strings"
.LASF17:
	.string	"_IO_write_base"
.LASF41:
	.string	"_unused2"
.LASF59:
	.string	"fname"
.LASF14:
	.string	"_IO_read_ptr"
.LASF58:
	.string	"start"
.LASF4:
	.string	"short unsigned int"
.LASF60:
	.string	"pass"
.LASF12:
	.string	"char"
.LASF67:
	.string	"main"
.LASF44:
	.string	"_next"
.LASF35:
	.string	"__pad1"
.LASF36:
	.string	"__pad2"
.LASF37:
	.string	"__pad3"
.LASF78:
	.string	"/students/sk1/cs240-repos/cmemory"
.LASF39:
	.string	"__pad5"
.LASF52:
	.string	"haystack"
.LASF0:
	.string	"long unsigned int"
.LASF19:
	.string	"_IO_write_end"
.LASF10:
	.string	"__off64_t"
.LASF9:
	.string	"__off_t"
.LASF26:
	.string	"_chain"
.LASF23:
	.string	"_IO_backup_base"
.LASF71:
	.string	"stdin"
.LASF28:
	.string	"_flags2"
.LASF40:
	.string	"_mode"
.LASF16:
	.string	"_IO_read_base"
.LASF75:
	.string	"strstr"
.LASF62:
	.string	"test_string_length"
.LASF31:
	.string	"_vtable_offset"
.LASF61:
	.string	"total"
.LASF65:
	.string	"test_contains_string"
.LASF22:
	.string	"_IO_save_base"
.LASF74:
	.string	"printf"
.LASF27:
	.string	"_fileno"
.LASF47:
	.string	"string_length_a"
.LASF63:
	.string	"test_contains_char"
.LASF72:
	.string	"stdout"
.LASF79:
	.string	"_IO_lock_t"
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-39)"
	.section	.note.GNU-stack,"",@progbits
