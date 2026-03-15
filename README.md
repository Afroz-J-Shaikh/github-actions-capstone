# simple-node-js-react-npm-app

This repository is for the
[Build a Node.js and React app with npm](https://jenkins.io/doc/tutorials/build-a-node-js-and-react-app-with-npm/)
tutorial in the [Jenkins User Documentation](https://jenkins.io/doc/).

## Full-Stack Architecture

The repository contains a full-stack Node.js and React application:
- **Frontend**: A Vite-powered React application with a "Learn React" link.
- **Backend**: An Express.js server that runs the application and serves API endpoints.

### API Endpoints

- `/api/hello`: A beautifully styled HTML API endpoint with a modern glassmorphic UI, smooth CSS gradient background, and a pulsing status badge. It demonstrates serving dynamic HTML straight from the backend.
- `/*`: A catch-all route to serve the built React frontend (`index.html`) to support client-side Single Page Application (SPA) routing.

## Getting Started

1. **Install Dependencies**: `npm install`
2. **Start Dev Server**: `npm run dev` (starts Vite out-of-the-box frontend proxying)
3. **Start Production Server**: `npm start` (Runs the full Express `server.js` stack on port 3000)

## Badges

[![pr pipeline](https://github.com/Afroz-J-Shaikh/github-actions-capstone/actions/workflows/pr-pipeline.yml/badge.svg?branch=feature&event=pull_request)](https://github.com/Afroz-J-Shaikh/github-actions-capstone/actions/workflows/pr-pipeline.yml)

[![main pipeline](https://github.com/Afroz-J-Shaikh/github-actions-capstone/actions/workflows/main-pipeline.yml/badge.svg)](https://github.com/Afroz-J-Shaikh/github-actions-capstone/actions/workflows/main-pipeline.yml)

[![health checkout](https://github.com/Afroz-J-Shaikh/github-actions-capstone/actions/workflows/health-check.yml/badge.svg)](https://github.com/Afroz-J-Shaikh/github-actions-capstone/actions/workflows/health-check.yml)

## Pipeline Architecture Diagram

```mermaid
graph TD
    A[PR opened] --> B[Build & Test]
    B -->|Pass| C[PR Comment]
    B -->|Fail| D[PR Comment]
    
    E[Push to main] --> F[Build & Test]
    F -->|Pass| G[Docker Build & Push]
    F -->|Fail| H[PR Comment]
    
    G --> I[Deploy]
    I --> J[Health Check]
    J -->|Pass| K[Summary]
    J -->|Fail| L[Summary]
```