#!/bin/bash

# Tăng hiệu suất hệ thống bằng cách tối ưu hóa CPU và bộ nhớ
echo "Đang tối ưu hệ thống..."

# Tăng tốc CPU (chạy ở chế độ cao nhất)
echo "Cài đặt hiệu suất tối ưu cho CPU..."
cpufreq-set -g performance

# Giải phóng bộ nhớ
echo "Giải phóng bộ nhớ RAM..."
sync; echo 3 > /proc/sys/vm/drop_caches

# Giảm độ trễ mạng
echo "Tối ưu kết nối mạng..."
sysctl -w net.ipv4.tcp_delack_min=10

# Kết thúc
echo "Hệ thống đã được tối ưu!"