# 🚀 Quick Start Guide

## Get Started in 5 Minutes

### How to Run These Commands

1. **Open PowerShell**: Press `Win + R`, type `powershell`, and press Enter
2. **Navigate to your diary folder**: 
   ```powershell
   cd "C:\path\to\your\engineering-diary"
   ```
3. **Run the commands**: Copy and paste each command from below

### 🚀 GitHub Setup (One-time)

If you want to push your diary to GitHub:

1. **Create a GitHub repository** at https://github.com/new

2. **Run the setup script**:
   ```powershell
   .\setup-github-simple.ps1 "https://github.com/yourusername/engineering-diary.git"
   ```

### 1. Create Your First Daily Log

Just run:
```powershell
.\new-entry.bat
```

Simple commands:
- � Create daily log: `.\new-entry.bat`
- 📋 Create project: `.\new-project.bat`
- 📊 Create review: `.\new-review.bat`
- 📈 View statistics: `.\stats.bat`
- 🔄 Push changes: `.\push.bat`

The `Push-DiaryChanges` command is smart! It will:
- 🤖 Automatically detect your changes
- 📝 Generate meaningful commit messages
- 🎨 Show beautiful previews
- 🚀 Push to GitHub

Examples of auto-generated commits:
```
📝 Daily log: 29 Aug 2025

📚 Multiple updates:
   └── 📝 Daily log: 29 Aug 2025
   └── 🚀 New project: ai assistant
   └── 📊 Week 01 review
```

> 💡 Just use `.\push.bat` to save your changes to GitHub

### 2. Start Writing

Open your new daily log file and fill in:
- What you worked on today
- What you learned
- Any challenges you faced
- Tomorrow's plan

### 3. Other Commands

To create a project or weekly review:
```powershell
# New project
.\new-project.bat

# Weekly review
.\new-review.bat
```

## 📝 Daily Routine (5-15 minutes)

1. **End of Day**: Write your daily log: `.\new-entry.bat`
2. **Push to GitHub**: Run `.\push.bat`
   > 🤖 Smart commits will be generated automatically!
3. **End of Week**: Complete weekly review: `.\new-review.bat`
4. **New Project**: Create project plan: `.\new-project.bat`
5. **Check Progress**: View your stats: `.\stats.bat`

> 💡 **Pro Tip**: Use `.\stats.bat` anytime to see your progress!

## 🎯 Pro Tips

- 🌱 **Start Simple**: Don't feel pressured to fill every section
- ⏰ **Be Consistent**: Even 5 minutes of daily reflection is valuable
- 📝 **Smart Commits**: Let the diary auto-generate beautiful commit messages
- 📊 **Track Progress**: Use `Update-DiaryStats` to monitor your journey
- 🎨 **Rich Content**: Use Mermaid diagrams and progress bars in your entries
- 🔄 **Review Regularly**: Look back at past entries to see progress
- ⚡ **Quick Updates**: Use the command shortcuts for efficiency
- 🎯 **Customize**: Adjust templates to fit your style

> 💡 **Tip**: The daily log template includes beautiful Mermaid diagrams, progress bars, and collapsible sections!

## 📁 File Naming Convention

- **Daily Logs**: `DD-MM-YYYY.md` (e.g., `15-01-2024.md`)
- **Weekly Reviews**: `week-XX.md` (e.g., `week-01.md`)
- **Projects**: `project-name.md` (e.g., `web-app-project.md`)

## 🔄 Regular Maintenance

- **Monthly**: Review all templates and update as needed
- **Quarterly**: Archive old entries and clean up
- **Yearly**: Reflect on your engineering journey

---

*Ready to start your engineering journey? Pick up your first template and begin! 🚀* 