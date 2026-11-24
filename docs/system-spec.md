# System specification — Dream Ledger / 夜市分岔故事

Status: approved baseline  
Requirements version: 0.2  
Related approved brief: `docs/project-brief.md`

## Purpose, users, scope, and non-goals

Build a short, child-friendly Godot browser game in which an original dream-market story teaches saving/planning and introductory investment risk. Intended learner is an elementary pupil; ages 8–12 are a working assumption. MVP is two levels, one primary interactive story decision per level, pass-to-unlock KEY, per-level score and a final learning-progress recap.

Non-goals: real-money transactions, personalized investment advice, market forecasts, user accounts, networking, multiplayer, learner tracking, or identifiable data collection.

## Functional requirements

| ID | Requirement |
|---|---|
| FR-001 | Start screen explains the story and provides a clear start/restart action. |
| FR-002 | Level 1 teaches need/goal planning before a nonessential purchase using one branching choice. |
| FR-003 | Level 2 teaches concentration risk/diversification and uncertainty using one branching choice. |
| FR-004 | Wrong choices show a short, age-appropriate explanation and the story consequence; the learner may retry without losing earned points. |
| FR-005 | A correct response grants that level's KEY and 50 points exactly once. |
| FR-006 | Level 2 remains locked until Level 1 is passed; a KEY cannot be earned by navigation or skipping the challenge. |
| FR-007 | The UI displays the current level score, total score, KEY state and level progress. |
| FR-008 | After both levels, the result screen displays each level score, total score, both learned concepts and one next-step reflection. |
| FR-009 | Restart clears current-run state and starts at Level 1. |
| FR-010 | All primary actions work with keyboard and touch; focus/selection is visible. |

## Non-functional requirements

- NFR-001: Godot 4.7.2, GDScript, single-thread Web export, static-host compatible.
- NFR-002: Game UI targets a 16:9 desktop view and reflows legibly at mobile widths; base canvas 1280×720.
- NFR-003: Chinese instructions are short, high-contrast, and use a bundled open-license CJK font if licensing/source allows; no external runtime API required.
- NFR-004: No decorative motion or audio is used in this MVP, so there is no motion or sound setting to expose.
- NFR-005: Keep the Web build lightweight; avoid large textures, runtime downloads, server dependencies, and cross-origin isolation requirements.
- NFR-006: Do not collect, store, or transmit learner data. Scores remain in memory for the current run.
- NFR-007: Educational claims are framed as learning goals, not proven outcomes until player evidence exists.

## Data and interface contracts

Each level content record contains `id`, `title`, `story`, `prompt`, `choices[]`, `correct_choice_id`, `pass_feedback`, `retry_feedback`, `learning_objective`, and `score_value` (50). The game controller owns progression, scores and keys; UI views only emit selected choice IDs and render state.

Runtime state:

```text
current_level: 1 | 2 | results
level_scores: [0|50, 0|50]
keys: [locked|earned, locked|earned]
selected_choice: choice ID or empty
```

No save file or network interface is required for MVP.

## Deliverable, platform, and visual direction

- Godot project at repository root, `project.godot` as entry point.
- Exported HTML5/WebAssembly files in `web-export/`.
- Public deployment through the existing GitHub Pages action; Netlify can use `web-export/` as the publish directory.
- User-selected gameplay: **B — Night Market Branching Story**.
- User-selected visual: **02 — Paper-cut Night Market**: warm paper-cut market, dark restrained dream sky, clear story/choice hierarchy, original art.
- Blender-generated original low-poly/paper-diorama GLB integrated into Godot; keep editable `.blend` and source generation script in project.

## Architecture and decisions

- `scenes/main.tscn` owns the Node3D backdrop and the `scripts/main.gd` controller builds the UI and owns screen navigation, scores, and keys.
- Challenge text is held in data-driven GDScript dictionaries; branching is deterministic, with no random rewards.
- The Blender GLB acts as a visual backdrop/prop layer; interactive story choices are native Godot Controls to preserve accessibility and reliable Web input.
- `gl_compatibility` renderer and single-thread export are preferred for broad browser support.
- Decision history and visual/art asset record are maintained in `docs/decision-log.md` and `docs/asset-register.md`.

## Configuration, security, privacy, and licensing

- Static public game; no authentication, server, analytics, or external API.
- No secrets, personal data or player-generated text.
- Original Blender assets; record creator/tool, source, license and export details. Any bundled font/audio must have a recorded redistribution license.
- Current risk: dark scenes can harm contrast; maintain readable light panels and verify at mobile size.

## Error handling and recovery

- Incorrect choice: explain consequence and allow retry; do not deduct score.
- Browser reload: MVP starts a fresh run; no persistent progress promise.
- Missing model/font: preserve a solid-color fallback scene and system-font fallback.
- Unsupported WebGL: show a clear browser compatibility message rather than a blank canvas where feasible.

## Test strategy and acceptance criteria

- Parse/import project in headless Godot, then run deterministic progression checks.
- Export Web with Godot 4.7.2 and verify required files are generated in `web-export/`.
- Browser-check start, wrong-answer retry, correct unlock, score, level 2 gating, final results, restart, responsive layout, keyboard/touch, and console/network errors.
- Acceptance is linked by requirement ID in `docs/traceability.md`; human classroom playtest is separate and remains outstanding.

## Deployment, migration, rollback, and operation

- GitHub Pages workflow deploys only `web-export/` after the build produces a valid `index.html`.
- Netlify publish directory: `web-export`, build command may be empty when pre-exported files are present.
- Roll back by reverting the release commit and redeploying the previous Pages artifact.
- Existing static HTML prototype remains under `legacy-html/` for reference; it is not the production deployment.
- No migration, backups or incident response are needed for the no-data static MVP.

## Risks, assumptions, and open questions

- Age band 8–12 and classroom session length are assumptions.
- The story's wrong-answer branching and retries may not sufficiently discourage guessing; test before making learning claims.
- Investment concepts must avoid implying that diversification guarantees profit.
- Blender Toolkit addon/server was not detected; use Blender's native background scripting for deterministic model generation unless the supported addon is made available.
- No teacher or pupil has yet reviewed the content.
