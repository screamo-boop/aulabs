#!/bin/bash

#Переменная, которая хранит действите пользователя
OPERATION=$1

#Имя итогового файла
FILENAME=data.txt

#Функция для вывода справки
help() {
	echo "Пример использования:"
	echo "  phone-book.sh команда [аргументы]"
	echo "Доступные команды:"
	echo "  new <имя> <номер> Добавление записи в телефонную книгу"
	echo "  search <имя-или-номер> Поиск записей в телефонной книге"
	echo "  list              Просмотр всех записей"
	echo "  delete <имя-или-номер> Удаление записи"
	echo "  help              Показ этой справки"
}

#Функция для добавления элемента
new() {
	if [[ $(cat data.txt | grep "$2") == "" ]];
	then
		echo $1:"$2" >> $3
	else
		echo "Этот номер телефона уже существует"
	fi
}

#Функция для поиска элемента
search() {
	cat data.txt | grep -i $1 | cut -d ":" -f 2 
}

#Функция для вывода полного списка элементов
list() {
	cat data.txt | sort
}

#Функция для удаления элемента
delete() {
	sed -i "/$1/d" data.txt
}

#Оператор выбора
case "$OPERATION" in
	"help")
		help
		;;
	"new")
		new "$2" "$3" $FILENAME
		;;
	"search")
		search $2
		;;
	"list")
		list
		;;
	"delete")
		delete $2
		;;
esac
