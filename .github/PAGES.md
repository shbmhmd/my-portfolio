# GitHub Pages Settings
# This repository uses GitHub Actions for deployment
# Source: GitHub Actions (not "Deploy from a branch")

Please configure GitHub Pages settings:
1. Go to repository Settings → Pages
2. Set Source to "GitHub Actions" (not "Deploy from a branch")
3. This will use the .github/workflows/deploy.yml file for deployment

The site should deploy from the 'dist' folder built by the workflow,
not from the main branch root directory.
