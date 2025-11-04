extends Area2D
@export var speed := -2000
@export var direction = 1
@export var axis = "x"
@export_multiline var text = ""
@onready var label: Label = $Label



func _process(delta: float) -> void:
	if axis == "x":
		position.x += speed * delta * direction 
	if axis == "y":
		position.y += speed * delta * direction 
	if global_position.x > -20020 and global_position.x < -20000:
		queue_free()
	label.text = text
	

	
func _on_area_entered(_area: Area2D) -> void:
	var next_level_no = Global.level + 1
	var next_level = "res://scenes/levels 1-10/level_" + str(next_level_no) + ".tscn"
	get_tree().change_scene_to_file(next_level)
	Global.level += 1
