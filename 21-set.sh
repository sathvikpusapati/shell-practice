#!/bin/bash

set -e

trap 'echo "there is an error in line number  $LINENO and the command is $BASH_COMMAND"' ERR

echo "before error"

abcd.dnf 

echo "after error"
