# Simple stats script
$date = Get-Date
$files = Get-ChildItem "logs" -Filter "*.md" | Where-Object { $_.Name -ne "template.md" }
$totalEntries = $files.Count
$thisWeek = ($files | Where-Object { (New-TimeSpan -Start $_.CreationTime -End $date).Days -le 7 }).Count
$thisMonth = ($files | Where-Object { $_.CreationTime.Month -eq $date.Month -and $_.CreationTime.Year -eq $date.Year }).Count

Write-Host "`nDiary Statistics"
Write-Host "================"
Write-Host "Total Entries: $totalEntries"
Write-Host "This Week: $thisWeek"
Write-Host "This Month: $thisMonth"
