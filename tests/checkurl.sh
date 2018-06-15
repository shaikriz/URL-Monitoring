#! /bin/bash

linecount=$(lc ../result.txt)
echo $linecount

status=$(awk '{print $2}' ../result.txt | sed -n '2,$p' | while read -r line ;do if [[ $line =~ ^[0-9]+$ ]];then echo "ok"; else echo "error";fi;done;)
#status="ok"

function testWeCanWriteTests () {
    assertEquals "it works" "it works"
}

function testequal () {
    assertEquals "it works" "it works"
}

function testStatus () {
    assertEquals 1 2
}

function testStatusNumeric () {
assertEquals {^[0-9]...$linecpunt}  $status
}
#status=$(awk '{print $2}' ../result.txt | sed -n '2,$p' | while read -r line ;do if [[ $line =~ ^[0-9]+$ ]];then echo "ok"; else echo "error";fi;done;)

. shunit2-2.1.6/src/shunit2
