#!/bin/bash

COUNT=$(find . -name "*.log" | wc -l)
echo "Log Files Foun: $COUNT"
