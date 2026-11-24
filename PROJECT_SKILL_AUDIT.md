# 專案 Skill 套用與交付檢查

檢查日期：2026-11-24。以下依照專案中可查證的文件與產物記錄執行情形，不把 AI 方案評分或程式碼檢查描述成玩家證據。

| Skill | 狀態 | 證據 / 未完成項目 |
|---|---|---|
| `dt-sdlc` | 已完成設計交接並進入驗證/發佈候選 | 已核准 brief、需求規格、decision/change log、traceability、test plan、專案狀態、部署設定。Godot 建置可重跑；瀏覽器與課堂驗收仍待執行。 |
| `game-design` | 已完成概念與視覺選擇，遊戲已實作 | `docs/game-design-tournament.md` 紀錄 8 個概念比較與預評分，使用者選 B「夜市分岔故事」；`docs/visual-directions.html` 紀錄使用者選紙片夜市 02。兩關均有答錯回饋/重試、答對取得 KEY 與 50 分；尚無小學生/教師測試。 |
| Blender | 已用 Blender 原生腳本製作原創模型 | Blender 5.3.0 安裝於 `C:\Program Files\Blender Foundation\Blender 5.3\blender.exe`。`assets/blender/create_night_market.py` 產製 `.blend`、GLB 與預覽圖；Toolkit addon 未檢出，採背景 Python 腳本流程。 |

## SDLC 驗證狀態

- Godot 4.7.2 stable 位於 `C:\Godot\Godot_v4.7.2-stable_win64.exe`；Web export templates 同版本。
- `scripts/export_web.ps1` 成功輸出 `web-export/` 所需 HTML、JS、WASM 與 PCK；Godot headless 專案啟動退出碼為 0，沒有 script/resource error。
- GitHub Pages workflow 使用 `web-export/`；Netlify publish directory 設為 `web-export`。
- 已檢查 GitHub Actions：run #2 於 `configure-pages` 失敗，GitHub 回覆此 repository 尚未啟用/設定 Pages。預期 Pages URL 回傳 GitHub Pages 404；需要 repo 管理者在 **Settings → Pages → Build and deployment → Source** 選擇 **GitHub Actions**，然後重新執行 workflow。
- 尚未檢查部署後的桌機/手機互動及完整遊戲流程。
- 目前遊戲總包約 45.5 MB（WASM 約 39.5 MB）；需在真實瀏覽器觀察載入時間。
- 沒有學生/老師試玩證據，不宣稱已證實學習成效。

## 重要假設

- 學習者年齡暫按 8–12 歲；尚未取得年級與閱讀程度確認。
- 未收到教育獎勵權重，先採 `game-design` skill 的 Balanced baseline：L/E/M/A = 0.40/0.20/0.15/0.25，pG = 0.15、pC = 0.10。
- 本機 HTTP/browser 驗證受執行環境限制：loopback socket 被拒。線上頁面目前無法載入，原因是 GitHub Pages 未啟用，不是遊戲匯出錯誤。
