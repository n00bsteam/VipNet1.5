#!/bin/bash -efux
exec >/var/log/crt.log 2>&1
/bin/date
/usr/bin/env

# Скрипт добавления сертификата из контейнера
# в личное хранилище пользователя
# с привязкой к контейнеру

#запрашиваем контейнеры

dummy="$(/opt/itcs/bin/csp-gost print_containers |
        grep -o --text '^  [0-9].*$' |
        sed -r '/^  (.*)\): (.*)$/ s//\2/')"
if [ -z "$dummy" ]; then
        echo "нет контейнеров"
else
        for i in $dummy; do
                echo "устанавливаем контейнер $i"
                /opt/itcs/bin/certmgr add_certificate --location=CurrentUser --store=My --container="$i"
        done
fi
echo "Готово"
