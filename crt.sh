#!/bin/bash
# Скрипт добавления сертификата из контейнера 
# в личное хранилище пользователя
# с привязкой к контейнеру

#переменные
status=false
p=~/

# Функция преобразования информации контейнера
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
		echo "Контейнер не найдет, подключите контейнер."
		else 
		echo "Контейнер найден, экспортируем сертификат..."
		status=true
		a=${a[1]}
		a=(${a//:/ })
		break
	fi
done

#echo "${a[1]}"
#echo `/opt/itcs/bin/csp-gost container_content --container "${a[1]}"`
#echo `/opt/itcs/bin/certmgr print_certificate --container "${a[1]}"`

/opt/itcs/bin/certmgr extract_certificate --file="$p/crt.cer" --container="${a[1]}"
echo "Импортируем сертификат в личное хранилище..."
echo "Связываем сертификат с контейнером..."
/opt/itcs/bin/certmgr add_certificate --location=CurrentUser --store=My --file="$p/crt.cer" --container="${a[1]}"
echo "Сертификат установлен, удачного пользования ;)"

