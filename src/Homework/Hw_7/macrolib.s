# Макрос-обертка над подпрограммой вывода шестандцатеричной цифры на индикатор цифрового блока DLS
.macro dls_print_int(%num, %addr)
	mv a0 %num
	mv a1 %addr
	jal dls_show_num
.end_macro


# Макрос для вывода строки в консоль
#Параметры:
# %str - лейбл с строкой, значение которой будет выведено в консоль
.macro print_string(%str)
	stack_push_w(a0)
	
	la a0 %str
	li a7 4
	ecall
	
	stack_pop_w(a0)
.end_macro

# Макрос для системного вызова засыпания программы в миллисекундах
.macro sleep(%x)
	li a0, %x
    li a7, 32
    ecall
.end_macro


# Печать содержимого заданного регистра как двоичного целого
.macro print_int_bin (%x)
   stack_push_w(a0)
   stack_push_w(a7)
	mv a0, %x
	li a7, 35
	ecall
   stack_pop_w(a7)
   stack_pop_w(a0)
.end_macro

# Печать содержимого заданного регистра как шестнадцатиричного целого
.macro print_int_hex (%x)
   stack_push_w(a0)
   stack_push_w(a7)
	mv a0, %x
	li a7, 34
	ecall
   stack_pop_w(a7)
   stack_pop_w(a0)
.end_macro

# Макрос для вывода целого числа в консоль
#Параметры:
# %num - регистр, значение которого будет выведено в консоль
.macro print_int(%num)
	stack_push_w(a0)
	
	mv a0 %num
	li a7 1
	ecall
	
	stack_pop_w(a0)
.end_macro

# Макрос для вывода символа в консоль
.macro print_char(%x)
	stack_push_w(a0)
   	li a7, 11
   	li a0, %x
   	ecall
   	stack_pop_w(a0)
.end_macro

# Макрос для вывода символа переноса строки в консоль
.macro newline
	print_char('\n')
.end_macro

# Макрос для завершения работы программы
.macro exit_program
	li a7, 10
	ecall
.end_macro

# Макрос для сохраенения 32-битного слова на стек
# Параметры:
# %x - регистр, значение которого сохранится на стек
.macro stack_push_w(%x)
	addi	sp sp -4
	sw	%x 0(sp)
.end_macro

# Макрос для снятия 32-битного слова со стека
# Параметры:
# %x - регистр, в который будет записано значение со стека
.macro stack_pop_w(%x)
	lw	%x (sp)
	addi	sp sp 4
.end_macro
