	.file	"main.cpp"
	.text
	.globl	_Z10sequentielPfS_S_m
	.type	_Z10sequentielPfS_S_m, @function
_Z10sequentielPfS_S_m:
.LFB7715:
	testq	%rcx, %rcx
	je	.L1
	movl	$0, %eax
.L3:
	vmovss	(%rdi,%rax,4), %xmm0
	vaddss	(%rsi,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax,4)
	addq	$1, %rax
	cmpq	%rax, %rcx
	jne	.L3
.L1:
	ret
.LFE7715:
	.size	_Z10sequentielPfS_S_m, .-_Z10sequentielPfS_S_m
	.globl	_Z9parallelePfS_S_m
	.type	_Z9parallelePfS_S_m, @function
_Z9parallelePfS_S_m:
.LFB7716:
	testq	%rcx, %rcx
	je	.L5
	subq	$1, %rcx
	andq	$-8, %rcx
	addq	$8, %rcx
	movl	$0, %eax
.L7:
	vmovups	(%rsi,%rax,4), %ymm0
	vaddps	(%rdi,%rax,4), %ymm0, %ymm0
	vmovups	%ymm0, (%rdx,%rax,4)
	addq	$8, %rax
	cmpq	%rcx, %rax
	jne	.L7
.L5:
	ret
.LFE7716:
	.size	_Z9parallelePfS_S_m, .-_Z9parallelePfS_S_m
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"Le r\303\251sultat est "
.LC4:
	.string	"S\303\251quentiel : "
.LC5:
	.string	" "
.LC7:
	.string	"Parall\303\250le : "
	.text
	.globl	main
	.type	main, @function
main:
.LFB7717:
	pushq	%r15
.LCFI0:
	pushq	%r14
.LCFI1:
	pushq	%r13
.LCFI2:
	pushq	%r12
.LCFI3:
	pushq	%rbp
.LCFI4:
	pushq	%rbx
.LCFI5:
	subq	$24, %rsp
.LCFI6:
	movq	8(%rsi), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol@PLT
	cltq
	movq	%rax, 8(%rsp)
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	movl	$4194304, %edi
	call	malloc@PLT
	movq	%rax, %r12
	movl	$4194304, %edi
	call	malloc@PLT
	movq	%rax, %r13
	movl	$4194304, %edi
	call	malloc@PLT
	movq	%rax, %r14
	movl	$4194304, %edi
	call	malloc@PLT
	movq	%rax, %r15
	movl	$0, %ebx
	movl	$-1240768329, %ebp
.L10:
	call	rand@PLT
	movl	%eax, %ecx
	imull	%ebp
	addl	%ecx, %edx
	sarl	$8, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	imull	$360, %edx, %edx
	subl	%edx, %ecx
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	%ecx, %xmm0, %xmm0
	vsubsd	.LC1(%rip), %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	vcvtsd2ss	%xmm0, %xmm1, %xmm1
	vmovss	%xmm1, (%r12,%rbx,4)
	call	rand@PLT
	movl	%eax, %ecx
	imull	%ebp
	addl	%ecx, %edx
	sarl	$8, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	imull	$360, %edx, %edx
	subl	%edx, %ecx
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	%ecx, %xmm0, %xmm0
	vsubsd	.LC1(%rip), %xmm0, %xmm0
	vxorps	%xmm2, %xmm2, %xmm2
	vcvtsd2ss	%xmm0, %xmm2, %xmm2
	vmovss	%xmm2, 0(%r13,%rbx,4)
	addq	$1, %rbx
	cmpq	$1048576, %rbx
	jne	.L10
	movl	$1048576, %ecx
	movq	%r14, %rdx
	movq	%r13, %rsi
	movq	%r12, %rdi
	call	_Z10sequentielPfS_S_m
	movl	$1048576, %ecx
	movq	%r15, %rdx
	movq	%r13, %rsi
	movq	%r12, %rdi
	call	_Z9parallelePfS_S_m
	vmovss	(%r14), %xmm0
	vucomiss	(%r15), %xmm0
	jp	.L23
	movl	$1, %eax
	jne	.L23
