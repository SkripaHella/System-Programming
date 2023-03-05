#!bin/sh

echo "Автор данного скрипта: Лобанов Александр, гр. 739-1"
echo " "
echo "Привет XD"
echo "Данная программа занимается поиском файлов в указанной директории по имени или размеру, в зависимости от того, что ты выберешь."

while [ -z "$name" ]
do
	echo "Давай познакомимся. Как тебя зовут? (напиши ФИО; поле не должно оставаться пустым): "
	read name
done



i=0
while [ $i -le 0 ]
do
	directory=""
	file_name=""
	file_size=""
	case=""
	REGEX="^[0-9]+$"
	
	while [ -z "$case" ]
	do
		echo ""
		echo "Как будем искать файл: по имени (введи 1) или размеру, начиная от введенной величины (введи 2):"
		read case
		if [ "$case" != 1 ] && [ "$case" != 2 ]
		then
			echo "Неверный формат"
			case=""
			continue
		else break
		fi
	done

	if [ "$case" == 1 ]
	then
		while [[ ! -d "$directory" ]] 
		do	
			echo "Напишите каталог, в котором будет производиться поиск (не может быть пустым или несуществующим)"
			read directory
		done
	
		while [ -z "$file_name" ] 
		do	
			echo "Напишите имя файла, который будет искаться(не может быть пустым или несуществующим)"
			read file_name
		done
		
		find $directory -iname $file_name.*
		echo ""
	else
		while [[ ! -d "$directory" ]] 
		do	
			echo "Напишите каталог, в котором будет производиться поиск (не может быть пустым или несуществующим)"
			read directory
		done
	
		while [ -z "$file_size" ] 
		do	
			echo "Введите минимальный размер файла (от этого числа КИЛОБАЙТ будет производится поиск файла)"
			read file_size
			if [[ ! $file_size =~ $REGEX ]]
			then
				echo "Ввели не число"
				file_size=""
			else
				break
			fi
		done
		
		find $directory -size +"$file_size"k
		echo ""
	fi
	
	
	
	
	while :
	do
		echo "Хотите завершить работу? (да/нет. Другие ответы не принимаются!)";
		read text
		if [ $text == "нет" ]
		then 
			echo ""
			break
		elif [ $text == "да" ]
		then 
			echo ""
			i=$(( $i + 1 )) 
			break
		else
			echo "Написал какую-то чушь или вообще ничего не написал)";
			echo ""
		fi
	done
done
