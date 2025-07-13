	.file	"server.c"
	.text
	.globl	server_fd
	.bss
	.align 4
	.type	server_fd, @object
	.size	server_fd, 4
server_fd:
	.zero	4
	.globl	address
	.align 16
	.type	address, @object
	.size	address, 16
address:
	.zero	16
	.globl	addrlen
	.data
	.align 4
	.type	addrlen, @object
	.size	addrlen, 4
addrlen:
	.long	16
	.globl	buff
	.bss
	.align 32
	.type	buff, @object
	.size	buff, 1024
buff:
	.zero	1024
	.section	.rodata
.LC0:
	.string	"thread was unable to create"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1072, %rsp
	movl	%edi, -1060(%rbp)
	movq	%rsi, -1072(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-1040(%rbp), %rdx
	movl	$0, %eax
	movl	$128, %ecx
	movq	%rdx, %rdi
	rep stosq
	movl	$1, -1052(%rbp)
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, server_fd(%rip)
	movw	$2, address(%rip)
	movl	$0, 4+address(%rip)
	movl	$8080, %edi
	call	htons@PLT
	movw	%ax, 2+address(%rip)
	movl	server_fd(%rip), %eax
	movl	$16, %edx
	leaq	address(%rip), %rcx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind@PLT
.L3:
	leaq	-1048(%rbp), %rax
	movl	$0, %ecx
	leaq	landing(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	testl	%eax, %eax
	jns	.L2
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L2:
	movq	-1048(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	jmp	.L3
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
.LC1:
	.string	"BYE"
.LC2:
	.string	"message %s\n"
	.text
	.globl	landing
	.type	landing, @function
landing:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	server_fd(%rip), %eax
	movl	$3, %esi
	movl	%eax, %edi
	call	listen@PLT
	movl	server_fd(%rip), %eax
	leaq	addrlen(%rip), %rdx
	leaq	address(%rip), %rcx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	accept@PLT
	movl	%eax, -4(%rbp)
	movl	$0, -8(%rbp)
.L11:
	movl	-4(%rbp), %eax
	movl	$1024, %edx
	leaq	buff(%rip), %rcx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	cmpq	$-1, %rax
	je	.L12
	leaq	.LC1(%rip), %rax
	movq	%rax, %rsi
	leaq	buff(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jns	.L13
	leaq	buff(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -8(%rbp)
	jmp	.L9
.L10:
	movl	-8(%rbp), %eax
	cltq
	leaq	buff(%rip), %rdx
	movb	$48, (%rax,%rdx)
	addl	$1, -8(%rbp)
.L9:
	cmpl	$1023, -8(%rbp)
	jle	.L10
	jmp	.L11
.L12:
	nop
	jmp	.L7
.L13:
	nop
.L7:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	landing, .-landing
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
