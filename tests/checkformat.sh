#!/bin/bash

#Test to check if the given url format is valid

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
string='https://www.google.com/test/link.php'

if [[ ${string} =~ ${regex} ]]
then
ecode=$?
echo $ecode
#assertEquals "0" "$?"
 echo "Link valid"
else
    echo "Link not valid"
echo $ecode
fi

function testformat () {

assertEquals "0" "${ecode}"

}

exec shunit2-2.1.6/src/shunit2
