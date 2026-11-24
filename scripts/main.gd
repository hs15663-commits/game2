extends Node3D

const LEVELS: Array[Dictionary] = [
	{
		"id": "saving",
		"title": "月燈夜市",
		"chapter": "第一夜　零用錢的分岔路",
		"story": "小六有 100 枚夢幣。今晚要留 30 元吃晚餐，也想存 40 元參加月燈節。攤位上有一包 40 元的月亮糖。",
		"prompt": "你會怎麼安排這 100 枚夢幣？",
		"objective": "練習先安排需要與儲蓄目標，再考慮想要的東西。",
		"choices": [
			"先留 30 元吃晚餐、存 40 元；糖果等下次。",
			"先買 40 元糖果、留 30 元晚餐，再把 30 元存起來。",
			"借 10 元買糖，晚一點再想怎麼還。"
		],
		"correct": 0,
		"wrong_feedback": [
			"",
			"你有留晚餐錢，但存款目標還差 10 元。先安排好需要和目標，剩下的才是可以考慮花用的錢。",
			"借來的錢之後也要還，會讓能存下的錢變少。先看看手上的 100 枚夢幣。"
		],
		"success": "晚餐有著落，月燈目標也存到了。小六把月亮糖記在下次的願望清單上，今晚的燈一盞盞亮了。",
		"lesson": "先安排需要與目標，再決定想要的花費。"
	},
	{
		"id": "investing",
		"title": "星海投資航道",
		"chapter": "第二夜　星塵的選擇",
		"story": "三枚星塵可以加入不同星球的小隊。有的小隊變化比較小，有的可能忽上忽下。星塵投入後可能增加，也可能減少。",
		"prompt": "哪個選擇能減少只依賴一顆星的風險？",
		"objective": "認識分散投資能降低集中風險，但不能保證獲利。",
		"choices": [
			"把三枚星塵全放在最亮的一顆星。",
			"先了解不同小隊，再分散放到不只一個選項。",
			"相信陌生人的保證，把星塵交給他翻倍。"
		],
		"correct": 1,
		"wrong_feedback": [
			"全部放在一個地方，結果就更依賴那個選擇。分散可以降低集中風險，但不會讓風險消失。",
			"",
			"投資沒有人能保證翻倍。先了解規則，也要小心聽起來太好的承諾。"
		],
		"success": "小六先看懂星球的規則，再把星塵分散配置。星海仍有起伏，但不再只靠一顆星。",
		"lesson": "分散可降低集中風險，投資仍可能有損失。"
	}
]

const COLOR_INK := Color("#342c29")
const COLOR_MUTED := Color("#766b62")
const COLOR_PAPER := Color("#fff4dc")
const COLOR_PAPER_DARK := Color("#ead3aa")
const COLOR_GREEN := Color("#4f7462")
const COLOR_GREEN_HOVER := Color("#668a75")
const COLOR_RED := Color("#a75445")

var current_level: int = 0
var level_scores: Array[int] = [0, 0]
var keys: Array[bool] = [false, false]
var screen: String = "intro"
var last_feedback: String = ""
var last_choice_was_correct: bool = false

var ui_layer: CanvasLayer
var root_ui: Control
var header_chapter: Label
var header_score: Label
var header_keys: Label
var body: Control
var ui_theme: Theme


func _ready() -> void:
	ui_theme = Theme.new()
	ui_theme.default_font = load("res://assets/fonts/NotoSansTC-Regular.otf") as Font
	ui_theme.default_font_size = 16
	ui_layer = CanvasLayer.new()
	ui_layer.layer = 5
	add_child(ui_layer)
	root_ui = Control.new()
	root_ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root_ui.theme = ui_theme
	ui_layer.add_child(root_ui)
	_build_header()
	body = Control.new()
	body.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	body.offset_left = 32
	body.offset_top = 88
	body.offset_right = -32
	body.offset_bottom = -28
	root_ui.add_child(body)
	get_viewport().size_changed.connect(_render)
	_render()


