#!/bin/bash
#This is a script for Monitoring urls with no external parameters. The script accepts urls from file. Update src/input.txt with urls
#and run the script

urlwidth=38; descwidth=24; statuswidth=15

if [ -f output.txt ]
then
rm output.txt
fi

#Read the input file line by line and process
while read -r line
do
sleep 3
status=$(curl -Is  "$line" | head -1 | cut -d . -f 2 | cut -c 3-5)
curl -Is "${line}" 1>>/dev/null
exit_status=$?

# Retry 3 times if the url is not accessible
if [[ "${exit_status}"  != 0 ]]
then
until [[ $a == 3 ]]
do
((a++))
echo -e "\nConnecting to ${line}} ..."
curl -Is "${line}" 1>>/dev/null
done
echo -e "\nConnectivity failure: $status"
echo "Please check the url/format: $line}"
status="NA"
fi
time=$(date +"%s")
response=$(curl -Is -w "%{time_total}"\\n -o /dev/null "$line")

#Check the status code and assign description accordingly
if [[ $status == *200* ]]
then
echo "$line" , "$status" , ComponentStatus:GREEN , "$time" , "$response" >> output.txt
else 
echo  "$line" , "$status" , NotAccessible , "$time" , "$response" >> output.txt

#Print the table with values
printf '%-*s%-*s%*s%*s%*s%*s\n' "$urlwidth" URL "$statuswidth" Status "$descwidth" Description "$descwidth" Timestamp "$descwidth" ResponseTime
while IFS=, read -r URL Status Description Timestamp ResponseTime
do
    printf '%-*s%-*s%*s%*s%*s%*s%*s\n' "$urlwidth" "$URL" "$statuswidth" "$Status" "$descwidth" "$Description" "$descwidth" "$Timestamp" "$descwidth" "$ResponseTime"
done < output.txt
fi
done < src/input.txt    
