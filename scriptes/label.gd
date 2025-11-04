extends Label
@onready var label: Label = $"."

func _ready() -> void:
	if Global.best_endless_score:
		label.visible = true
		label.text = "BEST -- " + str(Global.best_endless_score)
	else:
		label.visible = false
		
		
