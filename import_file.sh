#!/bin/sh
# Скрипт импорта данных статистики звонков из файла CSV в базу MYSQL
# Для использования на серверах с отключенной поддержкой записи CDR в базу

Input_Folder='/volume1/var/log/asterisk/cdr-csv'
Data_Folder='/volume1/usr/wsh/CDR'
Backup_Folder='/volume1/Backup/Asterisk/CDR/'

php $Data_Folder/importcdr.php $Backup_Folder/CDRs/Master1504879273.csv

exit 0