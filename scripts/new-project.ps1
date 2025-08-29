# Simple new project script
$projectName = Read-Host "Enter project name"
Copy-Item "projects/template.md" "projects/$projectName.md" -ErrorAction Stop
Write-Host "Created new project: projects/$projectName.md"
code "projects/$projectName.md"
