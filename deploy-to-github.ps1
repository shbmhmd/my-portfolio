# GitHub Upload Script for Windows PowerShell
# Run this script after installing Git

Write-Host "🚀 Starting GitHub upload process..." -ForegroundColor Cyan

# Check if git is installed
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git is not installed. Please install Git first:" -ForegroundColor Red
    Write-Host "   Download from: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Navigate to project directory
Set-Location "d:\Downloads\Unison\react-portfolio-projects\my-portfolio"

# Initialize git repository
Write-Host "📁 Initializing Git repository..." -ForegroundColor Green
git init

# Add all files
Write-Host "📄 Adding all files..." -ForegroundColor Green
git add .

# Create initial commit
Write-Host "💾 Creating initial commit..." -ForegroundColor Green
git commit -m "Initial commit: Modern React Portfolio with Admin Panel

Features:
- Modern responsive design with glassmorphism effects
- Comprehensive admin panel with multi-user authentication
- AI chatbot with professional icons
- Theme toggle with custom SVG icons
- Skills visualization with professional icons
- Contact form with validation
- Blog management system
- Project showcase
- User management system
- Content editing capabilities"

# Set main branch
Write-Host "🌿 Setting main branch..." -ForegroundColor Green
git branch -M main

Write-Host "✅ Local repository setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "🔗 Next steps:" -ForegroundColor Yellow
Write-Host "1. Create a new repository on GitHub.com"
Write-Host "2. Copy the repository URL"
Write-Host "3. Run: git remote add origin YOUR_REPO_URL"
Write-Host "4. Run: git push -u origin main"
Write-Host ""
Write-Host "📱 Or use GitHub Desktop for an easier experience!"
