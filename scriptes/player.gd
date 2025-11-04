extends Node2D


func _process(delta: float) -> void:
	if Input.is_action_pressed("rotation_right"):
		rotation_degrees += 500 * delta
	
	if Input.is_action_pressed("rotation_left"):
		rotation_degrees += -500 * delta

	
