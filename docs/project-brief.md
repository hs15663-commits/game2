# Project brief — 小小夢魔：夢境理財所

Status: approved  
Version: 0.1  
Interaction mode: teaching / guided  
Decision owner: 使用者

## Goal

把「小小夢魔」改製成原創 Godot 遊戲，讓小學生在兩個夢境關卡練習生活理財與投資入門，並能以瀏覽器遊玩、部署到 GitHub Pages 或 Netlify。

## Target users and context

- Primary: 小學生；先以 8–12 歲作為設計假設，年級尚待確認。
- Secondary: 帶領課程的教師或家長。
- Context: 短時段、單人、繁體中文、鍵盤與觸控裝置皆可操作。

## Evidence and pain points

- Confirmed user brief: 兩關、每關一個互動單元、通關取 KEY、每關計分、結尾展示進步成果、Godot 網頁部署。
- Domain evidence: CFPB 將兒童理財能力描述為執行功能、財務習慣與規範、金融知識與決策技能三個互相關聯的基礎；中童期會發展延遲滿足、規劃、存錢等技能。[CFPB youth capability framework](https://www.consumerfinance.gov/consumer-tools/educator-tools/youth-financial-education/learn/)
- Domain evidence: CFPB 指出 6–12 歲可練習為未來目標儲蓄，以及思考目前行動的後果。[CFPB executive function](https://www.consumerfinance.gov/consumer-tools/educator-tools/youth-financial-education/learn/executive-function/)
- No direct interviews, classroom observations, or playtest evidence have been collected. User needs beyond the brief remain hypotheses.

## Problem statement

小學生需要在可理解、可重試的情境中練習安排零用錢與辨認投資風險；目前尚未驗證哪一種遊戲循環最能兼顧理財概念理解、兒童參與及低認知負荷。

## Inputs, processing, and outputs

- Inputs: player choices and keyboard/touch actions; no personal or financial data.
- Processing: deterministic Godot game rules score each level and unlock a KEY only after its learning challenge is solved.
- Outputs: per-level score, KEY state, feedback explaining the consequence, and a final two-level progress summary.

## AI role and authority

AI may generate and score candidate concepts as labeled AI pre-scores and may implement the user-selected design. AI scores are not evidence of learning effectiveness. The user selects gameplay and visual direction at the documented gates. No runtime AI is planned.

## MVP and non-goals

MVP:

1. Original dark-dream exploration presentation inspired by the reference's atmosphere and scale, without copying protected characters, scenes, logos, or assets.
2. Exactly two learning levels; each has one primary interactive challenge and a pass condition for its KEY.
3. Per-level points, explanatory feedback, and an end-of-run learning progress summary.
4. Keyboard and touch access, responsive browser layout, reduced motion option, sound mute, and offline-safe local play.
5. Godot web export with deployable output for GitHub Pages or Netlify.
6. Original Blender-created 3D asset(s) if the approved art direction needs them and the asset toolchain is workable.

Selected gameplay direction (user-selected 2026-11-24): **B — Night Market Branching Story**. Level 1 branches on a small-money planning choice; Level 2 branches on an investment-risk choice. Branch consequences and pass conditions are part of the later approved design specification.

Selected visual direction (user-selected 2026-11-24): **02 — Paper-cut Night Market**. Use a warm, layered paper-diorama market against a restrained dream-night setting, with high-contrast readable choice panels. The style should feel mysterious and exploratory while remaining welcoming to children. All characters, environments, props, sound and interface are original.

Non-goals for MVP: real-money handling, trading advice, actual market forecasts, accounts, networked multiplayer, user tracking, or collection of identifiable learner data.

## Constraints and risks

- Primary school readers need short instructions, simple vocabulary, and visible cause-and-effect feedback.
- Investment instruction must describe risk without promising returns or equating investment with gambling.
- Random guessing can unlock one-shot multiple-choice tasks; design should require a meaningful action or reasoning step.
- Web output must avoid features requiring unavailable cross-origin headers; prefer single-thread Godot web export.
- Godot 4.7.2 stable is installed at `C:\Godot\Godot_v4.7.2-stable_win64.exe`; matching web export templates are installed under `%APPDATA%\Godot\export_templates\4.7.2.stable`.
- Blender 5.3.0 is installed at `C:\Program Files\Blender Foundation\Blender 5.3\blender.exe`; `C:\blender` is not an installed directory. Blender Toolkit addon/config has not been verified as available.

## Delivery context

Public static web release in the existing GitHub repository `hs15663-commits/game2`; target URL remains `https://hs15663-commits.github.io/game2/`. Netlify remains a compatible alternative. The current repository has a GitHub Pages workflow.

## Success measures

Design/build acceptance:

- Two and only two playable levels are reachable in sequence.
- A level KEY remains locked until that level's challenge passes.
- Scores update correctly for each level and appear in the final summary.
- Every incorrect and correct action has understandable feedback tied to a stated learning objective.
- The game exports as a Godot web build and can be served by a static host.
- UI works at mobile and desktop widths, supports keyboard/touch, and respects reduced motion.

Learning evidence (not yet measured):

- During a later playtest, learners can explain one reason to save before spending and one reason diversification can reduce single-investment risk.
- A pre/post or scenario-based measure is required before claiming learning improvement.

## Assumptions to test

- A two-level, 8–12 minute game suits primary-class use.
- Players understand “needs vs wants”, goal saving, risk, and diversification with a brief scenario and immediate explanation.
- A small Blender model adds value without slowing web loading or obscuring the challenge.

## Acceptance examples

- Given a learner has not passed Level 1, when they inspect its door, then the KEY is visibly locked and Level 2 is unavailable.
- Given a learner completes a challenge with a passing response, when they submit, then the level score updates and its KEY is granted.
- Given both challenges are complete, when the results screen opens, then it shows each level's score, total score, both learning concepts, and what the learner can try next.
- Given a learner uses only keyboard or touch, when they navigate all menus and challenges, then every action is available and focused/selected states are visible.

## Open questions

- Which of the three later visual directions should be implemented?
- Which grade band and class time should the lesson target?
- Whether to enable Blender Toolkit live control or use Blender's built-in background scripting for this asset pipeline.

## User approval

Approved by the user on 2026-11-24. The DT handoff is approved for the stated MVP. Grade band 8–12 remains a documented assumption and may be revised if the user supplies a target grade.
