# Asset register

| Asset | Source / tool | Purpose | License / notes |
|---|---|---|---|
| `assets/models/night_market_diorama.glb` | Original scene generated with Blender 5.3.0 using `assets/blender/create_night_market.py` | 3D paper-cut night-market scene rendered by Godot | Project-created asset. No third-party model source used. |
| `assets/blender/night_market.blend` | Blender 5.3.0 | Editable source scene | Project source file. |
| `assets/art/night_market_preview.png` | Rendered from the Blender scene | Art review and direction reference | Project-generated preview. |
| `assets/fonts/NotoSansTC-Regular.otf` | Noto CJK project | Traditional Chinese UI font | SIL Open Font License 1.1; license copy at `assets/fonts/OFL.txt`. |

Godot imports the GLB at build time. The Blender source directory contains `.gdignore` so the editor does not attempt to treat `.blend` as a Godot runtime resource.
