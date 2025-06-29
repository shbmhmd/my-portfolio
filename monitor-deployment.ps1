# Website Status Monitor
Write-Host "Monitoring deployment of mohamedsuhaib.live..." -ForegroundColor Cyan
Write-Host "Starting at: $(Get-Date)" -ForegroundColor Gray
Write-Host ""

$maxAttempts = 20
$attempt = 1
$deployedCorrectly = $false

while ($attempt -le $maxAttempts -and -not $deployedCorrectly) {
    Write-Host "Attempt $attempt/$maxAttempts - Checking deployment..." -ForegroundColor Yellow
    
    try {
        $response = Invoke-WebRequest -Uri "https://mohamedsuhaib.live" -TimeoutSec 15 -ErrorAction Stop
        $content = $response.Content
        
        # Check if the content contains the built assets (indicates successful deployment)
        if ($content -match '/assets/index-[a-f0-9]+\.js' -and $content -match '/assets/index-[a-f0-9]+\.css') {
            Write-Host "✅ SUCCESS! Website is now serving built assets." -ForegroundColor Green
            Write-Host "   Found JS bundle: $($matches[0])" -ForegroundColor White
            Write-Host "   Content length: $($response.Content.Length) bytes" -ForegroundColor White
            $deployedCorrectly = $true
            
            # Test if the page actually loads the app
            if ($content.Length -gt 1000) {
                Write-Host "✅ Content size looks good - portfolio should be fully functional!" -ForegroundColor Green
            } else {
                Write-Host "⚠️  Content is still small - there might be loading issues" -ForegroundColor Yellow
            }
        } else {
            Write-Host "❌ Still serving development files (src/main.tsx found)" -ForegroundColor Red
            Write-Host "   Content length: $($response.Content.Length) bytes" -ForegroundColor White
        }
    } catch {
        Write-Host "❌ Request failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    if (-not $deployedCorrectly) {
        Write-Host "   Waiting 30 seconds before next check..." -ForegroundColor Gray
        Start-Sleep -Seconds 30
    }
    
    $attempt++
}

if (-not $deployedCorrectly) {
    Write-Host "`n❌ Deployment did not complete successfully after $maxAttempts attempts." -ForegroundColor Red
    Write-Host "Check GitHub Actions at: https://github.com/shbmhmd/my-portfolio/actions" -ForegroundColor White
} else {
    Write-Host "`n🎉 Deployment completed successfully!" -ForegroundColor Green
    Write-Host "Your portfolio is now live at: https://mohamedsuhaib.live" -ForegroundColor Cyan
}

Write-Host "`nFinal check completed at: $(Get-Date)" -ForegroundColor Gray
