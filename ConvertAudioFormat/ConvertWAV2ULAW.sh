#!/bin/sh
DIR=/volume1/Convert
# Должны быть файлы формата wav 8000-bit 
# если битрейт не совпадает, будет выдана ошибка открытия файла
FROM=wav
TO=ulaw
cd ${DIR}
for a in *.wav; do
    BASE=$(basename $a ".$FROM")
    /voip/asterisk -rx "file convert ${DIR}/${BASE}.${FROM} ${DIR}/${BASE}.${TO}"
done