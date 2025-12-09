#!/bin/bash

# ============================================================
#   AUTO INSTALLER DEPENDENCIES BOT WA
#   Developer : Argantara
#   Platform  : Linux (Ubuntu/Debian/Termux/WSL compatible)
# ============================================================

clear

# ---------- COLOR ----------
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

# ---------- HEADER ----------
echo -e "${BLUE}"
echo "======================================================="
echo "        AUTO INSTALLER – BOT WHATSAPP DEPENDENCIES     "
echo "======================================================="
echo -e "${YELLOW}                 Developer: ARGANTARA                 "
echo -e "${BLUE}=======================================================${NC}"
echo

# ---------- LOADING FUNCTION ----------
loading() {
    bar="■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■"
    for i in {1..30}; do
        printf "\r${BLUE}Installing... ${bar:0:i}${NC}"
        sleep 0.05
    done
    echo
}

loading

echo -e "${GREEN}▶ Updating System...${NC}"
sudo apt update -y

echo -e "${GREEN}▶ Installing Git...${NC}"
sudo apt install -y git

echo -e "${GREEN}▶ Installing Node.js LTS...${NC}"
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo -e "${GREEN}▶ Installing FFmpeg...${NC}"
sudo apt install -y ffmpeg

echo -e "${GREEN}▶ Installing ImageMagick...${NC}"
sudo apt install -y imagemagick

echo -e "${GREEN}▶ Installing WebP Tools...${NC}"
sudo apt install -y webp

echo -e "${GREEN}▶ Installing Python3 + Build Tools...${NC}"
sudo apt install -y python3 python3-pip build-essential

echo -e "${GREEN}▶ Installing Yarn + PNPM...${NC}"
npm install -g yarn pnpm

echo -e "${GREEN}▶ Installing PM2...${NC}"
npm install -g pm2

echo -e "${GREEN}▶ Installing SQLite...${NC}"
sudo apt install -y sqlite3

echo -e "${GREEN}▶ MongoDB Installation Optional${NC}"
read -p "Install MongoDB? (y/n): " mongo
if [[ "$mongo" == "y" ]]; then
    sudo apt install -y mongodb
fi

echo
echo -e "${BLUE}======================================================="
echo -e "${GREEN}      ✔ INSTALLATION COMPLETE — ARGANTARA DEV ✔"
echo -e "${BLUE}=======================================================${NC}"
