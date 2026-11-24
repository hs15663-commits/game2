# Requirements traceability

| Requirement ID | Requirement | Planned implementation | Verification evidence | Status |
|---|---|---|---|---|
| FR-001 | Start/restart | Main menu state in `scripts/main.gd` | Godot headless scene startup succeeds; code-path review | implemented; full UI flow pending |
| FR-002 | Level 1 savings/planning choice | Level 1 scenario data in `scripts/main.gd` | content/code review | implemented |
| FR-003 | Level 2 investment risk/diversification choice | Level 2 scenario data in `scripts/main.gd` | content/code review | implemented |
| FR-004 | Feedback and retry | deterministic response handler | code-path review; browser retry pending | implemented; browser check pending |
| FR-005 | Correct answer grants 50 points and key once | progression state in `scripts/main.gd` | code-path review | implemented; runtime flow pending |
| FR-006 | Level 2 locked until Level 1 pass | sequential progression gate | code-path review | implemented; runtime flow pending |
| FR-007 | Current score, total and progress visible | HUD controls | scene/code review | implemented; viewport check pending |
| FR-008 | Final progress summary | results screen | scene/code review | implemented; runtime flow pending |
| FR-009 | Restart resets run | reset method | code-path review | implemented; runtime flow pending |
| FR-010 | Keyboard/touch actions and visible focus | Godot Buttons + focus styles | code review; browser input pending | implemented; browser check pending |
| NFR-001 | Godot 4.7.2 single-thread Web export | project settings and export preset | successful export; expected HTML/WASM/PCK generated | passed |
| NFR-002 | Responsive 16:9/mobile layout | anchors/containers | code review; viewport inspection pending | implemented; viewport check pending |
| NFR-003 | Readable Traditional Chinese | bundled font and light panels | resource/license review; visual check pending | implemented; visual check pending |
| NFR-004 | No unnecessary motion/audio | no decorative animation or audio | code review | passed by design |
| NFR-005 | Lightweight static build | low-poly GLB, no runtime APIs | export size: ~45.5 MB total; network/browser review pending | static; size review pending |
| NFR-006 | No learner data collection | in-memory only state | code/config review | passed by design |
