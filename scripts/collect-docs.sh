#!/bin/bash

# Script to collect documentation from all Open Service Portal repositories
# This is used locally and in CI/CD

echo "🔄 Collecting documentation from Open Service Portal repositories..."

# Fetch organization profile README
echo "📚 Fetching organization profile README..."
curl -s https://raw.githubusercontent.com/open-service-portal/.github/main/profile/README.md > docs/intro.md

# Add frontmatter for Docusaurus
echo "---" > temp_intro.md
echo "sidebar_position: 1" >> temp_intro.md
echo "title: Welcome to Open Service Portal" >> temp_intro.md
echo "---" >> temp_intro.md
echo "" >> temp_intro.md
cat docs/intro.md >> temp_intro.md
mv temp_intro.md docs/intro.md

# Create directories
mkdir -p external-docs/portal-workspace
mkdir -p external-docs/app-portal
mkdir -p external-docs/catalog
mkdir -p external-docs/templates

# Portal Workspace
echo "📚 Fetching portal-workspace docs..."
if [ -d "../portal-workspace" ]; then
  echo "  Using local portal-workspace"
  [ -d "../portal-workspace/docs" ] && cp -r ../portal-workspace/docs/* external-docs/portal-workspace/ 2>/dev/null || true
  [ -f "../portal-workspace/README.md" ] && cp ../portal-workspace/README.md external-docs/portal-workspace/index.md
else
  echo "  Cloning portal-workspace from GitHub"
  git clone https://github.com/open-service-portal/portal-workspace.git temp-portal-workspace
  [ -d "temp-portal-workspace/docs" ] && cp -r temp-portal-workspace/docs/* external-docs/portal-workspace/ 2>/dev/null || true
  [ -f "temp-portal-workspace/README.md" ] && cp temp-portal-workspace/README.md external-docs/portal-workspace/index.md
  rm -rf temp-portal-workspace
fi

# App Portal
echo "📚 Fetching app-portal docs..."
if [ -d "../app-portal" ]; then
  echo "  Using local app-portal"
  [ -d "../app-portal/docs" ] && cp -r ../app-portal/docs/* external-docs/app-portal/ 2>/dev/null || true
  [ -f "../app-portal/README.md" ] && cp ../app-portal/README.md external-docs/app-portal/index.md
  [ -f "../app-portal/CLAUDE.md" ] && cp ../app-portal/CLAUDE.md external-docs/app-portal/claude.md
else
  echo "  Cloning app-portal from GitHub"
  git clone https://github.com/open-service-portal/app-portal.git temp-app-portal
  [ -d "temp-app-portal/docs" ] && cp -r temp-app-portal/docs/* external-docs/app-portal/ 2>/dev/null || true
  [ -f "temp-app-portal/README.md" ] && cp temp-app-portal/README.md external-docs/app-portal/index.md
  [ -f "temp-app-portal/CLAUDE.md" ] && cp temp-app-portal/CLAUDE.md external-docs/app-portal/claude.md
  rm -rf temp-app-portal
fi

# Catalog
echo "📚 Fetching catalog docs..."
if [ -d "../catalog" ]; then
  echo "  Using local catalog"
  [ -d "../catalog/docs" ] && cp -r ../catalog/docs/* external-docs/catalog/ 2>/dev/null || true
  [ -f "../catalog/README.md" ] && cp ../catalog/README.md external-docs/catalog/index.md
else
  echo "  Cloning catalog from GitHub"
  git clone https://github.com/open-service-portal/catalog.git temp-catalog
  [ -d "temp-catalog/docs" ] && cp -r temp-catalog/docs/* external-docs/catalog/ 2>/dev/null || true
  [ -f "temp-catalog/README.md" ] && cp temp-catalog/README.md external-docs/catalog/index.md
  rm -rf temp-catalog
fi

# Templates
echo "📚 Collecting template documentation..."
echo "# Templates Documentation" > external-docs/templates/index.md
echo "" >> external-docs/templates/index.md
echo "## Crossplane Templates" >> external-docs/templates/index.md
echo "" >> external-docs/templates/index.md

# Crossplane templates
for repo in template-dns-record; do
  echo "  Processing $repo..."
  if [ -d "../$repo" ]; then
    echo "### $repo" >> external-docs/templates/index.md
    if [ -f "../$repo/README.md" ]; then
      echo "" >> external-docs/templates/index.md
      tail -n +2 ../$repo/README.md >> external-docs/templates/index.md
      echo "" >> external-docs/templates/index.md
      echo "---" >> external-docs/templates/index.md
      echo "" >> external-docs/templates/index.md
    fi
  fi
done

echo "" >> external-docs/templates/index.md
echo "## Backstage Service Templates" >> external-docs/templates/index.md
echo "" >> external-docs/templates/index.md

# Backstage service templates
for repo in service-nodejs-template service-mongodb-template service-cluster-template service-firewall-template service-dnsrecord-template service-mongodb-golden-path-template; do
  echo "  Processing $repo..."
  if [ -d "../$repo" ]; then
    echo "### $repo" >> external-docs/templates/index.md
    if [ -f "../$repo/README.md" ]; then
      echo "" >> external-docs/templates/index.md
      tail -n +2 ../$repo/README.md >> external-docs/templates/index.md
      echo "" >> external-docs/templates/index.md
      echo "---" >> external-docs/templates/index.md
      echo "" >> external-docs/templates/index.md
    fi
  fi
done

echo "✅ Documentation collection complete!"