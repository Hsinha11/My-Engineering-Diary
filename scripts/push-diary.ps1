# Engineering Diary Git Push Script
# This script automatically commits and pushes your diary entries to GitHub

param(
    [string]$Message = "Update engineering diary entries",
    [switch]$Force = $false
)

# Get the script directory and navigate to the project root
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
Set-Location $ProjectRoot

Write-Host ">> Engineering Diary Git Push Script" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green

# Check if git is initialized
if (-not (Test-Path ".git")) {
    Write-Host "[WARNING] Git repository not found. Initializing..." -ForegroundColor Yellow
    git init
    Write-Host "[SUCCESS] Git repository initialized" -ForegroundColor Green
}

# Check for changes
$Status = git status --porcelain
if (-not $Status) {
    Write-Host "[INFO] No changes to commit" -ForegroundColor Blue
    exit 0
}

# Show what files have changed
Write-Host " Changes detected:" -ForegroundColor Cyan
git status --short

# Add all markdown files
Write-Host " Adding diary entries..." -ForegroundColor Cyan
git add logs/*.md
git add reviews/*.md
git add projects/*.md
git add README.md
git add QUICK_START.md
git add scripts/*
# Check if there are staged changes
$StagedChanges = git diff --cached --name-only
if (-not $StagedChanges) {
    Write-Host "[INFO] No diary entries to commit" -ForegroundColor Blue
    exit 0
}

# Commit changes
Write-Host " Committing changes..." -ForegroundColor Cyan
$CommitMessage = if ($Message -eq "Update engineering diary entries") {
    $Date = Get-Date -Format "yyyy-MM-dd"
    "Update engineering diary - $Date"
} else {
    $Message
}

git commit -m $CommitMessage

# Check if remote exists
$Remote = git remote get-url origin 2>$null
if (-not $Remote) {
    Write-Host "[WARNING] No remote repository configured" -ForegroundColor Yellow
    Write-Host "To set up GitHub remote, run:" -ForegroundColor Cyan
    Write-Host "git remote add origin https://github.com/yourusername/engineering-diary.git" -ForegroundColor White
    exit 1
}

# Push to GitHub
Write-Host ">> Pushing to GitHub..." -ForegroundColor Cyan
try {
    # Check if main branch exists, otherwise use master
    $CurrentBranch = git branch --show-current
    if (-not $CurrentBranch) {
        # Create main branch if it doesn't exist
        git checkout -b main
    }
    git push origin main
    Write-Host "[SUCCESS] Successfully pushed to GitHub!" -ForegroundColor Green
} catch {
    Write-Host "[FAILED] Failed to push to GitHub" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Trying with master branch..." -ForegroundColor Yellow
    try {
        git push origin master
        Write-Host "[SUCCESS] Successfully pushed to GitHub using master branch!" -ForegroundColor Green
    } catch {
        Write-Host "[FAILED] Failed to push to GitHub" -ForegroundColor Red
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

Write-Host ">> Diary entries successfully synced to GitHub!" -ForegroundColor Green