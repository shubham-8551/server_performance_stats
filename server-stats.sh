#!/bin/sh
echo "===== Server Performance Summary ====="

# Total CPU usage
echo ">>> Total CPU Usage:"
if command -v mpstat >/dev/null 2>&1; then
  mpstat 1 1 | awk '/Average/ && $3 ~ /[0-9.]+/ { print 100 - $NF "% used" }'
else
  top -bn1 | grep "Cpu(s)" | awk '{usage=100 - $8} END {print usage "% used"}'
fi

# Total memory usage with percentage
echo ">>> Memory Usage:"
free -m | awk 'NR==2 {
  used=$3; free=$4; total=$2; 
  percent=used*100/total; 
  printf "Used: %d MB, Free: %d MB, Total: %d MB, Usage: %.2f%%\n", used, free, total, percent
}'

# Total disk usage with percentage
echo ">>> Disk Usage:"
df -BM --total | grep total | awk '{
  used=$3; avail=$4; total=$2;
  percent=used*100/total;
  printf "Used: %sB, Free: %sB, Total: %sB, Usage: %.2f%%\n", used, avail, total, percent
}'

# Top 5 processes by CPU usage
echo ">>> Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by memory usage
echo ">>> Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

echo "===== End of Summary ====="
