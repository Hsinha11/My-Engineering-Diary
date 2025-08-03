# Fix Branch Issue Script
# This script fixes the "src refspec main does not match any" error

Write-Host "Fixing branch issue..." -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green

# Check current branch
$CurrentBranch = git branch --show-current
Write-Host "Current branch: $CurrentBranch" -ForegroundColor Cyan

if (-not $CurrentBranch) {
    Write-Host "No branch detected. Creating main branch..." -ForegroundColor Yellow
    git checkout -b main
    Write-Host "Created and switched to main branch" -ForegroundColor Green
} else {
    Write-Host "Using existing branch: $CurrentBranch" -ForegroundColor Green
}

# Check if we have commits
$CommitCount = git rev-list --count HEAD 2>$null
if ($CommitCount -eq "0") {
    Write-Host "No commits found. Making initial commit..." -ForegroundColor Yellow
    git add .
    git commit -m "Initial engineering diary setup"
    Write-Host "Initial commit created" -ForegroundColor Green
}

# Try to push
Write-Host "Attempting to push to GitHub..." -ForegroundColor Cyan
try {
    git push -u origin main
    Write-Host "Successfully pushed to main branch!" -ForegroundColor Green
} catch {
    Write-Host "Failed to push to main, trying master..." -ForegroundColor Yellow
    try {
        git push -u origin master
        Write-Host "Successfully pushed to master branch!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to push. Please check your remote configuration." -ForegroundColor Red
        Write-Host "Run: git remote -v" -ForegroundColor Cyan
        Write-Host "If no remote is set, run:" -ForegroundColor Cyan
        Write-Host "git remote add origin https://github.com/Hsinha11/My-Engineering-Diary.git" -ForegroundColor White
    }
}

Write-Host "Branch fix complete!" -ForegroundColor Green 