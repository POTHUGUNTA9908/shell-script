


#!/bin/bash

course="Devops from current script"

echo "before calling other script,course:$course"

echo "process id of current shell script : $$"

./16.otherscript.sh


echo "after calling other script,course:$course"