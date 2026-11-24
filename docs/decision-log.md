# Decision log

## 2026-11-24 — Rebuild scope and tooling

- Decision: continue toward a Godot web build rather than treat the existing static HTML prototype as final delivery.
- Source: explicit user request to apply DT-SDLC, game-design, Blender skills, use Godot, and publish as a web game.
- Godot: installed stable 4.7.2 from the official release to `C:\Godot\Godot_v4.7.2-stable_win64.exe`; official release digest verified before extraction.
- Blender: verified existing Blender 5.3.0 at `C:\Program Files\Blender Foundation\Blender 5.3\blender.exe`; not duplicated at `C:\blender`.
- Web export templates: still required before Godot export.

## 2026-11-24 — Godot Web export readiness

- Downloaded the official Godot 4.7.2 export template package and verified SHA-256 `f298490b8d44d934be425a5a65a51bf15f422428b229a06a6e11d9ffea248011`.
- Installed templates to `%APPDATA%\Godot\export_templates\4.7.2.stable` and verified `web_nothreads_release.zip` exists.

## 2026-11-24 — Temporary education profile for concept ranking

- Decision: use game-design's Balanced baseline because the user asked to proceed but did not select weights.
- Values: L/E/M/A = 0.40/0.20/0.15/0.25; pG=0.15; pC=0.10; no G/C hard gate.
- Evidence status: assumption for AI pre-scoring only. Revisit if the decision owner changes it before gameplay selection.

## 2026-11-24 — Gameplay direction selected

- Candidates A/B/C are presented in `docs/game-design-tournament.md`.
- User selected **B — 夜市分岔故事** on 2026-11-24. This is the selected gameplay direction; it does not approve the project brief or visual direction.
- Three matched visual direction mockups were created in `docs/visual-directions.html`.

## 2026-11-24 — Visual direction selected

- User selected **02 — 紙片夜市** on 2026-11-24.
- Rationale to preserve in implementation: layered warm paper scene, clear choice surfaces, dream-night atmosphere, child-appropriate contrast and mood.
- Next gate: approve or revise the brief's problem definition and MVP boundary before DT handoff and Godot vertical slice.

## 2026-11-24 — DT handoff and MVP approved

- User explicitly approved the draft brief and MVP on 2026-11-24.
- DT handoff is approved. The project proceeds to SDLC design/build under the authorized two-level static Godot web scope.
- The 8–12 age band remains an assumption because no grade was selected.
