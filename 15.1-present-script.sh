#!/bin/bash

course="Devops from present script"

echo "before calling  present script ; course : $course"

echo "process id of present script : $$"

# ./16.1-future-script.sh
 source ./16.1-future-script.sh

echo "after calling future-script ; course : $course"

