# Simple new entry script
$date = Get-Date
$templatePath = "logs/template.md"
$newPath = "logs/$($date.ToString('dd-MM-yyyy')).md"

Copy-Item $templatePath $newPath -ErrorAction Stop
$content = Get-Content $newPath -Raw
$content = $content.Replace("DD-MM-YYYY", $date.ToString('dd-MM-yyyy'))
$content | Set-Content $newPath
Write-Host "Created new daily log: $newPath"
code $newPath
