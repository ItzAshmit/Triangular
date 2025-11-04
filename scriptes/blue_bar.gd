extends Area2D
const speed = -1200
const direction = 1
func _process(delta: float) -> void:
	position.x += speed * delta * direction

func _on_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene()
