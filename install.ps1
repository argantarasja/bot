# ============================================================
#   AUTO INSTALLER DEPENDENCIES BOT WA - WINDOWS
#   Developer : Argantara
#   Final Fixed & Hardened Version
# ============================================================

Clear-Host

# ===== TEMPORARY EXECUTION POLICY BYPASS (SAFE) =====
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "           AUTO INSTALLER – BOT DEPENDENCIES         " -ForegroundColor Cyan
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "                 Developer: ARGANTARA" -ForegroundColor Yellow
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host ""

# ===== CHECK ADMIN =====
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "❌ Run PowerShell as Administrator!" -ForegroundColor Red
    pause
    exit
}

# ===== CHECK WINGET =====
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Winget not found. Update Microsoft Store." -ForegroundColor Red
    pause
    exit
}

# ===== INSTALL FUNCTION =====
function Install-Package {
    param($Name, $Id)
    Write-Host "▶ Installing $Name..." -ForegroundColor Green
    winget install --id $Id `
        --accept-package-agreements `
        --accept-source-agreements `
        --silent `
        --disable-interactivity | Out-Null
}

# ===== INSTALL CORE DEPENDENCIES =====
Install-Package "Node.js LTS" "OpenJS.NodeJS.LTS"
Install-Package "Git" "Git.Git"
Install-Package "FFmpeg" "Gyan.FFmpeg"
Install-Package "ImageMagick" "ImageMagick.ImageMagick"
Install-Package "WebP Tools" "Google.WebP"
Install-Package "Python 3" "Python.Python.3"
Install-Package "SQLite" "SQLite.SQLite"

# ===== REFRESH PATH =====
Write-Host "▶ Refreshing PATH..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path","User")

# ===== VERIFY NODE =====
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js not detected. Restart PowerShell." -ForegroundColor Red
    pause
    exit
}

# ===== USE CMD FALLBACK (AVOID .ps1 BLOCK) =====
$npmCmd = "npm.cmd"

# ===== COREPACK =====
Write-Host "▶ Enabling Corepack..." -ForegroundColor Green
& node -e "require('child_process').execSync('corepack enable')" | Out-Null

Write-Host "▶ Installing Yarn & PNPM..." -ForegroundColor Green
& $npmCmd install -g yarn pnpm pm2 --force | Out-Null

# ===== OPTIONAL MONGODB =====
$mongo = Read-Host "Install MongoDB Server? (y/n)"
if ($mongo -eq "y") {
    Install-Package "MongoDB Server" "MongoDB.Server"
}

# ===== FINISH =====
Write-Host ""
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "   ✔ INSTALLATION COMPLETE — ARGANTARA DEV ✔" -ForegroundColor Green
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "ℹ Restart PowerShell once before running the bot." -ForegroundColor Yellow
pause
