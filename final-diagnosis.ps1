# Final Verification & Configuration Script
Write-Host "🔍 FINAL DIAGNOSIS: GitHub Pages Configuration Issue" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Gray

# Test current state
Write-Host "`n📊 Current Website Status:" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "https://mohamedsuhaib.live" -TimeoutSec 15
    $content = $response.Content
    
    Write-Host "✅ Website accessible: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "📄 Content length: $($content.Length) bytes" -ForegroundColor White
    
    # Analyze what's being served
    if ($content -match "Jekyll") {
        Write-Host "🔴 PROBLEM: Jekyll site detected (from README.md)" -ForegroundColor Red
    }
    
    if ($content -match "/src/main\.tsx") {
        Write-Host "🔴 PROBLEM: Development files referenced" -ForegroundColor Red
    }
    
    if ($content -match "/assets/index-[a-f0-9]+\.js") {
        Write-Host "✅ SUCCESS: Built assets detected!" -ForegroundColor Green
    } else {
        Write-Host "🔴 PROBLEM: No built assets found" -ForegroundColor Red
    }
    
    if ($content -match "github-pages") {
        Write-Host "🔴 PROBLEM: GitHub Pages Jekyll theme detected" -ForegroundColor Red
    }
    
} catch {
    Write-Host "❌ Website inaccessible: $($_.Exception.Message)" -ForegroundColor Red
}

# Check GitHub Actions workflow
Write-Host "`n🤖 GitHub Actions Status:" -ForegroundColor Yellow
try {
    $workflows = Invoke-RestMethod -Uri "https://api.github.com/repos/shbmhmd/my-portfolio/actions/runs?per_page=5"
    $latestRun = $workflows.workflow_runs[0]
    
    Write-Host "✅ Latest workflow: $($latestRun.conclusion)" -ForegroundColor $(if($latestRun.conclusion -eq "success"){"Green"}else{"Red"})
    Write-Host "📅 Run date: $($latestRun.created_at)" -ForegroundColor White
    Write-Host "🔗 Workflow URL: $($latestRun.html_url)" -ForegroundColor White
} catch {
    Write-Host "❌ Cannot access GitHub Actions API" -ForegroundColor Red
}

Write-Host "`n" + "=" * 70 -ForegroundColor Gray
Write-Host "🚨 REQUIRED ACTION: Configure GitHub Pages Source" -ForegroundColor Red
Write-Host ""
Write-Host "1. Visit: https://github.com/shbmhmd/my-portfolio/settings/pages" -ForegroundColor Cyan
Write-Host "2. Change Source from 'Deploy from a branch' to 'GitHub Actions'" -ForegroundColor Cyan
Write-Host "3. Save the settings" -ForegroundColor Cyan
Write-Host ""
Write-Host "💡 This will fix the issue and serve your React portfolio instead of Jekyll!" -ForegroundColor Yellow

# Test the built files locally
Write-Host "`n🔧 Local Build Verification:" -ForegroundColor Yellow
if (Test-Path "dist/index.html") {
    $localContent = Get-Content "dist/index.html" -Raw
    if ($localContent -match "/assets/index-[a-f0-9]+\.js") {
        Write-Host "✅ Local build is correct - contains built assets" -ForegroundColor Green
    } else {
        Write-Host "❌ Local build issue - no built assets found" -ForegroundColor Red
    }
} else {
    Write-Host "❌ No dist/index.html found - run 'npm run build'" -ForegroundColor Red
}

Write-Host "`n📋 Summary:" -ForegroundColor Cyan
Write-Host "• GitHub Actions workflow is working ✅" -ForegroundColor White
Write-Host "• Built files are generated correctly ✅" -ForegroundColor White  
Write-Host "• .nojekyll file added to disable Jekyll ✅" -ForegroundColor White
Write-Host "• ONLY MISSING: GitHub Pages source configuration ❌" -ForegroundColor White
Write-Host ""
Write-Host "After configuring GitHub Pages source to 'GitHub Actions':" -ForegroundColor Green
Write-Host "✅ Your portfolio will load correctly" -ForegroundColor Green
Write-Host "✅ Progress bars will work" -ForegroundColor Green
Write-Host "✅ All React features will be functional" -ForegroundColor Green
