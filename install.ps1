# ============================================================
#   AUTO INSTALLER DEPENDENCIES BOT WA - WINDOWS
#   Developer : Argantara
#   Fixed & Updated
# ============================================================

Clear-Host

Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "           AUTO INSTALLER – BOT DEPENDENCIES         " -ForegroundColor Cyan
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "                     Developer: ARGANTARA" -ForegroundColor Yellow
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host ""

# ===== CHECK ADMIN RIGHTS =====
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "❌ Please run PowerShell as *Administrator*!" -ForegroundColor Red
    exit
}

# ===== CHECK WINGET =====
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "❌ WINGET not found! Please update Microsoft Store first." -ForegroundColor Red
    exit
}

# ===== Loading Animation =====
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

# ===== Install via Winget with Safe Execution =====
function Install-Package($name, $id) {
    Write-Host "▶ Installing $name..." -ForegroundColor Green
    winget install $id -h --accept-package-agreements --accept-source-agreements `
        --silent --disable-interactivity | Out-Null
}

Install-Package "Node.js" "OpenJS.NodeJS.LTS"
Install-Package "Git" "Git.Git"
Install-Package "FFmpeg" "Gyan.FFmpeg"
Install-Package "ImageMagick" "ImageMagick.ImageMagick"
Install-Package "WebP Tools" "Google.WebP"
Install-Package "Python 3" "Python.Python.3"
Install-Package "SQLite" "SQLite.SQLite"

# ===== NPM DEPENDENCIES =====
Write-Host "▶ Installing Yarn, PNPM, PM2..." -ForegroundColor Green
npm install -g yarn pnpm pm2 --force

# ===== Optional MongoDB =====
$mongo = Read-Host "Install MongoDB? (y/n)"
if ($mongo -eq "y") {
    Install-Package "MongoDB Server" "MongoDB.Server"
}

Write-Host ""
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "      ✔ INSTALLATION COMPLETE — ARGANTARA DEV ✔" -ForegroundColor Green
Write-Host "=======================================================" -ForegroundColor Cyan
