# Super simple push script
$date = Get-Date
$msg = "[DIARY] Updates for $($date.ToString('dd MMM yyyy'))"

Write-Host "`nPushing diary updates...`n" -ForegroundColor Cyan
git add .
git commit -m $msg
git push
Write-Host "`nSuccessfully pushed updates!" -ForegroundColor Green
