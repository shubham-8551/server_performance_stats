#!/bin/sh
echo "===== Server Performance Stats ====="
echo "Timestamp: $(date)"
echo ">>> CPU Usage (Top 5 processes by %CPU):"
free -h
echo ">>> Disk Usage:"
df -BG | grep -v '^none'