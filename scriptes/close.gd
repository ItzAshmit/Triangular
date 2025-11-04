extends Button
@onready var game_over: Panel = %game_over
@onready var panel: Panel = %Panel
@onready var pause: Button = %PAUSE
@onready var label: Label = %Label
@onready var option_button: OptionButton = %OptionButton






func _ready() -> void:
	panel.visible = false
	for i in range(option_button.item_count):
		if Global.is_full_game and i + 1 > Global.level:
			option_button.set_item_disabled(i,true)
		elif not Global.is_full_game and i + 1 > Global.free_levels:
			option_button.set_item_disabled(i,true)
		else:
			if i + 1 > Global.level:
				option_button.set_item_disabled(i,true)
	var popup = option_button.get_popup()

	# Set max size (popup will grow to fit content up to this size)
	popup.set_max_size(Vector2(400, 300))  # adjust as needed

	# Style the popup panel
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color(0.27, 0.001, 0.645)
	stylebox.corner_radius_top_left = 10
	stylebox.corner_radius_top_right = 10
	stylebox.corner_radius_bottom_left = 10
	stylebox.corner_radius_bottom_right = 10
	popup.add_theme_stylebox_override("panel", stylebox)

	# Optional: Increase separation between items for readability
	popup.add_theme_constant_override("separation", 8)


func _on_button_pressed() -> void:
	Global.is_panel_showing = false
	Global.resume_should_show = false
	panel.visible = false
	get_tree().paused = false
	pause.visible = true





func _on_pressed() -> void:
	Global.is_panel_showing = true
	panel.visible = true
	if Global.is_endless_mode:
		label.visible = true
		label.text = "SCORE -- " + str(Global.endless_score)
		if Global.endless_score >= Global.best_endless_score:
			print("hello")
			label.text = "NEW BEST SCORE -- " + str(Global.endless_score)
	get_tree().paused = true
	
func _on_main_menu_pressed() -> void:
	Global.Show_ads()
	Global.is_panel_showing = false
	Global.resume_should_show = false
	Global.endless_score = 0
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_restart_pressed() -> void:
	Global.Show_ads()
	Global.is_panel_showing = false
	Global.resume_should_show = false
	Global.endless_score = 0
	get_tree().paused = false
	get_tree().reload_current_scene()
	panel.visible = false
	
	
func _on_option_button_item_selected(index: int) -> void:
	index += 1
	if Global.level >= index:
		var path ="res://scenes/levels 1-10/level_" + str(index) +".tscn"
		Global.current_path = path
		get_tree().paused = false
		get_tree().change_scene_to_file(path)
