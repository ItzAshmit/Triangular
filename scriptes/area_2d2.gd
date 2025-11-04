extends Area2D
@onready var timer: Timer = $"../red_bar/Timer"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += -1200 * delta
		
func _on_blue_bar_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2:
		pass
	else:
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
