#!/bin/bash

/bin/bash ../src/monitor_np.sh

ecode=$(echo $?)
function testexitcode ()
{
assertEquals 0 $ecode
}

. shunit2-2.1.6/src/shunit2
