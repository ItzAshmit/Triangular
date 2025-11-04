extends Button
@onready var panel: Panel = %Panel






func _on_button_pressed() -> void:
	panel.visible = false
	Global.Show_ads()
	get_tree().paused = false
