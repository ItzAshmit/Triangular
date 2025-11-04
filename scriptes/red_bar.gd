extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += -1200 * delta
		
func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2:
		pass
	else:
		get_tree().reload_current_scene()
