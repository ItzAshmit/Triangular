extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		pass
	else:
		get_tree().reload_current_scene()
