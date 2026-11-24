# Change log

## 2026-11-24 — Skill-driven rebuild kickoff

- Added a draft project brief, project state, domain/technical evidence notes, game-design tournament, and decision log.
- Recorded the existing HTML/CSS/JS site as an unselected prior prototype, not as a Godot implementation.
- Installed Godot 4.7.2 stable to `C:\Godot` after confirming it was absent and verifying its official release SHA-256.
- Confirmed existing Blender 5.3.0 installation in Program Files; no duplicate installation was created.
- Downloaded, hash-verified, and installed Godot 4.7.2 web export templates under the user Godot data directory.
- Recorded the user's selection of gameplay candidate B, Night Market Branching Story.
- Created three same-state, 16:9 visual direction mockups in `docs/visual-directions.html`.
- Recorded the user's selection of visual direction 02, Paper-cut Night Market.
- User approved the project brief and MVP scope; DT handoff is approved.
- Began SDLC design and vertical slice implementation.

## 2026-11-24 — Godot Web delivery candidate

- Built the two-level Godot game with per-level scoring, pass-to-earn KEY progression, retries, and a final progress recap.
- Created and integrated the original Blender night-market GLB; recorded its source and Noto Sans TC license.
- Moved the old standalone HTML prototype under `legacy-html/` and updated README, Pages, and Netlify settings to use the Godot `web-export/` output.
- Added a repeatable Godot Web export script and generated the static deployment bundle.
- Verified headless project startup and Web export without script/resource errors. Interactive browser and pupil/teacher playtests remain outstanding.