func _build_header() -> void:
	var header := PanelContainer.new()
	header.set_anchors_and_offsets_preset(Control.PRESET_TOP_WIDE)
	header.offset_bottom = 68
	header.add_theme_stylebox_override("panel", _style_box(Color("#263c42"), Color("#d5b46c"), 0, 0))
	root_ui.add_child(header)
	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 26)
	margin.add_theme_constant_override("margin_right", 26)
	header.add_child(margin)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 18)
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	margin.add_child(row)
	var brand := _label("✦　小小夢魔", 19, Color("#fff1d1"))
	brand.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(brand)
	header_chapter = _label("今晚的夢境", 13, Color("#e8d8b4"))
	header_chapter.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	header_chapter.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(header_chapter)
	header_score = _label("本關 0 分　·　總分 0 分", 13, Color("#fff1d1"))
	header_score.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	row.add_child(header_score)
	header_keys = _label("KEY　0 / 2", 13, Color("#e8d8b4"))
	header_keys.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	row.add_child(header_keys)


func _render() -> void:
	if not is_instance_valid(body):
		return
	for child in body.get_children():
		body.remove_child(child)
		child.queue_free()
	_update_header()
	if screen == "intro":
		_render_intro()
	elif screen == "challenge":
		_render_challenge()
	else:
		_render_results()


func _update_header() -> void:
	var total: int = level_scores[0] + level_scores[1]
	var earned: int = int(keys[0]) + int(keys[1])
	if screen == "intro":
		header_chapter.text = "今晚的夢境"
		header_score.text = "準備出發"
	elif screen == "results":
		header_chapter.text = "旅程回顧"
		header_score.text = "總分 %d 分" % total
	else:
		header_chapter.text = "夢境 %02d / 02" % (current_level + 1)
		header_score.text = "本關 %d 分　·　總分 %d 分" % [level_scores[current_level], total]
	header_keys.text = "KEY　%d / 2" % earned


func _render_intro() -> void:
	var content := _content_container()
	var columns := _columns(content)
	var story := _story_column(columns)
	story.add_child(_eyebrow("給小小理財家的夜市冒險"))
	story.add_child(_spacer(6))
	story.add_child(_label("今晚，跟著\n月燈走。", 37, COLOR_INK))
	story.add_child(_spacer(8))
	story.add_child(_body_label("兩段夜市故事，練習安排零用錢，也看看投資為什麼有風險。答錯可以再試，答對就拿到這一關的 KEY。", 17))
	story.add_child(_spacer(16))
	story.add_child(_tag_row(["兩個夢境關卡", "答對取得 KEY", "不使用真實金錢"]))
	var card := _card(columns[1])
	var inner := _card_content(card)
	inner.add_child(_eyebrow("今晚的旅程"))
	inner.add_child(_spacer(5))
	inner.add_child(_label("01　月燈夜市", 22, COLOR_INK))
	inner.add_child(_body_label("安排晚餐、儲蓄目標和想買的糖果。", 14))
	inner.add_child(_spacer(12))
	inner.add_child(_label("02　星海投資航道", 22, COLOR_INK))
	inner.add_child(_body_label("比較集中和分散的星塵選擇，記得分散不代表保證獲利。", 14))
	inner.add_child(_spacer(20))
	var start_button := _button("開始夜市故事　↗", true)
	start_button.pressed.connect(_start_game)
	inner.add_child(start_button)
	var note := _label("每一關都可以慢慢讀、再做選擇。", 11, COLOR_MUTED)
	note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	inner.add_child(note)


