# ============================================================
#   AUTO INSTALLER DEPENDENCIES BOT WA - WINDOWS
#   Developer : Argantara
# ============================================================

Clear-Host

Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "           AUTO INSTALLER – BOT DEPENDENCIES         " -ForegroundColor Cyan
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "                 Developer: ARGANTARA" -ForegroundColor Yellow
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host ""

# ===== CHECK ADMIN RIGHTS =====
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "❌ Please run PowerShell as *Administrator*!" -ForegroundColor Red
    pause
    exit
}

# ===== CHECK WINGET =====
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "❌ WINGET not found! Update Microsoft Store first." -ForegroundColor Red
    pause
    exit
}

# ===== LOADING ANIMATION =====
function Show-Loading {
    $chars = "/-\|"
    for ($i = 0; $i -lt 25; $i++) {
        $char = $chars[$i % $chars.Length]
        Write-Host -NoNewline "`rInstalling... $char" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 80
    }
    Write-Host ""
}

Show-Loading

# ===== SAFE WINGET INSTALL FUNCTION =====
function Install-Package {
    param (
        [string]$Name,
        [string]$Id
    )

    Write-Host "▶ Installing $Name..." -ForegroundColor Green
    winget install --id $Id `
        --accept-package-agreements `
        --accept-source-agreements `
        --silent `
        --disable-interactivity | Out-Null
}

# ===== INSTALL SYSTEM DEPENDENCIES =====
Install-Package "Node.js LTS" "OpenJS.NodeJS.LTS"
Install-Package "Git" "Git.Git"
Install-Package "FFmpeg" "Gyan.FFmpeg"
Install-Package "ImageMagick" "ImageMagick.ImageMagick"
Install-Package "WebP Tools" "Google.WebP"
Install-Package "Python 3" "Python.Python.3"
Install-Package "SQLite" "SQLite.SQLite"

# ===== REFRESH ENVIRONMENT PATH =====
Write-Host "▶ Refreshing Environment Variables..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path","User")

# ===== CHECK NODE & NPM =====
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js not detected. Restart PowerShell and re-run installer." -ForegroundColor Red
    pause
    exit
}

if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "❌ NPM not detected. Restart PowerShell and re-run installer." -ForegroundColor Red
    pause
    exit
}

# ===== NPM GLOBAL DEPENDENCIES =====
Write-Host "▶ Installing Yarn, PNPM, PM2..." -ForegroundColor Green

# Use Corepack (Recommended)
corepack enable | Out-Null
corepack prepare yarn@stable --activate | Out-Null
corepack prepare pnpm@latest --activate | Out-Null
npm install -g pm2 --force | Out-Null

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
Write-Host "ℹ If some commands fail, restart PowerShell once." -ForegroundColor Yellow
pause
