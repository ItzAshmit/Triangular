extends Button
@onready var reset_all_panel: Panel = %"reset all panel"
@onready var reset_all: Button = $"."
@onready var restore_panel: Panel = %restore_panel
@onready var label_2: Label = %Label2
@onready var restore: Button = %restore
@onready var reset_all_2: Button = %reset_all2



func _ready() -> void:
	Global.connect("purchase_restored", Callable(self, "_on_purchase_restored"))
	if Global.is_full_game:
		restore.visible = false
	reset_all_2.visible = true
	reset_all_panel.visible = false
	restore_panel.visible = false
	if Global.level == 1 and Global.best_endless_score == 0:
		reset_all.visible = false
	else:
		reset_all.visible = true


func _on_purchase_restored(success: bool):
	restore.disabled = false
	if success:
		label_2.text = "Bro see you got the things"
	else:
		label_2.text = "Sorry \nIf you really had a purchase,\nPlease try again with a proper Internet Connection"

func _on_pressed() -> void:
	reset_all_panel.visible = true
	restore_panel.visible = false


func _on_reset_all_2_pressed() -> void:
	Global.best_endless_score = 0
	Global.level = 1
	reset_all.visible = false
	Global.free_levels = 7
	Global.Show_ads()


func _on_pressed_restore() -> void:
	Global.Show_ads()
	restore_panel.visible = true
