#!/bin/bash
set -e

# ============================================================
#   AUTO INSTALLER DEPENDENCIES BOT WHATSAPP (MENU VERSION)
#   Developer : Argantara
#   Platform  : Kali / Ubuntu / Debian / WSL
# ============================================================

clear

# ---------- COLOR ----------
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

# ---------- ROOT CHECK ----------
if [[ $EUID -ne 0 ]]; then
  echo -e "${RED}❌ Jalankan script ini dengan sudo${NC}"
  exit 1
fi

# ---------- HEADER ----------
echo -e "${BLUE}"
echo "======================================================="
echo "   AUTO INSTALLER – BOT WHATSAPP DEPENDENCIES (MENU)   "
echo "======================================================="
echo -e "${YELLOW}              Developer: ARGANTARA                     "
echo -e "${BLUE}=======================================================${NC}"
echo

# ---------- LOADING ----------
loading() {
    bar="████████████████████████████████████"
    for i in {1..30}; do
        printf "\r${BLUE}Preparing... ${bar:0:i}${NC}"
        sleep 0.03
    done
    echo
}

loading

# ---------- UPDATE ----------
update_system() {
  echo -e "${GREEN}▶ Updating system...${NC}"
  apt update -y && apt upgrade -y
}

# ---------- BASE TOOLS ----------
install_base() {
  echo -e "${GREEN}▶ Installing base tools...${NC}"
  apt install -y curl wget git build-essential software-properties-common ca-certificates gnupg
}

# ---------- NODE.JS ----------
install_node() {
  if ! command -v node &> /dev/null; then
    echo -e "${GREEN}▶ Installing Node.js LTS...${NC}"
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    apt install -y nodejs npm
  else
    echo -e "${YELLOW}✔ Node.js already installed${NC}"
  fi

  if ! command -v npm &> /dev/null; then
    echo -e "${GREEN}▶ Installing npm...${NC}"
    apt install -y npm
  fi
}

# ---------- MEDIA ----------
install_media() {
  echo -e "${GREEN}▶ Installing FFmpeg, ImageMagick & WebP...${NC}"
  apt install -y ffmpeg imagemagick webp
}

# ---------- PYTHON ----------
install_python() {
  echo -e "${GREEN}▶ Installing Python3 & Pip...${NC}"
  apt install -y python3 python3-pip
}

# ---------- NPM GLOBAL ----------
install_npm_global() {
  echo -e "${GREEN}▶ Installing Yarn, PNPM & PM2...${NC}"
  npm install -g yarn pnpm pm2
}

# ---------- SQLITE ----------
install_sqlite() {
  echo -e "${GREEN}▶ Installing SQLite...${NC}"
  apt install -y sqlite3
}

# ---------- MONGODB ----------
install_mongodb() {
  read -p "Install MongoDB? (y/n): " mongo
  if [[ "$mongo" =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}▶ Installing MongoDB...${NC}"
    apt install -y mongodb-org || \
    echo -e "${YELLOW}⚠ MongoDB repo not available, skipped${NC}"
  fi
}

# ---------- INSTALL ALL ----------
install_all() {
  update_system
  install_base
  install_node
  install_media
  install_python
  install_npm_global
  install_sqlite
  install_mongodb
}

# ---------- MENU ----------
echo "Pilih opsi instalasi:"
echo
echo "1) Install Base Tools"
echo "2) Install Node.js + npm"
echo "3) Install Media Tools (FFmpeg, ImageMagick, WebP)"
echo "4) Install Python3 + Pip"
echo "5) Install Yarn, PNPM & PM2"
echo "6) Install SQLite"
echo "7) Install MongoDB (Optional)"
echo "8) Install ALL"
echo "0) Keluar"
echo
read -p "Masukkan nomor pilihan: " OPTION
echo

case $OPTION in
  1) install_base ;;
  2) install_node ;;
  3) install_media ;;
  4) install_python ;;
  5) install_npm_global ;;
  6) install_sqlite ;;
  7) install_mongodb ;;
  8) install_all ;;
  0) echo "👋 Keluar..."; exit 0 ;;
  *) echo -e "${RED}❌ Pilihan tidak valid${NC}" ;;
esac

# ---------- FINISH ----------
echo
echo -e "${BLUE}======================================================="
echo -e "${GREEN} ✔ INSTALLATION COMPLETE — ARGANTARA DEV ✔"
echo -e "${BLUE}=======================================================${NC}"
