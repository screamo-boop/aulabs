#!/bin/bash

#Переменная, в которой хранится каталог, который будет резервироваться
SRC=$1

#Переменная, в которой хранится каталог, куда будет резервироваться
DST=$2

#Функция, создающая имя бэкапа
SetBackupName() {
	date +%Y-%m-%d_%H-%M-%S.tar.gz
}

#Переменная, в которой хранится имя архива с резервной копией
BACKUPNAME=$(SetBackupName)

#Функция для потсчета количества бэкапов
BackupCount() {
	ls $1 | wc -l
}
#Переменная, в которой хранится текущее количество бэкапов
BACKUP_COUNT=$(BackupCount $DST)

#Функция для нахождения самого старого бэкапа
FindOldestBackup() {
	find $1 -printf '%T+ %p\n' | sort | head -n1 | cut -d " " -f 2
}

#Переменная, в которой хранится старейший бэкап
OLDEST=$(FindOldestBackup $DST)

#Создание бэкапа
CreateBackUP() {
	tar czf $1/$2 $3
}

#Функция для осуществления ротации
BackupRotation() {
	if [[ "$1" -ge "10" ]]
	then
		rm -fv $2
	else
		true
	fi
}

ShowHelp() {
	echo "Скрипт создает бэкапы"
	echo "Пример использования"
	echo "./backup.sh /home/user /storage/backups"
}

if [[ "$1" == "--help" || "$2" == "" ]];
then
	ShowHelp
	exit 1
else
	true
fi


CreateBackUP $DST $BACKUPNAME $SRC

BackupRotation $BACKUP_COUNT $OLDEST
