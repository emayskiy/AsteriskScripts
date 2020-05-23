#!/bin/sh
# Скрипт импорта данных статистики звонков из файла CSV в базу MYSQL
# Для использования на серверах с отключенной поддержкой записи CDR в базу

# Копирует текущий файл CDR csv из каталога asterisk в папку CDRs и выполняет его импорт
Input_Folder='/volume1/asterisk/cdr-csv'        # каталог CDR вашего сервера Asterisk
Backup_Folder='/volume1/Backup/Asterisk/CDR'    # Каталог куда скопирует копию CDR
Data_Folder='/volume1/usr/wsh/CDR'
cd $Input_Folder
if [ ! -f Master.csv ]
then
    echo "File Master.csv does not exist"
    exit 0
fi
input_file=Master`date +%s`.csv
echo $Data_Folder/$input_file
mv $Input_Folder/Master.csv $Backup_Folder/CDRs/$input_file
if [ -f $Backup_Folder/CDRs/$input_file ]
then
    php $Data_Folder/importcdr.php $Backup_Folder/CDRs/$input_file
fi

exit 0