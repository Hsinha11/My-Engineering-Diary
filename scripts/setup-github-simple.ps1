# Engineering Diary GitHub Setup Script
# This script helps you set up your engineering diary on GitHub

Write-Host "Engineering Diary GitHub Setup" -ForegroundColor Green
Write-Host "==============================" -ForegroundColor Green

# Check if git is installed
try {
    $GitVersion = git --version
    Write-Host "Git found: $GitVersion" -ForegroundColor Green
} catch {
    Write-Host "Git not found. Please install Git from https://git-scm.com/" -ForegroundColor Red
    exit 1
}

# Initialize git repository if not already done
if (-not (Test-Path ".git")) {
    Write-Host "Initializing git repository..." -ForegroundColor Cyan
    git init
    Write-Host "Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "Git repository already exists" -ForegroundColor Green
}

# Configure git user if not set
$UserName = git config user.name
$UserEmail = git config user.email

if (-not $UserName -or -not $UserEmail) {
    Write-Host "Setting up git configuration..." -ForegroundColor Cyan
    
    if (-not $UserName) {
        $UserName = Read-Host "Enter your name for git commits"
        git config user.name $UserName
    }
    
    if (-not $UserEmail) {
        $UserEmail = Read-Host "Enter your email for git commits"
        git config user.email $UserEmail
    }
    
    Write-Host "Git configuration set" -ForegroundColor Green
} else {
    Write-Host "Git configuration already set" -ForegroundColor Green
}

# Add all files to git
Write-Host "Adding files to git..." -ForegroundColor Cyan
git add .

# Make initial commit
Write-Host "Making initial commit..." -ForegroundColor Cyan
git commit -m "Initial engineering diary setup"

# Check if remote exists
$Remote = git remote get-url origin 2>$null
if (-not $Remote) {
    Write-Host "Setting up GitHub remote..." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To complete setup, you need to:" -ForegroundColor Yellow
    Write-Host "1. Create a new repository on GitHub" -ForegroundColor White
    Write-Host "2. Run this command (replace with your repo URL):" -ForegroundColor White
    Write-Host "   git remote add origin https://github.com/yourusername/engineering-diary.git" -ForegroundColor Cyan
    Write-Host "3. Run this command to push:" -ForegroundColor White
    Write-Host "   git push -u origin main" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "GitHub remote already configured: $Remote" -ForegroundColor Green
    Write-Host "Ready to push! Run: .\push-diary.bat" -ForegroundColor Green
}

Write-Host ""
Write-Host "Setup complete! Your engineering diary is ready for GitHub." -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "   - Create a new repository on GitHub" -ForegroundColor White
Write-Host "   - Add the remote URL" -ForegroundColor White
Write-Host "   - Run .\push-diary.bat to push your entries" -ForegroundColor White 