func _render_challenge() -> void:
	var level: Dictionary = LEVELS[current_level]
	var content := _content_container()
	var columns := _columns(content)
	var story := _story_column(columns)
	story.add_child(_eyebrow(level["chapter"]))
	story.add_child(_spacer(5))
	story.add_child(_label(level["title"], 34, COLOR_INK))
	story.add_child(_spacer(8))
	story.add_child(_body_label(level["story"], 16))
	story.add_child(_spacer(14))
	var lesson_card := _small_card(story)
	lesson_card.add_child(_eyebrow("這一關練習"))
	lesson_card.add_child(_spacer(4))
	lesson_card.add_child(_body_label(level["objective"], 14))
	lesson_card.add_child(_spacer(6))
	lesson_card.add_child(_label("通關得 50 分並取得 KEY", 12, COLOR_GREEN))
	var card := _card(columns[1])
	var inner := _card_content(card)
	inner.add_child(_eyebrow("故事選擇 · 每關一次挑戰"))
	inner.add_child(_spacer(3))
	inner.add_child(_label(level["prompt"], 21, COLOR_INK))
	inner.add_child(_spacer(9))
	for index in range(level["choices"].size()):
		var choice_button := _button("%s　%s" % [String.chr(65 + index), level["choices"][index]], false)
		choice_button.custom_minimum_size.y = 62
		choice_button.pressed.connect(_on_choice_pressed.bind(index))
		inner.add_child(choice_button)
	if not last_feedback.is_empty():
		inner.add_child(_spacer(4))
		var feedback_style := _style_box(Color("#e5efdf") if last_choice_was_correct else Color("#f8e8d8"), Color("#93aa8a") if last_choice_was_correct else Color("#c89572"), 12, 1)
		var feedback_panel := PanelContainer.new()
		feedback_panel.add_theme_stylebox_override("panel", feedback_style)
		inner.add_child(feedback_panel)
		var feedback_margin := MarginContainer.new()
		_set_margins(feedback_margin, 11, 12, 11, 12)
		feedback_panel.add_child(feedback_margin)
		feedback_margin.add_child(_body_label(last_feedback, 13, COLOR_INK))
		if last_choice_was_correct:
			inner.add_child(_spacer(5))
			var next_button := _button("取得 KEY　繼續前進　↗", true)
			next_button.pressed.connect(_continue_after_level)
			inner.add_child(next_button)
		else:
			var retry := _label("重新想一想，選一條更適合的路。", 11, COLOR_MUTED)
			retry.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			inner.add_child(retry)
	else:
		var hint := _label("選擇後會看到今晚故事的結果。", 11, COLOR_MUTED)
		hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		inner.add_child(hint)
	var footer := _label("夢境進度　%02d / 02　　·　　KEY %s" % [current_level + 1, "已取得" if keys[current_level] else "鎖定中"], 11, COLOR_MUTED)
	footer.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	inner.add_child(footer)


func _render_results() -> void:
	var content := _content_container()
	var card := _card(content)
	card.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var inner := _card_content(card)
	inner.add_child(_eyebrow("夜市故事完成 · 本次練習成果"))
	inner.add_child(_spacer(3))
	inner.add_child(_label("你讓兩個夢境\n都亮起來了。", 30, COLOR_INK))
	inner.add_child(_spacer(8))
	inner.add_child(_body_label("總分：%d / 100　　夢境 KEY：%d / 2" % [level_scores[0] + level_scores[1], int(keys[0]) + int(keys[1])], 16))
	inner.add_child(_spacer(9))
	for index in range(LEVELS.size()):
		inner.add_child(_label("%02d　%s　·　%d 分　·　KEY %s" % [index + 1, LEVELS[index]["title"], level_scores[index], "已取得" if keys[index] else "未取得"], 14, COLOR_GREEN))
		inner.add_child(_body_label(LEVELS[index]["lesson"], 12))
	inner.add_child(_spacer(9))
	inner.add_child(_body_label("你練習了先安排需要與目標，也認識到分散投資能降低集中風險，但投資仍可能有損失。下次遇到想買的東西，可以先問自己：我想完成的目標是什麼？", 14))
	inner.add_child(_spacer(12))
	var restart := _button("再走一次夜市　↻", true)
	restart.pressed.connect(_restart)
	inner.add_child(restart)
	var note := _label("這是本次遊戲紀錄，不是對學習成效的測驗。", 10, COLOR_MUTED)
	note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	inner.add_child(note)


func _on_choice_pressed(choice_index: int) -> void:
	if screen != "challenge" or keys[current_level]:
		return
	var level: Dictionary = LEVELS[current_level]
	if choice_index == int(level["correct"]):
		if not keys[current_level]:
			keys[current_level] = true
			level_scores[current_level] = 50
		last_feedback = level["success"]
		last_choice_was_correct = true
	else:
		last_feedback = level["wrong_feedback"][choice_index]
		last_choice_was_correct = false
	_render()


func _start_game() -> void:
	current_level = 0
	screen = "challenge"
	last_feedback = ""
	last_choice_was_correct = false
	_render()


func _continue_after_level() -> void:
	if not keys[current_level]:
		return
	if current_level == 0:
		current_level = 1
		last_feedback = ""
		last_choice_was_correct = false
		screen = "challenge"
	else:
		screen = "results"
	_render()


func _restart() -> void:
	current_level = 0
	level_scores = [0, 0]
	keys = [false, false]
	last_feedback = ""
	last_choice_was_correct = false
	screen = "intro"
	_render()


func _content_container() -> Control:
	var viewport_width: float = get_viewport().get_visible_rect().size.x
	var container: Control
	if viewport_width < 780:
		container = VBoxContainer.new()
		(container as VBoxContainer).add_theme_constant_override("separation", 14)
	else:
		container = HBoxContainer.new()
		(container as HBoxContainer).add_theme_constant_override("separation", 26)
	container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	body.add_child(container)
	return container


