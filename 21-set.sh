#!/bin/bash

set -e

trap 'echo "there is an error in $LINENO and the command is $BASH_COMMAND"'

echo "before error"

dnf.mkljoj

echo "after error"