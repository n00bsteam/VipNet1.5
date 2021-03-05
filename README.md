# VipNet1.5
# Скрипт добавления сертификата из контейнера
# в личное хранилище пользователя
# с привязкой к контейнеру

для активации скрипта при подключении к арм необходимо
в /etc/udev/rules.d/ создать правило и в него добавить следующее
```
#для rutoken
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="0a89", RUN+="/opt/crt.sh"
#для jacarta
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="24dc", RUN+="/opt/crt.sh"
```
