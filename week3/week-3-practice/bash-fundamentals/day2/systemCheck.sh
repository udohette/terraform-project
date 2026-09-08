#!/bin/bash
echo "Sytem report starting...."
echo "Date: $(date)"
echo "User: $USER"
echo "Current User: $(whoami)"
echo "Working Directory: $(pwd)"
echo "Disk Usage"
df -h
echo "Directory Size:"
du -sh
echo "System Report Complete"
