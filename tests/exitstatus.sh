#!/bin/bash

#Test to check the exit status of script monitor_np.sh
/bin/bash ./src/monitor_np.sh

ecode=$?
function testexitcode ()
{
assertEquals 0 ${ecode}
}

source ${0%/*}/shunit2
