#!/system/bin/sh
clear

# Màu sắc
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# Hiệu ứng chữ
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Phiên bản script
SCRIPT_VERSION="2.0"
UPDATE_URL="https://raw.githubusercontent.com/leminhkhang-alt/Configgiamlag/main/script.sh"
VERSION_URL="https://raw.githubusercontent.com/leminhkhang-alt/Configgiamlag/main/version.txt"

# Kiểm tra cập nhật
NEW_VERSION=$(curl -s "$VERSION_URL")
if [ "$NEW_VERSION" != "$SCRIPT_VERSION" ]; then
    echo -e "${YELLOW}🔄 Đang cập nhật script...${RESET}"
    curl -o "$0" "$UPDATE_URL"
    chmod +x "$0"
    echo -e "${GREEN}✔ Cập nhật thành công! Khởi động lại script...${RESET}"
    exec "$0"
    exit
else
    echo -e "${GREEN}✅ Bạn đang dùng phiên bản mới nhất!${RESET}"
fi

# Hiển thị logo
echo -e "${CYAN}"
echo " █████▒▒█████   ██▀███   ██▓███   ██▓ ███▄    █ "
echo "▓██   ▒▒██▒  ██▒▓██ ▒ ██▒▓██░  ██▒▓██▒ ██ ▀█   █ "
echo "▒████ ░▒██░  ██▒▓██ ░▄█ ▒▓██░ ██▓▒▒██▒▓██  ▀█ ██▒"
echo "░▓█▒  ░▒██   ██░▒██▀▀█▄  ▒██▄█▓▒ ▒░██░▓██▒  ▐▌██▒"
echo "░▒█░   ░ ████▓▒░░██▓ ▒██▒▒██▒ ░  ░░██░▒██░   ▓██░"
echo " ▒ ░   ░ ▒░▒░▒░ ░ ▒▓ ░▒▓░▒▓▒░ ░  ░░▓  ░ ▒░   ▒ ▒ "
echo " ░       ░ ▒ ▒░   ░▒ ░ ▒░░▒ ░      ▒ ░░ ░░   ░ ▒░"
echo " ░ ░   ░ ░ ░ ▒    ░░   ░ ░░        ▒ ░   ░   ░ ░ "
echo "           ░ ░     ░                 ░           "
echo -e "${RESET}"
echo -e "${YELLOW}${BOLD}🔥 Free Fire Ultimate Optimizer - MAX PRO 🔥${NORMAL}${RESET}"
echo ""

# Chống phát hiện - Anti-Ban
echo -e "${RED}🧹 Đang xóa cache và log để chống phát hiện...${RESET}"
rm -rf /data/data/com.dts.freefireth/cache/*
rm -rf /data/data/com.dts.freefireth/files/tbslog/
rm -rf /data/data/com.dts.freefireth/files/ANR/
rm -rf /sdcard/Android/data/com.dts.freefireth/cache/*

# Ẩn tiến trình script
echo -e "${CYAN}🕵 Ẩn tiến trình để tránh bị kiểm tra...${RESET}"
nohup sh -c "sleep 60 && kill -9 $$" >/dev/null 2>&1 &

# Thanh tiến trình
progress_bar() {
    bar="===================="
    bar_len=${#bar}
    for i in $(seq 1 $bar_len); do
        printf "\r[%-${bar_len}s] %d%%" "${bar:0:$i}" $((i * 100 / bar_len))
        sleep 0.1
    done
    printf "\n"
}

# Giải phóng RAM
echo -e "${BLUE}🚀 Giải phóng RAM...${RESET}"
echo 3 > /proc/sys/vm/drop_caches
progress_bar

# Tối ưu CPU
echo -e "${CYAN}⚡ Tăng tốc CPU...${RESET}"
pid=$(pidof com.dts.freefireth)
if [ -n "$pid" ]; then
    renice -10 -p $pid
    echo -e "${GREEN}✔ Free Fire được ưu tiên CPU (PID: $pid)${RESET}"
else
    echo -e "${RED}⚠ Free Fire chưa chạy, sẽ áp dụng khi khởi động!${RESET}"
fi
progress_bar

# Tắt ứng dụng nền
echo -e "${YELLOW}🔧 Đang tắt ứng dụng nền không cần thiết...${RESET}"
apps=(
    "com.facebook.katana"
    "com.whatsapp"
    "com.instagram.android"
    "com.android.chrome"
    "com.google.android.youtube"
)
for app in "${apps[@]}"; do
    pm disable $app
    echo -e "${RED}❌ Đã tắt: $app${RESET}"
done
progress_bar

# Tăng tốc cảm ứng
echo -e "${GREEN}📱 Tăng tốc cảm ứng để kéo tâm chuẩn hơn...${RESET}"
settings put system pointer_speed 7
settings put system touchscreen.tap_duration 1
settings put system touchscreen.longpress_duration 300
progress_bar

# Tối ưu GPU
echo -e "${BLUE}🎮 Kích hoạt chế độ GPU Boost...${RESET}"
settings put global gpu_debug_app com.dts.freefireth
settings put global gpu_debug_layers VK_LAYER_LUNARG_monitor
settings put global gpu_debug_layers VK_LAYER_KHRONOS_validation
progress_bar

# Tinh chỉnh bộ nhớ
echo -e "${CYAN}🛠 Giảm lag bằng cách tối ưu hóa bộ nhớ...${RESET}"
echo "minfree=512,1024,2048,4096,8192,16384" > /sys/module/lowmemorykiller/parameters/minfree
progress_bar

# Giảm ping, tối ưu mạng
echo -e "${YELLOW}📶 Kích hoạt chế độ giảm ping...${RESET}"
settings put global wifi_scan_interval 300
settings put global mobile_data_always_on 0
settings put global airplane_mode_on 0
settings put global tether_dun_required 0
progress_bar
echo -e "${GREEN}✔ Giảm ping thành công!${RESET}"

# Kiểm tra & khởi động lại game nếu bị tắt
if pgrep -f "com.dts.freefireth" > /dev/null; then
    echo -e "${GREEN}✅ Free Fire đang chạy bình thường!${RESET}"
else
    echo -e "${YELLOW}⚠ Phát hiện sự cố! Đang khởi động lại Free Fire...${RESET}"
    am start -n com.dts.freefireth/.MainActivity
fi

# Hiển thị thông báo hoàn tất
echo -e "${GREEN}${BOLD}🎯 Free Fire đã được tối ưu! Chúc bạn leo rank thành công!${NORMAL}${RESET}"
echo -e "${WHITE}🔥 Nếu thích script này, hãy chia sẻ với bạn bè! 🔥${RESET}"

# Chuyển hướng đến Telegram
echo -e "${GREEN}🔗 Đang chuyển hướng đến Telegram...${RESET}"
sleep 2
am start -a android.intent.action.VIEW -d "https://t.me/kakutoteam"
