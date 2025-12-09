# ============================================================
#   AUTO INSTALLER DEPENDENCIES BOT WA
#   Developer : Argantara
#   Platform  : Windows 10/11
# ============================================================

Clear-Host

Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "        AUTO INSTALLER – BOT WHATSAPP DEPENDENCIES     " -ForegroundColor Cyan
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "                   Developer: ARGANTARA" -ForegroundColor Yellow
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host ""

# Loading Animation
function Show-Loading {
    $chars = "/-\|"
    for ($i=0; $i -lt 25; $i++) {
        $char = $chars[$i % $chars.Length]
        Write-Host -NoNewline "`rInstalling... $char" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 80
    }
    Write-Host ""
}

Show-Loading

Write-Host "▶ Installing Node.js LTS..." -ForegroundColor Green
winget install OpenJS.NodeJS.LTS -h --accept-package-agreements --accept-source-agreements

Write-Host "▶ Installing Git..." -ForegroundColor Green
winget install Git.Git -h --accept-package-agreements --accept-source-agreements

Write-Host "▶ Installing FFmpeg..." -ForegroundColor Green
winget install Gyan.FFmpeg -h --accept-package-agreements --accept-source-agreements

Write-Host "▶ Installing ImageMagick..." -ForegroundColor Green
winget install ImageMagick.ImageMagick -h --accept-package-agreements --accept-source-agreements

Write-Host "▶ Installing WebP Tools..." -ForegroundColor Green
winget install Google.WebP -h --accept-package-agreements --accept-source-agreements

Write-Host "▶ Installing Python 3..." -ForegroundColor Green
winget install Python.Python.3 -h --accept-package-agreements --accept-source-agreements

Write-Host "▶ Installing Build Tools..." -ForegroundColor Green
npm install --global --production windows-build-tools

Write-Host "▶ Installing Yarn, PNPM, PM2..." -ForegroundColor Green
npm install -g yarn pnpm pm2

Write-Host "▶ Installing SQLite..." -ForegroundColor Green
winget install SQLite.SQLite -h --accept-package-agreements --accept-source-agreements

$mongo = Read-Host "Install MongoDB? (y/n)"
if ($mongo -eq "y") {
    Write-Host "▶ Installing MongoDB..." -ForegroundColor Green
    winget install MongoDB.Server -h --accept-package-agreements --accept-source-agreements
}

Write-Host ""
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "  ✔ INSTALLATION COMPLETE — ARGANTARA DEV ✔" -ForegroundColor Green
Write-Host "=======================================================" -ForegroundColor Cyan
