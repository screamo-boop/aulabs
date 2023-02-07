#!/bin/bash

SRC=$(mktemp -d)
DST=$(mktemp -d)

for i in $(seq 5); do
	touch $SRC/$i.test
done

for i in $(seq 11); do
	./lab4_1_backup.sh $SRC $DST
	sleep 1
done

BACKUP_COUNT=$(ls $DST | wc -l)

if [[ "$BACKUP_COUNT" -gt "10" ]]; then
	echo "ТЕСТ НЕ ПРОЙДЕН"
else
	echo "ТЕСТ ПРОЙДЕН"
fi
