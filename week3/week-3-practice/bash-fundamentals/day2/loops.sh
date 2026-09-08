#!/bin/bash

for FILE in *.log
do
echo "Checking $FILE for errors"
grep -i  error "$FILE"
done
