# URL-Monitoring


This is a Monitoring Application to Test connectivity to given URLs

Please follow below steps to check the connectivity to your urls

#Executing monitor.sh
Go to your bash prompt and run 
$ cd URL-Monitoring/src
$./monitor.sh <URL,URL,..> 

You should see the output as table with values. We have passed a comma separated list of url’s as an argument and the script tests the connectivity for all the urls and gives a table with values. The output is also saved in result.txt.

#Execting monitor_np.sh
Go to your bash prompt and run 
$ cd URL-Monitoring/src
$./monitor_np.sh
We do not need to pass any arguments to this script. It picks the url from input.txt file located at src/input.txt. Add urls of your choice to input.txt and run the script to get the results. The output can also be found at result_np.txt
 