.L14:
	vmovss	(%r14,%rax,4), %xmm0
	vucomiss	(%r15,%rax,4), %xmm0
	jp	.L24
	jne	.L24
	addq	$1, %rax
	cmpq	$1048576, %rax
	jne	.L14
	movl	$1, %ebx
	jmp	.L11
.L23:
	movl	$0, %ebx
	jmp	.L11
.L24:
	movl	$0, %ebx
.L11:
	movl	$17, %edx
	leaq	.LC2(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	leaq	_ZSt4cout(%rip), %rdi
	movq	_ZSt4cout(%rip), %rax
	movq	%rdi, %rsi
	addq	-24(%rax), %rsi
	orl	$1, 24(%rsi)
	movzbl	%bl, %esi
	call	_ZNSo9_M_insertIbEERSoT_@PLT
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@PLT
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	cmpq	$0, 8(%rsp)
	je	.L15
	movl	$0, %ebp
	vmovsd	.LC0(%rip), %xmm7
	vmovsd	%xmm7, (%rsp)
.L18:
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	%rax, %rbx
	movl	$1048576, %ecx
	movq	%r14, %rdx
	movq	%r13, %rsi
	movq	%r12, %rdi
	call	_Z10sequentielPfS_S_m
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	subq	%rbx, %rax
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vdivsd	.LC3(%rip), %xmm0, %xmm0
	vminsd	(%rsp), %xmm0, %xmm3
	vmovsd	%xmm3, (%rsp)
	addl	$1, %ebp
	movslq	%ebp, %rax
	cmpq	8(%rsp), %rax
	jb	.L18
	movl	$14, %edx
	leaq	.LC4(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	(%rsp), %xmm0
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movq	%rax, %rbx
	movl	$1, %edx
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	(%rsp), %xmm7
	vmulsd	.LC6(%rip), %xmm7, %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@PLT
	movl	$0, %ebp
	vmovsd	.LC0(%rip), %xmm7
	vmovsd	%xmm7, (%rsp)
.L21:
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	%rax, %rbx
	movl	$1048576, %ecx
	movq	%r15, %rdx
	movq	%r13, %rsi
	movq	%r12, %rdi
	call	_Z9parallelePfS_S_m
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	subq	%rbx, %rax
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vdivsd	.LC3(%rip), %xmm0, %xmm0
	vminsd	(%rsp), %xmm0, %xmm5
	vmovsd	%xmm5, (%rsp)
	addl	$1, %ebp
	movslq	%ebp, %rax
	cmpq	8(%rsp), %rax
	jb	.L21
.L22:
	movl	$13, %edx
	leaq	.LC7(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	(%rsp), %xmm0
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movq	%rax, %rbx
	movl	$1, %edx
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	(%rsp), %xmm7
	vmulsd	.LC6(%rip), %xmm7, %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
	movq	%r15, %rdi
	call	free@PLT
	movl	$0, %eax
	addq	$24, %rsp
.LCFI7:
	popq	%rbx
.LCFI8:
	popq	%rbp
.LCFI9:
	popq	%r12
.LCFI10:
	popq	%r13
.LCFI11:
	popq	%r14
.LCFI12:
	popq	%r15
.LCFI13:
	ret
.L15:
.LCFI14:
	movl	$14, %edx
	leaq	.LC4(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	.LC0(%rip), %rax
	vmovq	%rax, %xmm0
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movq	%rax, %rbx
	movl	$1, %edx
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	.LC8(%rip), %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@PLT
	movq	.LC0(%rip), %rax
	movq	%rax, (%rsp)
	jmp	.L22
.LFE7717:
	.size	main, .-main
	.type	_GLOBAL__sub_I__Z10sequentielPfS_S_m, @function
_GLOBAL__sub_I__Z10sequentielPfS_S_m:
.LFB8098:
	subq	$8, %rsp
.LCFI15:
	leaq	_ZStL8__ioinit(%rip), %rdi
	call	_ZNSt8ios_base4InitC1Ev@PLT
	leaq	__dso_handle(%rip), %rdx
	leaq	_ZStL8__ioinit(%rip), %rsi
	movq	_ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rdi
	call	__cxa_atexit@PLT
	addq	$8, %rsp
.LCFI16:
	ret
.LFE8098:
	.size	_GLOBAL__sub_I__Z10sequentielPfS_S_m, .-_GLOBAL__sub_I__Z10sequentielPfS_S_m
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z10sequentielPfS_S_m
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	4294967295
	.long	2146435071
	.align 8
.LC1:
	.long	0
	.long	1080459264
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.align 8
.LC6:
	.long	0
	.long	1051721728
	.align 8
.LC8:
	.long	4294967295
	.long	2125463551
	.section	.eh_frame,"a",@progbits
.Lframe1:
	.long	.LECIE1-.LSCIE1
.LSCIE1:
	.long	0
	.byte	0x3
	.string	"zR"
	.uleb128 0x1
	.sleb128 -8
	.uleb128 0x10
	.uleb128 0x1
	.byte	0x1b
	.byte	0xc
	.uleb128 0x7
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x1
	.align 8
.LECIE1:
.LSFDE1:
	.long	.LEFDE1-.LASFDE1
.LASFDE1:
	.long	.LASFDE1-.Lframe1
	.long	.LFB7715-.
	.long	.LFE7715-.LFB7715
	.uleb128 0
	.align 8
.LEFDE1:
.LSFDE3:
	.long	.LEFDE3-.LASFDE3
.LASFDE3:
	.long	.LASFDE3-.Lframe1
	.long	.LFB7716-.
	.long	.LFE7716-.LFB7716
	.uleb128 0
	.align 8
.LEFDE3:
.LSFDE5:
	.long	.LEFDE5-.LASFDE5
.LASFDE5:
	.long	.LASFDE5-.Lframe1
	.long	.LFB7717-.
	.long	.LFE7717-.LFB7717
	.uleb128 0
	.byte	0x4
	.long	.LCFI0-.LFB7717
	.byte	0xe
	.uleb128 0x10
	.byte	0x8f
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI1-.LCFI0
	.byte	0xe
	.uleb128 0x18
	.byte	0x8e
	.uleb128 0x3
	.byte	0x4
	.long	.LCFI2-.LCFI1
	.byte	0xe
	.uleb128 0x20
	.byte	0x8d
	.uleb128 0x4
	.byte	0x4
	.long	.LCFI3-.LCFI2
	.byte	0xe
	.uleb128 0x28
	.byte	0x8c
	.uleb128 0x5
	.byte	0x4
	.long	.LCFI4-.LCFI3
	.byte	0xe
	.uleb128 0x30
	.byte	0x86
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI5-.LCFI4
	.byte	0xe
	.uleb128 0x38
	.byte	0x83
	.uleb128 0x7
	.byte	0x4
	.long	.LCFI6-.LCFI5
	.byte	0xe
	.uleb128 0x50
	.byte	0x4
	.long	.LCFI7-.LCFI6
	.byte	0xa
	.byte	0xe
	.uleb128 0x38
	.byte	0x4
	.long	.LCFI8-.LCFI7
	.byte	0xe
	.uleb128 0x30
	.byte	0x4
	.long	.LCFI9-.LCFI8
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.long	.LCFI10-.LCFI9
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.long	.LCFI11-.LCFI10
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI12-.LCFI11
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI13-.LCFI12
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI14-.LCFI13
	.byte	0xb
	.align 8
.LEFDE5:
.LSFDE7:
	.long	.LEFDE7-.LASFDE7
.LASFDE7:
	.long	.LASFDE7-.Lframe1
	.long	.LFB8098-.
	.long	.LFE8098-.LFB8098
	.uleb128 0
	.byte	0x4
	.long	.LCFI15-.LFB8098
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI16-.LCFI15
	.byte	0xe
	.uleb128 0x8
	.align 8
.LEFDE7:
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
