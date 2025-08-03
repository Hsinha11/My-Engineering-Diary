# 📁 Scripts

This folder contains automation scripts for your engineering diary.

## 🚀 Available Scripts

### `setup-github.ps1`
**One-time setup script** to initialize your engineering diary on GitHub.

**Usage:**
```powershell
powershell -ExecutionPolicy Bypass -File "scripts\setup-github.ps1"
```

**What it does:**
- Checks if Git is installed
- Initializes git repository
- Configures git user settings
- Makes initial commit
- Guides you through GitHub setup

### `push-diary.ps1`
**Automated push script** to commit and push your diary entries to GitHub.

**Usage:**
```powershell
powershell -ExecutionPolicy Bypass -File "scripts\push-diary.ps1"
```

**What it does:**
- Checks for changes in diary files
- Adds all markdown files to git
- Creates a commit with timestamp
- Pushes to GitHub
- Shows progress and status

## 🎯 Quick Commands

### Setup GitHub (First time only)
```powershell
powershell -ExecutionPolicy Bypass -File "scripts\setup-github.ps1"
```

### Push to GitHub (After writing entries)
```powershell
.\push-diary.bat
```

## 📝 Workflow

1. **Write your diary entries** (daily logs, weekly reviews, project plans)
2. **Run the push script**: `.\push-diary.bat`
3. **Your entries are automatically synced to GitHub!**

## 🔧 Troubleshooting

### If push fails:
- Check your internet connection
- Verify your GitHub repository URL
- Make sure you have write permissions to the repository

### If setup fails:
- Install Git from https://git-scm.com/
- Create a GitHub account if you don't have one
- Follow the prompts in the setup script 