#!/bin/bash
#Скрипт проверки подключенного контейнера
#номер контейнера:
#regexp: "^[a-z]{3}-[a-z]-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}$"
#rnd-c-1a81-a680-6909-261d-33bb-5a1b-2cce
#rnd-8-a5e5-b9e6-a990-5962-36d6-4c95-aa00
status=false

function container_check {
	#проверяем подключенные контейнеры
	a=$(/opt/itcs/bin/csp-gost print_containers)
	#убираем пробелы
	a=${a// /}
	#режем на массив
	a=(${a// / })
}

while [[ $status == "false" ]]
	do
	container_check
	#сверяем по ключевой фразе в массиве
	if [[ "${a[1]}" == "<nocontainersavailable>" ]]
		then
		echo "NO CONTAINER"
		else
		echo "CONTAINER CONNECTED"
		status=true
		a=${a[1]}
		a=(${a//:/ })
		#echo "${a[1]}"
		break
	fi
done
echo "${a[1]}"
echo `/opt/itcs/bin/csp-gost container_content --container "${a[1]}"`
#if [[ $status == "true" ]]
#	then
#	container_check
#	echo ${a[1]}
#fi
