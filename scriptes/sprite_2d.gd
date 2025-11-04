extends Sprite2D
var can_move := true
func _process(delta: float) -> void:
		if Input.is_action_pressed("innner_rotation_left"):
			rotation_degrees += 500 * delta
	
		if Input.is_action_pressed("innner_rotation_right"):
			rotation_degrees += -500 * delta
		if not can_move:
			return
