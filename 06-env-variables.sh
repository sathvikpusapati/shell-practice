#!/bin/bash

echo "course name is :$COURSE"

# in server home location wwe have .bashrc file in that we need to add 
# COURSE=" name " before the last line and run source .bashrc command 
# this will make the variable to stay even after the process is complete 
# that means after exit also we can have that value