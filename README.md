# Open Service Portal Documentation Hub

Multi-repository documentation aggregator for the Open Service Portal project, built with [Docusaurus](https://docusaurus.io/).

## Overview

This repository automatically collects and publishes documentation from all Open Service Portal repositories to a unified documentation site at [docs.opencloud.dev](https://docs.opencloud.dev).

## Features

- **Automatic Documentation Collection**: GitHub Actions fetch docs from all repos daily
- **Multi-Docs Support**: Each repository gets its own documentation section
- **Unified Navigation**: Easy navigation between different project components
- **Version Control**: Each doc section links back to its source repository
- **Auto-deployment**: Pushes to main automatically deploy to docs.opencloud.dev

## Repository Structure

```
docusaurus/
├── docs/                    # Main documentation
├── external-docs/           # Auto-collected docs (gitignored)
│   ├── portal-workspace/    # Workspace documentation
│   ├── app-portal/          # Backstage app docs
│   ├── catalog/             # Catalog documentation
│   └── templates/           # All template docs
├── scripts/
│   └── collect-docs.sh      # Local doc collection script
├── .github/workflows/
│   └── deploy.yml           # Auto-deploy to GitHub Pages
└── docusaurus.config.ts     # Docusaurus configuration
```

## Local Development

### Prerequisites

- Node.js 20 or higher
- npm

### Setup

1. Clone this repository:
```bash
git clone https://github.com/open-service-portal/docusaurus.git
cd docusaurus
```

2. Install dependencies:
```bash
npm install
```

3. Collect documentation from other repos:
```bash
./scripts/collect-docs.sh
```

4. Start the development server:
```bash
npm start
```

The site will be available at [http://localhost:3000](http://localhost:3000).

### Building for Production

```bash
npm run build
```

This command generates static content in the `build` directory.

## Documentation Sources

The documentation hub aggregates content from:

### Core Repositories
- **portal-workspace**: Main workspace and architecture documentation
- **app-portal**: Backstage application documentation
- **catalog**: Template catalog documentation

### Template Repositories
- **Crossplane Templates**:
  - template-dns-record
  - (more to be added)

- **Backstage Service Templates**:
  - service-nodejs-template
  - service-mongodb-template
  - service-cluster-template
  - service-firewall-template
  - service-dnsrecord-template
  - service-mongodb-golden-path-template

## Automatic Deployment

The site automatically deploys to GitHub Pages when:
- Changes are pushed to the `main` branch
- Daily at 2 AM UTC (to fetch latest docs from all repos)
- Manually triggered via GitHub Actions

## Adding New Documentation Sources

To add documentation from a new repository:

1. Update `.github/workflows/deploy.yml` to clone and copy the new repo's docs
2. Update `scripts/collect-docs.sh` for local development
3. Add a new plugin section in `docusaurus.config.ts` if it needs its own route
4. Update navigation in `docusaurus.config.ts`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Custom Domain Setup

The site is configured to deploy to `docs.opencloud.dev`. DNS configuration:
- CNAME record: `docs.opencloud.dev` → `open-service-portal.github.io`

## License

This project is part of the Open Service Portal and follows the same licensing terms.
