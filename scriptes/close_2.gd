extends Button
@onready var reset_all_panel: Panel = %"reset all panel"
@onready var reset_all: Button = $"."


func _ready() -> void:
	reset_all_panel.visible = false
	if Global.level == 1 and Global.best_endless_score == 0:
		reset_all.visible = false
	else:
		reset_all.visible = true


func _on_pressed() -> void:
	Global.Show_ads()
	reset_all_panel.visible = true
	


func _on_reset_all_2_pressed() -> void:
	Global.Show_ads()
	Global.best_endless_score = 0
	Global.level = 1
	reset_all.visible = false