func _columns(parent: Control) -> Array[Control]:
	var viewport_width: float = get_viewport().get_visible_rect().size.x
	var left := VBoxContainer.new()
	left.add_theme_constant_override("separation", 8)
	left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	left.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var right := PanelContainer.new()
	right.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	right.size_flags_vertical = Control.SIZE_EXPAND_FILL
	right.add_theme_stylebox_override("panel", _style_box(COLOR_PAPER, Color("#b99357"), 18, 2))
	if viewport_width < 780:
		left.custom_minimum_size.y = 160
		right.custom_minimum_size.y = 380
	else:
		left.custom_minimum_size.x = 340
		right.custom_minimum_size.x = 530
	parent.add_child(left)
	parent.add_child(right)
	return [left, right]


func _story_column(columns: Array[Control]) -> VBoxContainer:
	return columns[0] as VBoxContainer


func _card(parent: Control) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _style_box(COLOR_PAPER, Color("#b99357"), 18, 2))
	parent.add_child(panel)
	return panel


func _small_card(parent: Control) -> VBoxContainer:
	var panel := PanelContainer.new()
	panel.add_theme_stylebox_override("panel", _style_box(Color("#f4ead5"), Color("#c8b287"), 12, 1))
	parent.add_child(panel)
	var margin := MarginContainer.new()
	_set_margins(margin, 12, 10, 12, 10)
	panel.add_child(margin)
	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 4)
	margin.add_child(content)
	return content


func _card_content(card: PanelContainer) -> VBoxContainer:
	var margin := MarginContainer.new()
	_set_margins(margin, 24, 18, 24, 18)
	card.add_child(margin)
	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 8)
	content.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margin.add_child(content)
	return content


func _button(text_value: String, primary: bool) -> Button:
	var button := Button.new()
	button.text = text_value
	button.custom_minimum_size = Vector2(0, 54 if primary else 62)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 16 if primary else 14)
	button.add_theme_color_override("font_color", Color("#fff6e3") if primary else COLOR_INK)
	button.add_theme_color_override("font_hover_color", Color.WHITE if primary else COLOR_INK)
	var normal := _style_box(COLOR_GREEN if primary else Color("#fffaf0"), COLOR_GREEN if primary else Color("#d9c7a3"), 12, 1)
	var hover := _style_box(COLOR_GREEN_HOVER if primary else Color("#f5e8ce"), Color("#89a08a") if primary else Color("#9d895e"), 12, 2)
	var pressed := _style_box(Color("#3f6254") if primary else Color("#efdbb5"), Color("#3f6254") if primary else Color("#9d895e"), 12, 2)
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", pressed)
	button.add_theme_stylebox_override("focus", _style_box(Color(0, 0, 0, 0), Color("#bf8e45"), 12, 3))
	return button


func _label(text_value: String, font_size: int, font_color: Color) -> Label:
	var label := Label.new()
	label.text = text_value
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", font_color)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	return label


func _body_label(text_value: String, font_size: int, font_color: Color = COLOR_MUTED) -> Label:
	var label := _label(text_value, font_size, font_color)
	label.add_theme_constant_override("line_spacing", 4)
	return label


func _eyebrow(text_value: String) -> Label:
	return _label(text_value, 11, Color("#9a7946"))


func _tag_row(tags: Array[String]) -> HFlowContainer:
	var flow := HFlowContainer.new()
	flow.add_theme_constant_override("h_separation", 7)
	flow.add_theme_constant_override("v_separation", 7)
	for tag in tags:
		var label := _label("　%s　" % tag, 11, COLOR_GREEN)
		label.add_theme_stylebox_override("normal", _style_box(Color("#f1eadb"), Color("#d2c5a9"), 12, 1))
		flow.add_child(label)
	return flow


func _spacer(height: float) -> Control:
	var spacer := Control.new()
	spacer.custom_minimum_size.y = height
	return spacer


func _style_box(background: Color, border: Color, radius: int, border_width: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = background
	style.border_color = border
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(radius)
	style.content_margin_left = 12
	style.content_margin_right = 12
	style.content_margin_top = 8
	style.content_margin_bottom = 8
	return style


func _set_margins(container: MarginContainer, left: int, top: int, right: int, bottom: int) -> void:
	container.add_theme_constant_override("margin_left", left)
	container.add_theme_constant_override("margin_top", top)
	container.add_theme_constant_override("margin_right", right)
	container.add_theme_constant_override("margin_bottom", bottom)
