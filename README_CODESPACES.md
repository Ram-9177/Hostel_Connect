# Developing in GitHub Codespaces

This repo is ready for Codespaces with a devcontainer.

## What you get
- Node.js 20 environment
- Ports forwarded: 3000 (API), 5500 (Web)
- Preinstalled dependencies (root + `hostelconnect/api`)

## Start services
- In VS Code: Terminal > Run Task > "Start: API + Web"
- Or run individually:
  - API: `cd hostelconnect/api && npm run start:dev`
  - Web: `npm run dev`

API docs: http://localhost:3000/api
Web (Vite): http://localhost:5500

Notes:
- Mobile (Flutter) emulator isn’t supported in Codespaces, but you can edit code and run tests.
- For local mobile runs, use Android emulator and point base URL to `10.0.2.2:3000`.
