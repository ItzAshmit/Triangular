extends Polygon2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("innner_rotation_right"):
		invert_enabled = true
		
	if Input.is_action_just_pressed("innner_rotation_left"):
		invert_enabled = false
		
	
