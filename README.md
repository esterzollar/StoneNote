# StoneNote (Electron)

![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux-blue)
![Status](https://img.shields.io/badge/status-alpha-orange)
![License](https://img.shields.io/badge/license-free%20to%20use-lightgrey)

StoneNote is a local-first notebook built for teachers, students, historians, and archivists. It combines long-form writing with smart features like timeline, map pins, and one-click presentation mode.

## Highlights
- Local-first SQLite library (fast, offline, private).
- Smart Timeline per book.
- MapWizard: drop pins and see them on the book map.
- Present mode: auto-slides from notes/books.
- Wiki links with ghost notes and backlinks.
- Custom themes (global CSS).
- Plugin system with permissions + sandboxed host.
- Seeded "StoneNote Guide" on first launch.

## Tech Stack
- Electron + Vite + React
- TipTap editor (Markdown support)
- SQLite (better-sqlite3)
- Leaflet maps + Recharts charts

## Project Structure
- `electron/` main process, IPC, plugin host, DB access
- `src/` renderer (React UI)
- `src/components/Editor.tsx` main editor + toolbar + Wiki/Map
- `src/components/BookContents.tsx` smart tabs (Timeline/Map/Slides)
- `src/components/Presenter.tsx` slide deck viewer
- `seed/guide/` starter docs
- `plugins/` example plugins (circle-draw)
- `themes/` sample themes

## Local Data
- Library DB: `~/StoneNoteLibrary/library.db`
- User data (themes/plugins): `$XDG_CONFIG_HOME/stonenote-electron` (or `~/.config/stonenote-electron`)

## Development
Install deps:
```bash
npm install --legacy-peer-deps
```

Run dev:
```bash
npm run electron:dev
```

## Build
Build renderer:
```bash
NODE_OPTIONS=--max-old-space-size=6144 npm run build
```

Package apps:
```bash
npm run electron:build
```

Linux targets (from `package.json`):
- `deb`
- `pacman`
- `AppImage`

Windows target:
- `nsis` (`.exe`)

Note: RPM packaging needs `rpmbuild` on the build machine if you add it.

## Build & Release (Quick Guide)
Linux (local):
```bash
npm install --legacy-peer-deps
NODE_OPTIONS=--max-old-space-size=6144 npm run build
npm run electron:build
```

Windows (recommended via CI):
- Use the GitHub Action in `.github/workflows/build-windows.yml`.
- Trigger by pushing a `v*` tag or running the workflow manually.
- Download the `.exe` from Actions artifacts.

If the build gets killed, increase Node memory or add swap:
```bash
NODE_OPTIONS=--max-old-space-size=6144 npm run build
```

## One-Click Install (Windows)
Paste this into PowerShell (downloads the latest release installer):
```powershell
iwr -useb https://raw.githubusercontent.com/esterzollar/StoneNote/main/install.ps1 | iex
```

## Release Upload (No Git)
Use `upload.sh` with a GitHub token set in your environment:
```bash
export GITHUB_TOKEN="YOUR_TOKEN_HERE"
./upload.sh
```

## Targets
- Teachers building lesson notes into slides.
- Students organizing research into timelines and maps.
- Historians and archivists mapping sources and events.

## Roadmap
- Smart Slides v2 (better slide parsing + layout themes).
- Smart Map v2 (named places + pin grouping).
- Mobile companion (read-only or quick capture).
- Collaboration exports (PDF/Slides/Share).
- Plugin marketplace and curated themes.

## Plugin Development
See `API.md` for the plugin API and permission model. Plugins are zipped and installed via Settings → Plugins.

## Custom Themes
See `CSS_api.md` for the global theme hooks.

## Security Notes
- Plugins run in a sandboxed window and must declare permissions.
- Network access is blocked by default.

## License
Free to use. Closed-source (no public source code distribution).
