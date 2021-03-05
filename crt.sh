#!/bin/sh -x
exec >>/var/log/crt.log 2>&1
date
env

# Скрипт добавления сертификата из контейнера
# в личное хранилище пользователя
# с привязкой к контейнеру

#запрашиваем контейнеры
a=$(/opt/itcs/bin/csp-gost print_containers)
#фильтруем названия контейнеров
temp=`echo "$a" | grep -o --text '^  [0-9].*$' | sed -r '/^  (.*)\): (.*)$/ s//\2/'`
#проверяем, есть ли контейнеры
if [ -z "$temp" ];
then
                echo "нет контейнеров"
else
                #режем на массив
                IFS=$'\n' arr=($temp)
                #перебираем массив
                for i in ${arr[*]};do
                               echo "устанавливаем контейнер $i"
                               /opt/itcs/bin/certmgr add_certificate --location=CurrentUser --store=My --container="$i"
                done
fi
echo "Готово"
