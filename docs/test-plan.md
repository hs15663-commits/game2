# Verification and playtest plan

## Software verification

1. Godot 4.7.2 headless startup (`--headless --path . --quit-after 3`) exits 0 with no script/resource errors. **Passed locally.**
2. Deterministic state flow: start → Level 1 wrong answer/retry → Level 1 correct/50 pts/KEY → Level 2 unlocked → Level 2 wrong/retry → Level 2 correct/50 pts/KEY → results (100 total) → restart (0 total).
3. Confirm no answer can earn more than 50 points per level; duplicate clicks do not duplicate score or keys.
4. Export single-thread Web and verify HTML/JS/WASM/PCK files in `web-export/`. **Passed locally; output generated.**
   Local HTTP verification was denied by loopback socket restrictions. The published URL currently returns GitHub Pages 404 because the repository has no Pages site enabled; workflow run #2 fails at `configure-pages` with `Get Pages site failed`.
5. Inspect responsive text, contrast, focus visibility, keyboard operation, touch target size, reduced-motion setting and console/network errors.
6. Review downloaded bundle size and confirm no learner data or third-party runtime request is sent.

## Player test (required before learning-effect claims)

- Participants: ideally 3–5 pupils in the assumed age band and one teacher, with guardian/school consent as required by the setting. Do not collect names or identifiable information.
- Tasks: play both levels without coaching; explain the choice and consequence; recover after one incorrect choice; state whether diversification guarantees a gain.
- Observe: first valid action, reading difficulty, random guessing, repeated choice changes, explanation comprehension, frustration, and ability to finish.
- Measures: task completion, choice rationale accuracy, misconception count, retry behavior, brief age-appropriate confidence/clarity questions.
- Decision rule: revise if two or more players cannot explain the target concept, misunderstand risk as guaranteed returns, or need repeated adult explanation; otherwise run a second small round before making stronger claims.
- Current status: not run; no pupil or teacher data is available in this environment.
