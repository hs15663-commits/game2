# Gameplay tournament — draft decision gate

Status: awaiting human selection  
Mode: teaching  
Evidence label for all concept scores: **AI pre-score**  
Confidence: low (single model, no independent expert panel or player data)  
Decision owner: user

## Locked constraints

- Audience: elementary students; ages 8–12 are an unconfirmed working assumption.
- Exactly two levels, each with one primary interactive unit.
- Each level's KEY is granted only when its challenge passes.
- Per-level score and a final progress display are required.
- Godot web export; static hosting on GitHub Pages or Netlify.
- Concepts must teach day-to-day money decisions and investment basics, avoid real-money transactions/financial advice, and suit short classroom play.

## Educational reward-function profile

No explicit factor weights were provided. Per the game-design skill's fallback rule, use its **Balanced baseline** as an assumption, open to revision before scoring:

| Positive component | Weight |
|---|---:|
| L — Learning | 0.40 |
| E — Engagement | 0.20 |
| M — Motivation/self-efficacy | 0.15 |
| A — Appropriate challenge | 0.25 |
| G — Guessing/exploitation penalty | 0.15 |
| C — Cognitive overload penalty | 0.10 |

No G or C hard gate added. Observable player evidence for L/E/M/A/G/C will be specified before playtesting; component values below are AI hypotheses, not measured outcomes.

Formula: `R_edu = clamp(.40L + .20E + .15M + .25A - .15G - .10C, 0, 100)`.

## Candidate population (neutral IDs)

All candidates are two-level, single-player concepts. Cosmetic reskins are not counted as separate candidates.

| ID | Core loop and player fantasy | Trade-off / escalation | Pass, failure and recovery | 30–60 second test slice |
|---|---|---|---|---|
| A | **夢境雙帳本**：分配夢幣建立生活預算，再將星塵分散到不同星球。 | 立即想要、生活需要、未來目標互相競爭；投資配置要在波動與集中風險間取捨。 | 每關完成配置並能指出一項理由取得 KEY；超支或集中時讀取結果後可調整一次。 | 可操作預算分配盤和投資分散盤各一個。 |
| B | **夜市分岔故事**：在連續小事件中選擇買、存、等待，追蹤願望進度。 | 當下快樂與延後目標的故事後果；第二關用不同結果比較投資風險。 | 選擇與理由符合關卡準則才能開門；錯誤選項可重選並看到因果。 | 一個夜市決策節點加一個星海分支。 |
| C | **星海投資組合**：把星塵放進數個風險不同的星座，觀察一組固定情境下的結果範圍。 | 高波動選項可能升跌較大；分散降低單一星座對總結果的影響。 | 分配不集中且能解讀風險圖示後過關；重新配置不扣分。 | 同一個確定性情境下比較集中與分散配置。 |
| D | **夢境需求市集**：在有限零用錢內先買需要，再安排一項想要或儲蓄目標。 | 有限預算、不同願望和延遲滿足。 | 不超預算且完成指定儲蓄目標取得 KEY；可返回替換項目。 | 拖放/點選商品卡並看即時餘額。 |
| E | **修復夜行飛船**：分配燃料、零件和儲蓄備用，讓飛船抵達下一關。 | 立即修理與保留備用金衝突；投資關使用安全備援航線。 | 飛船抵達且備用資源達標通關；失敗顯示缺口並可微調。 | 一個短回合資源配置桌面遊戲。 |
| F | **理財線索偵探**：查看投資邀約的線索，分辨風險與「保證翻倍」等不可信承諾。 | 快速高報酬承諾與可查證資訊間取捨。 | 找到關鍵風險線索並選擇求證/避開不實承諾才得 KEY；可重看線索。 | 一則短邀約加線索卡。 |
| G | **三選一知識闖關**：每關回答一題選擇題，答對即拿 KEY。 | 主要是答題速度，缺少資源規劃與後果互動。 | 答對通關；錯誤重試。 | 現有 HTML 原型最接近此方案。 |
| H | **投資輪盤**：轉動輪盤決定投資結果並累積星星。 | 以隨機大獎作為推進核心。 | 看似可快速通關，但結果主要由機率支配。 | 一個隨機輪盤。 |

## Hard gates and eliminations

- **H eliminated — domain-validity hard gate.** Its random jackpot loop teaches investment outcomes as gambling luck and cannot cleanly assess understanding of risk/diversification. A high average score cannot rescue this failure.
- All other concepts meet the stated two-level, classroom-appropriate, static-web, and no-real-money gates at concept level. This is an AI pre-screen, not expert validation.

## Blind review passes

Independent lenses were run as separate rubric passes because no independent reviewer/agent was available. Scores were not adjusted between lenses.

