#!/bin/bash

array=(${url//,/ })

headformat='%-*s%-*s%*s%*s%*s%*s\n'
headformate='%-*f%-*f%*f%*f\n'
format='%-*s%-*s%*s%*s%*s%*s%*s\n'

urlwidth=38; descwidth=24; statuswidth=15

#while read LINE
#    do output=`curl -Is $LINE | head -1`

if [ -f output.txt ]
then
rm output.txt
fi

#for i in "${!array[@]}"
#do
#echo "$i=>${array[i]}"
while read line
do
sleep 3
status=`curl -Is  $line | head -1 | cut -d . -f 2 | cut -c 3-5`
sleep 3
time=$(date +"%s")
response=$(curl -Is -w %{time_total}\\n -o /dev/null $line)
if [[ $status == *200* ]]
then
echo $line , $status , ComponentStatus:GREEN , $time , $response >> output.txt
else 
echo  $line , $status , NotAccessible , $time , $response >> output.txt
printf "$headformat" "$urlwidth" URL "$statuswidth" Status "$descwidth" Description "$descwidth" Timestamp "$descwidth" ResponseTime
while IFS=, read URL Status Description Timestamp ResponseTime
do
    printf "$format" "$urlwidth" $URL "$statuswidth" $Status "$descwidth" $Description "$descwidth" $Timestamp "$descwidth" $ResponseTime
done < output.txt
fi
#done
done < src/input.txt
