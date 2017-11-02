#!/bin/bash
echo "Если вы хотите прочитать справку по скрипту введите 1 если нет введите 0."
read -p 'Сделайте выбор:' help;
declare -i n=1
if [ $help -eq $n ];
then
echo "Данный скрипт изменяет размер всех больших изображений в дерриктории на размер который вы зададите.";
echo "Запускать скрипт можно из любой директории. т.к. при запуске скрипт автоматически заходит в корневую директорию"
else
cd ~
echo 'Выберите нужную вам директорию из предложенных:'; ls;
read -p 'Введите название начальной Директории из списка:' startdir;
if [[ -e "$HOME/${startdir}" ]]; then
echo "Данная директория существует";
else
echo "Данной директории нет. Попробуйте снова.";
exit 1
fi
read -p 'Введите ширину изображения(в пикселях) в которую нужно конвертировать:' weight;
read -p 'Введите высоту изображения(в пикселях) в которую нужно конвертировать:' height;
echo 'Выберите нужную вам директорию из предложенных:'; ls;
read -p 'Введите название итоговой директории из списка:' finaldir;
if [[ -e "$HOME/${finaldir}" ]]; then
echo "Данная директория существует";
else
echo "Данной директории нет. Попробуйте снова.";
exit 1
fi
cd ${startdir}
for i in `ls *.jpg`; do
identify -format "%wx%h" 1.jpg > info.txt;
tr 'x' '\n' < info.txt > result.txt;
fileweight=`head -n 1 result.txt`;
fileheight=`tail -n 1 result.txt`;
if [ $fileweight -gt $weight -a $fileheight -gt $height ];
then
convert -resize ${weight}x${height}! $i ../${finaldir}/$i;
echo "Конвертация изображения(${i}) прошла успешно!"
else
echo "Изображения(${i}) меньше или равны заданным размерам.";
fi
done
fi
