# Force GitHub Actions Configuration Script
Write-Host "🔧 Forcing GitHub Actions Configuration..." -ForegroundColor Cyan

# Check if .nojekyll exists
if (Test-Path ".nojekyll") {
    Write-Host "✅ .nojekyll file exists" -ForegroundColor Green
} else {
    Write-Host "❌ Creating .nojekyll file..." -ForegroundColor Yellow
    New-Item -Path ".nojekyll" -ItemType File -Force
    Write-Host "✅ .nojekyll file created" -ForegroundColor Green
}

# Check if there are any Jekyll-related files that shouldn't be there
$jekyllFiles = @("_config.yml", "Gemfile", "Gemfile.lock", "_site", ".jekyll-cache")
foreach ($file in $jekyllFiles) {
    if (Test-Path $file) {
        Write-Host "❌ Found Jekyll file: $file - Consider removing it" -ForegroundColor Red
    }
}

# Create a GitHub Pages bypass file
Write-Host "📄 Creating GitHub Pages configuration file..." -ForegroundColor Yellow
$githubPagesConfig = @"
# GitHub Pages Configuration
# This file forces GitHub to use GitHub Actions instead of Jekyll
# Generated on $(Get-Date)

source: github-actions
"@

$githubPagesConfig | Out-File -FilePath ".github-pages" -Encoding UTF8 -Force

# Verify current git status
Write-Host "`n📊 Current Repository Status:" -ForegroundColor Yellow
git status --porcelain

Write-Host "`n🎯 Next Steps:" -ForegroundColor Cyan
Write-Host "1. Commit these changes: git add . && git commit -m 'Force GitHub Actions deployment'" -ForegroundColor White
Write-Host "2. Push to GitHub: git push origin main" -ForegroundColor White
Write-Host "3. Go to GitHub Pages settings and verify Source is 'GitHub Actions'" -ForegroundColor White
Write-Host "4. If still showing Jekyll, disable and re-enable GitHub Pages" -ForegroundColor White

Write-Host "`n⚠️  CRITICAL: The GitHub Pages Source MUST be set to 'GitHub Actions' in the web interface!" -ForegroundColor Red
