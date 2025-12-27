@tool
extends Button


func _ready() -> void:
	Global.Show_ads()




func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorials_1.tscn")
	Global.is_tutorial = true
