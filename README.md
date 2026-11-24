# 小小夢魔：夢境理財所

給小學生的繁體中文 Godot 網頁遊戲。玩家在兩個夜市夢境中練習安排零用錢、了解投資風險與分散，答對即可取得該關 KEY。每關最多 50 分，結尾呈現本次遊戲紀錄與概念回顧。

## 線上遊玩

GitHub Pages 部署後可由 repository 的 **Settings → Pages** 顯示網址。GitHub Actions 從 `web-export/` 發佈；Netlify 的 publish directory 也設為 `web-export`。

## 本機執行

使用 Godot 4.7.2 開啟本資料夾中的 `project.godot`，執行主場景 `scenes/main.tscn`。

## 建置網頁版

需要 Godot 4.7.2 stable 與同版本 Web export templates。Windows PowerShell 執行：

```powershell
.\scripts\export_web.ps1
```

產物會放在 `web-export/`，可用下列命令本機預覽：

```powershell
python -m http.server 8000 --directory web-export
```

再瀏覽 `http://localhost:8000`。Godot Web 輸出需經 HTTP 伺服器提供，請勿直接以 `file://` 開啟。

## 專案資料

- `scripts/main.gd`、`scenes/main.tscn`：遊戲邏輯和場景。
- `assets/models/night_market_diorama.glb`：原創 Blender 夜市場景模型。
- `assets/blender/`：Blender 原始場景及可重建資產的腳本。
- `docs/`：核准 brief、遊戲設計、需求追溯、測試計畫與資產清冊。
- `legacy-html/`：最初靜態原型，僅供參考；正式部署使用 Godot 匯出內容。

## 字型授權

繁中字型 Noto Sans TC 隨附於 `assets/fonts/`，依 SIL Open Font License 1.1 授權，詳見 `assets/fonts/OFL.txt`。

## 發佈

GitHub Pages workflow 位於 `.github/workflows/pages.yml`。將 `web-export/` 設為 Netlify 發佈目錄即可部署；`netlify.toml` 已包含該設定。

實際部署狀態由 GitHub Actions / Netlify 的發佈結果確認。尚未取得小學生或教師的玩家測試資料，因此成果摘要不能視為學習成效證據。
