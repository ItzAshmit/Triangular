extends Node2D
@onready var button_3: Button = $buttons/Button3
@onready var label: Label = $buttons/Label
@onready var button_2: Button = $buttons/Button2





func _ready() -> void:
	label.visible = false
	Global.is_endless_mode = false
	if Global.level == 1:
		button_3.text = "START!!"
	else:
		button_3.text = "LETS GO AGAIN!!"
	

	
	
	
func _on_button_pressed() -> void:
	Global.Show_ads()
	Global.is_endless_mode = false
	get_tree().change_scene_to_file("res://scenes/SETTINGS.tscn")



func _on_button_2_pressed() -> void:
	if Global.level > 1:
		Global.is_endless_mode = true
		Global.Show_ads()
		get_tree().change_scene_to_file("res://scenes/endless_mode.tscn")
	else:
		label.visible = true
		await get_tree().create_timer(3,false).timeout
		label.visible = false
		

func _on_button_3_pressed() -> void:
	Global.Show_ads()
	Global.is_endless_mode = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")
