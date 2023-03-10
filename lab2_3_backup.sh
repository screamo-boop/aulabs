#!/bin/bash

#Переменная, в которой хранится каталог, который будет резервироваться
SRC=$1

#Переменная, в которой хранится каталог, куда будет резервироваться
DST=$2

#Переменная, в которой хранится имя архива с резервной копией
BACKUPNAME=$(date +%Y-%m-%d_%H-%M-%S ).tar.gz

#Переменная, в которой хранится текущее количество бэкапов
BACKUP_COUNT=$(ls $DST | wc -l)

#Переменная, в которой хранится старейший бэкап
OLDEST=$(find $DST -printf '%T+ %p\n' | sort | head -n1 | cut -d " " -f 2)

#Создание бэкапа
tar czf $DST/$BACKUPNAME $SRC

#Проверка, сколько создано бэкапов на текущий момент
if [[ "$BACKUP_COUNT" -ge "5" ]]
then

#Если бэкапов больше 5 -- удаляем самый старый из них
	rm -f $OLDEST
else

#Если бэкапов меньше пяти -- не делаем ничего
	true
fi

#Корректно завершаем скрипт
exit 0
