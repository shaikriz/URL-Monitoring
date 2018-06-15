#!/bin/bash

url=$1

array=(${url//,/ })

#Formatting for Output Table

headformat='%-*s%-*s%*s%*s%*s%*s\n'
headformate='%-*f%-*f%*f%*f\n'
format='%-*s%-*s%*s%*s%*s%*s%*s\n'
modwidth=16; descwidth=24; qtywidth=6; pricewidth=10
a=0

# Delete output file to remove old data
if [ -f output.txt ]
then
rm output.txt
fi

#printf "\n$headformat" "$descwidth" URL "$descwidth" Status "$descwidth" Description "$descwidth" Timestamp "$descwidth" ResponseTime | tee result.txt


print () {
while IFS=, read URL Status Description Timestamp ResponseTime
do
    printf "$format" "$descwidth" $URL "$descwidth" $Status "$descwidth" $Description "$descwidth" $Timestamp "$descwidth" $ResponseTime
done < output.txt
}



#Run the urls stored in the array to test connectivity and provide http code and response time
for i in "${!array[@]}"
do

status=$(curl -Is -w %{http_code}\\n -o /dev/null ${array[i]})
curl -Is ${array[i]} 1>>/dev/null

# Retry 3 times if the url is not accessible
if [ $? != 0 ]
then
until [[ $a == 3 ]]
do
((a++))
echo -e "\nConnecting to ${array[i]} ..."
curl -Is ${array[i]} 1>>/dev/null
done
echo -e "\nConnectivity failure: $status"
echo "Please check the url/format: ${array[i]}"
status="NA"
fi 
time=$(date +"%s")
#echo $output
response=$(curl -Is -w %{time_total}\\n -o /dev/null ${array[i]})
#echo $response
#echo $status
#echo $time

#Check the status of connectivity and assign description accordingly
if [[ $status == *200* ]]
then
echo ${array[i]} , $status , ComponentStatus:GREEN , $time , $response >> output.txt
else 
echo  ${array[i]} , $status , NotAccessible , $time , $response >> output.txt
fi
done
#Print the table by parsing the values stored in output file
printf "\n$headformat" "$descwidth" URL "$descwidth" Status "$descwidth" Description "$descwidth" Timestamp "$descwidth" ResponseTime | tee result.txt
print
