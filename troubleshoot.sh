#!/bin/bash

# --- ตั้งชื่อไฟล์ผลลัพธ์ ---
OUTPUT_FILE="system_report_$(date +'%Y-%m-%d_%H-%M-%S').txt"

# --- เริ่มบันทึกข้อมูลทั้งหมดลงไฟล์ ---
exec > >(tee -a "$OUTPUT_FILE") 2>&1

echo "============================================================"
echo "      System Health Report - Generated on $(date)"
echo "============================================================"
echo ""

echo "### 1. System Overview ###"
uname -a
echo "Hostname: $(hostname)"
cat /etc/os-release | grep PRETTY_NAME
echo ""

echo "### 2. Uptime and Load Average ###"
uptime
echo ""

echo "### 3. Disk Usage ###"
df -h
echo ""

echo "### 4. Memory Usage ###"
free -m
echo ""

echo "### 5. Failed Systemd Services ###"
systemctl --failed --no-pager
echo ""

echo "### 6. Last 50 System Log Entries ###"
journalctl -n 50 --no-pager
echo ""

echo "### 7. Last 30 Kernel Messages ###"
dmesg | tail -n 30
echo ""

echo "### 8. Network Configuration and Listening Ports ###"
echo "--- IP Addresses ---"
ip a
echo ""
echo "--- Listening TCP/UDP Ports ---"
ss -tulnp
echo ""

echo "============================================================"
echo "Report saved to: $OUTPUT_FILE"
echo "============================================================"
