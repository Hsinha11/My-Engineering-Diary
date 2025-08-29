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

1. **Run the setup script**:
   ```powershell
   powershell -ExecutionPolicy Bypass -File "scripts\setup-github-simple.ps1"
   ```

2. **Create a GitHub repository** at https://github.com/new

3. **Add the remote** (replace with your repo URL):
   ```powershell
   git remote add origin https://github.com/yourusername/engineering-diary.git
   git push -u origin main
   ```

### 1. Create Your First Daily Log

```powershell
# Copy the template and create today's log (Windows PowerShell)
Copy-Item "logs/template.md" "logs/$(Get-Date -Format 'dd-MM-yyyy').md"
```

### 2. Start Writing

Open your new daily log file and fill in:
- What you worked on today
- What you learned
- Any challenges you faced
- Tomorrow's plan

### 3. Create Your First Project
```powershell
# Copy the project template
Copy-Item "projects/template.md" "projects/my-first-project.md"
```

### 4. Weekly Review (End of Week)
```powershell
# Create your first weekly review
Copy-Item "reviews/template.md" "reviews/week-01.md"
```

## 📝 Daily Routine (5-15 minutes)

1. **End of Day**: Write your daily log
2. **Push to GitHub**: Run `.\push-diary.bat` or double-click the file
3. **End of Week**: Complete weekly review
4. **New Project**: Create project plan
5. **Project Complete**: Update with lessons learned

## 🎯 Pro Tips

- **Start Simple**: Don't feel pressured to fill every section
- **Be Consistent**: Even 5 minutes of daily reflection is valuable
- **Use Templates**: Copy templates for new entries
- **Review Regularly**: Look back at past entries to see progress
- **Customize**: Adjust templates to fit your style

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