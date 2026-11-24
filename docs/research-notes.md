# Research notes

Research date: 2026-11-24 (Asia/Taipei)  
Evidence is used to inform design hypotheses; it does not establish that this game improves learning.

## Domain evidence

1. CFPB's youth financial capability model identifies executive function, financial habits and norms, and financial knowledge/decision skills as connected building blocks. Middle childhood (6–12) is a period in which financial habits and basic money management concepts take shape. [CFPB: Learn about the building blocks](https://www.consumerfinance.gov/consumer-tools/educator-tools/youth-financial-education/learn/)
2. CFPB's executive-function guidance connects delayed gratification and future consequences in ages 6–12 with saving for goals and thinking about results of present actions. [CFPB: Executive function](https://www.consumerfinance.gov/consumer-tools/educator-tools/youth-financial-education/learn/executive-function/)
3. CFPB recommends age-appropriate activities and assessment of progress toward milestones across K–12 financial education. [CFPB: Youth financial education](https://www.consumerfinance.gov/consumer-tools/educator-tools/youth-financial-education/)

## Reference game

The user-provided Steam page describes *Little Nightmares* as a dark, whimsical escape story in a huge mysterious environment. This supports only a high-level mood/scale reference. This project will use original characters, environments, names, UI and models. [Steam: Little Nightmares](https://store.steampowered.com/app/424840/Little_Nightmares/?l=tchinese)

## Technical evidence

- Godot 4.7.2 is listed as the current stable Windows release in the official archive; 4.8 is beta and is not selected for a reproducible production project. [Godot archive](https://godotengine.org/download/archive/4.7.2-stable/)
- Godot web exports run in browsers. Godot 4.3+ supports single-thread web export, which avoids the server-side cross-origin isolation requirements of multithreaded builds. [Godot 4.7: Exporting for the Web](https://docs.godotengine.org/en/4.7/tutorials/export/exporting_for_web.html)
- Godot export needs matching export templates; these are separate from the editor. [Godot 4.7: Exporting projects](https://docs.godotengine.org/en/4.7/tutorials/export/exporting_projects.html)
- The matching Godot 4.7.2 web export templates were installed from the official release after SHA-256 verification; `web_nothreads_release.zip` is present.
- Blender 5.3.0 is installed on this computer at `C:\Program Files\Blender Foundation\Blender 5.3\blender.exe`. [Blender downloads](https://www.blender.org/download/)

## Limitations

- No elementary teacher, learner, parent, financial educator, or accessibility expert has reviewed this project.
- No player evidence exists; all candidate scores in the tournament are AI pre-scores only, at low confidence.
- CFPB is a US public agency; local curriculum, currency conventions and terminology for Taiwan have not been independently validated.
