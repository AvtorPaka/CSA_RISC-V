.data
text_stump: .asciz "ok"

.include "macrolib.s"

.global main

.text
main:
	#Вызов макроса ввода аргументов функции
	#Передаваемые параметры:
	# fs1(%x) - регистр, куда будет записан аргумент x
	# s1(%m) - регистр, куда будет записан аргумент m
	input_function_parameters(fs1 s1)
	
	#Вызов подпрограммы подсчета значения биномиальной функции при помощи степенного ряда
	# Передача параметров :
	fmv.d fa1 fs1		# fa1 - параметр биномиальной функции x
	mv a0 s1		# a0 - степень биномиальной функции m
	jal ra calculate_series
	#Возвращаемое значение:
	# fa0 - посчитанное значение биномиальной функции (1 + x)^m
	
	#Вызов макроса вывода значения функции
	#Передаваемые параметры
	# fa0(%fnum) - десятичное число двойной точности, резултат функции
	print_function_result(fa0)
	
	exit_program