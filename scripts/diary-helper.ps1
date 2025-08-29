# Diary Helper Functions
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function New-DiaryEntry {
    param (
        [string]$Type = "daily"
    )
    
    $date = Get-Date
    
    switch ($Type.ToLower()) {
        "daily" {
            $templatePath = "logs/template.md"
            $newPath = "logs/$($date.ToString('dd-MM-yyyy')).md"
            
            Copy-Item $templatePath $newPath
            
            $content = Get-Content $newPath -Raw
            $content = $content.Replace("DD-MM-YYYY", $date.ToString('dd-MM-yyyy'))
            
            $prevDate = $date.AddDays(-1)
            $prevLink = $prevDate.ToString('dd-MM-yyyy')
            $content = $content.Replace("[Previous Day'\''s Log](./DD-MM-YYYY.md)", 
                                     "[Previous Day'\''s Log](./$prevLink.md)")
            
            $weekNum = [System.Globalization.ISOWeek]::GetWeekOfYear($date)
            $content = $content.Replace("week-XX", "week-$('{0:D2}' -f $weekNum)")
            
            $content | Set-Content $newPath
            
            Write-Host "[INFO] Created new daily log: $newPath"
            code $newPath
        }
        "project" {
            $projectName = Read-Host "Enter project name"
            $templatePath = "projects/template.md"
            $newPath = "projects/$($projectName).md"
            
            Copy-Item $templatePath $newPath
            Write-Host "[INFO] Created new project: $newPath"
            code $newPath
        }
        "review" {
            $weekNum = [System.Globalization.ISOWeek]::GetWeekOfYear($date)
            $templatePath = "reviews/template.md"
            $newPath = "reviews/week-$('{0:D2}' -f $weekNum).md"
            
            Copy-Item $templatePath $newPath
            Write-Host "[INFO] Created new weekly review: $newPath"
            code $newPath
        }
    }
}

function Update-DiaryStats {
    param (
        [string]$Path = "logs"
    )
    
    $stats = @{
        TotalEntries = 0
        ThisWeek = 0
        ThisMonth = 0
        AverageWordsPerEntry = 0
        TopTags = @{}
    }
    
    $date = Get-Date
    $files = Get-ChildItem $Path -Filter "*.md"
    $totalWords = 0
    
    foreach ($file in $files) {
        if ($file.Name -eq "template.md") { continue }
        
        $stats.TotalEntries++
        $content = Get-Content $file.FullName -Raw
        
        $words = ($content -split '\s+').Count
        $totalWords += $words
        
        $fileDate = [datetime]::ParseExact($file.BaseName, "dd-MM-yyyy", $null)
        
        if ($fileDate.Year -eq $date.Year -and $fileDate.Month -eq $date.Month) {
            $stats.ThisMonth++
        }
        
        $weekDiff = New-TimeSpan -Start $fileDate -End $date
        if ($weekDiff.Days -le 7) {
            $stats.ThisWeek++
        }
        
        $tags = [regex]::Matches($content, '#\w+')
        foreach ($tag in $tags) {
            if ($stats.TopTags.ContainsKey($tag.Value)) {
                $stats.TopTags[$tag.Value]++
            } else {
                $stats.TopTags[$tag.Value] = 1
            }
        }
    }
    
    $stats.AverageWordsPerEntry = [math]::Round($totalWords / $stats.TotalEntries)
    
    Write-Host "`n[STATS] Diary Statistics"
    Write-Host "================="
    Write-Host "Total Entries: $($stats.TotalEntries)"
    Write-Host "Entries This Week: $($stats.ThisWeek)"
    Write-Host "Entries This Month: $($stats.ThisMonth)"
    Write-Host "Average Words per Entry: $($stats.AverageWordsPerEntry)"
    Write-Host "`nTop Tags:"
    $stats.TopTags.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 5 | ForEach-Object {
        Write-Host "$($_.Key): $($_.Value) times"
    }
}

function Push-DiaryChanges {
    param (
        [string]$CustomMessage
    )
    
    $changes = git status --porcelain
    if (-not $changes) {
        Write-Host "[INFO] No changes to commit! Your diary is up to date!"
        return
    }

    $newEntries = @()
    $modifiedEntries = @()
    $date = Get-Date
    
    foreach ($change in $changes -split "`n") {
        $status = $change.Substring(0, 2)
        $file = $change.Substring(3)
        
        if ($file -like "*template.md") { continue }
        
        if ($file -match "logs/\d{2}-\d{2}-\d{4}\.md$") {
            $entryDate = [datetime]::ParseExact(($file -replace "logs/|\.md", ""), "dd-MM-yyyy", $null)
            if ($status -eq "??" -or $status -eq "A ") {
                $newEntries += "[LOG] Daily log: $($entryDate.ToString('dd MMM yyyy'))"
            } else {
                $modifiedEntries += "[UPDATE] Daily: $($entryDate.ToString('dd MMM yyyy'))"
            }
        }
        elseif ($file -match "projects/.*\.md$") {
            $projectName = ($file -replace "projects/|\.md", "") -replace "-", " "
            if ($status -eq "??" -or $status -eq "A ") {
                $newEntries += "[NEW] Project: $projectName"
            } else {
                $modifiedEntries += "[UPDATE] Project: $projectName"
            }
        }
        elseif ($file -match "reviews/week-\d{2}\.md$") {
            $weekNum = [regex]::Match($file, "week-(\d{2})").Groups[1].Value
            if ($status -eq "??" -or $status -eq "A ") {
                $newEntries += "[REVIEW] Week $weekNum"
            } else {
                $modifiedEntries += "[UPDATE] Week $weekNum review"
            }
        }
    }

    $commitMsg = if ($CustomMessage) {
        $CustomMessage
    } else {
        $allEntries = @($newEntries) + @($modifiedEntries)
        if ($allEntries.Count -eq 0) {
            "[DIARY] Update: $($date.ToString('dd MMM yyyy'))"
        } elseif ($allEntries.Count -eq 1) {
            $allEntries[0]
        } else {
            "[MULTI] Updates:`n`n" + ($allEntries -join "`n")
        }
    }

    Write-Host "`n[INFO] Pushing diary updates...`n" -ForegroundColor Cyan
    Write-Host "Changes to be committed:" -ForegroundColor Yellow
    git status --short | ForEach-Object {
        $color = if ($_ -match '^\?\?') { 'Green' } else { 'Yellow' }
        Write-Host $_ -ForegroundColor $color
    }
    
    Write-Host "`nCommit message:" -ForegroundColor Yellow
    Write-Host $commitMsg -ForegroundColor Cyan
    Write-Host ""

    git add .
    git commit -m $commitMsg
    git push

    Write-Host "`n[SUCCESS] Pushed diary updates!" -ForegroundColor Green
    Write-Host "[COMMIT] $commitMsg`n"
}

function Initialize-DiaryRepo {
    param (
        [string]$RepoUrl
    )
    
    if (-not (Test-Path ".git")) {
        git init
        Write-Host "[INFO] Initialized git repository"
    }
    
    if (-not (Test-Path ".gitignore")) {
        @"
.vscode/
*.log
temp/
"@ | Set-Content ".gitignore"
        Write-Host "[INFO] Created .gitignore file"
    }
    
    if (-not $RepoUrl) {
        Write-Host "[INFO] No repository URL provided. Please create a repository at https://github.com/new"
        Write-Host "Then run this command again with the repository URL"
        return
    }
    
    git remote add origin $RepoUrl
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git push -u origin main
    
    Write-Host "[SUCCESS] Successfully initialized and pushed to GitHub!"
}