- Game designer: A gives the strongest agency and consequence loop; B has strong narrative pull but can become a sequence of authored branches; C has clear strategy but requires legible risk visualization.
- First-time pupil: D and A are easiest to understand through visible tokens; F risks reading-heavy instructions; G is immediately discoverable but invites guessing.
- Financial-education reviewer: A aligns with planning/saving; C gives the clearest investment-risk practice; F addresses scam claims but is not a substitute for basic investing concepts. Claims are grounded at framework level in CFPB resources, not locally validated curriculum.
- Research reviewer: deterministic A/C outcomes are easier to score and reproduce; B introduces language/story interpretation; G has strong guessing confound; no candidate has learning-validity evidence yet.
- Production director: A and D are feasible in Godot and scale to two levels; C needs a simple, non-stochastic outcome visualization; F needs careful content review and localization.

## G/R/D scorecards

Scores are AI pre-scores, 0–100, using independent dimensions. `R` means Research Validity. Thresholds are G >= 75, R >= 85, D >= 75. Default R_edu >= 75 is a prototype-promise threshold, not an outcome claim.

| ID | G | R | D | Hard gates / threshold |
|---|---:|---:|---:|---|
| A | 86 | 90 | 88 | Pass |
| B | 88 | 80 | 84 | Fails R threshold |
| C | 82 | 92 | 77 | Pass |
| D | 82 | 83 | 88 | Fails R threshold |
| E | 85 | 76 | 81 | Fails R threshold |
| F | 80 | 93 | 72 | Fails D threshold |
| G | 67 | 69 | 98 | Fails G and R thresholds |
| H | — | — | — | Eliminated at domain-validity hard gate |

Pareto front among gate-passing candidates: **A and C**. Neither dominates the other. Candidate A is the recommendation because its minimum dimension is 86 (versus 77 for C), and its mean G/R/D is 88.0 (versus 83.7), with lower prototype cost. These tie-breakers are disclosed. Candidate B fails the R threshold and must not be rescued by its higher G score.

## Educational reward diagnostic for the finalists

All values are AI pre-scores (hypotheses), not player evidence.

| ID | L | E | M | A | G | C | Calculation | R_edu | Flag |
|---|---:|---:|---:|---:|---:|---:|---|---:|---|
| A | 86 | 80 | 78 | 80 | 18 | 24 | 34.4 + 16 + 11.7 + 20 - 2.7 - 2.4 | 77.0 | Promising-to-prototype range, subject to human choice and testing |
| B | 80 | 91 | 86 | 78 | 28 | 28 | 32 + 18.2 + 12.9 + 19.5 - 4.2 - 2.8 | 75.6 | Engagement strong; guessing still needs testing |
| C | 89 | 80 | 76 | 76 | 15 | 32 | 35.6 + 16 + 11.4 + 19 - 2.25 - 3.2 | 76.55 | Cognitive load is a risk; use plain-language risk bands |

`R_edu` is kept separate from G/R/D and does not replace formal learning measures. No runtime LLM scoring is planned.

## Shortlist, evidence, risks and next falsifiable tests

### A — 夢境雙帳本 (recommended)

- Fantasy/core loop: guide a tiny dream traveler; allocate coins for needs/wants/goals, then distribute star dust across risk choices.
- Advantage: links an everyday saving habit to a clear diversification choice with visible consequences.
- Largest risk: the two units may pack in too many abstractions for younger pupils.
- Pattern reference: resource allocation plus consequence feedback; no protected mechanics/assets copied.
- Complexity: medium; token placement, deterministic scoring, two challenge scenes.
- Test: in a paper/graybox slice, can a learner explain why they saved some coins and spread star dust, without relying on a memorized “always split evenly” rule?

### B — 夜市分岔故事

- Fantasy/core loop: make choices in a dream-market story and observe how the wish/goal changes.
- Advantage: high narrative and character motivation potential.
- Largest risk: reading comprehension and branching text may dominate financial reasoning.
- Pattern reference: branching narrative choices; original story and choices required.
- Complexity: medium-high due to authored branches and outcome tracking.
- Test: can learners explain the consequence in their own words rather than selecting by tone or guessing?

### C — 星海投資組合

- Fantasy/core loop: configure a small star portfolio and compare fixed scenario outcomes.
- Advantage: directly practices diversification and compares concentration risk.
- Largest risk: charts, risk bands, and investment vocabulary may overload younger pupils or imply that diversification removes all risk.
- Pattern reference: portfolio/resource puzzle; no real ticker, return forecast, or market data.
- Complexity: medium; deterministic scenario set and an accessible outcome display.
- Test: after a single interaction, can a learner state that diversification can reduce concentration risk but cannot guarantee profit?

## Human decision gate — resolved

On 2026-11-24, the user selected **B — 夜市分岔故事**. This selection authorizes the visual-direction tournament, not implementation or the DT handoff.

The selected gameplay direction uses the same two learning objectives across branching scenarios:

- Level 1: plan for an immediate need and a savings goal before deciding whether to defer a nonessential purchase.
- Level 2: compare simple investment-risk scenarios; explain that diversification can reduce dependence on one asset but cannot guarantee a gain.

Next gate: choose one visual direction from `docs/visual-directions.html` before Godot/Blender production.

1. Select A (recommended): 夢境雙帳本.
2. Select B: 夜市分岔故事.
3. Select C: 星海投資組合.
4. Revise: give a change to the shortlist, profile, or hard gates.
5. Pause.
0. Other (enter text).
