# DNS and Website Check Script
Write-Host "Checking DNS and website status for mohamedsuhaib.live" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Gray

# Check DNS resolution
Write-Host "`nChecking DNS resolution..." -ForegroundColor Yellow
try {
    $dnsResult = Resolve-DnsName -Name "mohamedsuhaib.live" -Type A -ErrorAction Stop
    Write-Host "✅ DNS Resolution successful:" -ForegroundColor Green
    foreach ($record in $dnsResult) {
        Write-Host "   IP: $($record.IPAddress)" -ForegroundColor White
    }
} catch {
    Write-Host "❌ DNS Resolution failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Check CNAME for www subdomain
Write-Host "`nChecking www CNAME..." -ForegroundColor Yellow
try {
    $cnameResult = Resolve-DnsName -Name "www.mohamedsuhaib.live" -Type CNAME -ErrorAction Stop
    Write-Host "✅ CNAME Resolution successful:" -ForegroundColor Green
    foreach ($record in $cnameResult) {
        Write-Host "   CNAME: $($record.NameHost)" -ForegroundColor White
    }
} catch {
    Write-Host "⚠️  CNAME Resolution failed (this might be normal): $($_.Exception.Message)" -ForegroundColor Yellow
}

# Check HTTP/HTTPS responses
Write-Host "`nChecking website responses..." -ForegroundColor Yellow

$urls = @(
    "https://mohamedsuhaib.live",
    "http://mohamedsuhaib.live",
    "https://www.mohamedsuhaib.live",
    "https://shbmhmd.github.io/my-portfolio"
)

foreach ($url in $urls) {
    try {
        Write-Host "Testing $url..." -ForegroundColor Cyan
        $response = Invoke-WebRequest -Uri $url -TimeoutSec 30 -ErrorAction Stop
        Write-Host "✅ Status: $($response.StatusCode) - $($response.StatusDescription)" -ForegroundColor Green
        
        # Check if it's a redirect
        if ($response.StatusCode -eq 200) {
            $contentLength = $response.Content.Length
            Write-Host "   Content length: $contentLength bytes" -ForegroundColor White
            
            if ($contentLength -lt 100) {
                Write-Host "   ⚠️  Warning: Content seems very small, might be a white page" -ForegroundColor Yellow
            }
        }
    } catch {
        Write-Host "❌ Failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host ""
}

# Check GitHub Pages status
Write-Host "Checking GitHub Pages repository..." -ForegroundColor Yellow
try {
    $githubResponse = Invoke-RestMethod -Uri "https://api.github.com/repos/shbmhmd/my-portfolio/pages" -ErrorAction Stop
    Write-Host "✅ GitHub Pages Status: $($githubResponse.status)" -ForegroundColor Green
    Write-Host "   Source: $($githubResponse.source.branch) branch" -ForegroundColor White
    Write-Host "   Custom domain: $($githubResponse.cname)" -ForegroundColor White
} catch {
    Write-Host "❌ GitHub Pages API check failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n" + "=" * 60 -ForegroundColor Gray
Write-Host "Check complete! " -ForegroundColor Cyan

Write-Host "`nTroubleshooting Tips:" -ForegroundColor Yellow
Write-Host "1. If DNS fails, check your domain registrar's DNS settings" -ForegroundColor White
Write-Host "2. If website shows white page, check GitHub Actions deployment logs" -ForegroundColor White
Write-Host "3. DNS changes can take up to 48 hours to propagate globally" -ForegroundColor White
Write-Host "4. Try accessing https://shbmhmd.github.io/my-portfolio directly" -ForegroundColor White
