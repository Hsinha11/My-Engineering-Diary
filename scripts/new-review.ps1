# Simple new review script
$date = Get-Date
$weekNum = [System.Globalization.ISOWeek]::GetWeekOfYear($date)
$newPath = "reviews/week-$('{0:D2}' -f $weekNum).md"
Copy-Item "reviews/template.md" $newPath -ErrorAction Stop
Write-Host "Created new weekly review: $newPath"
code $newPath
