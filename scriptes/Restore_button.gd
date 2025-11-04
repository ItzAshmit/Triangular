extends Button

@onready var panel: Panel = $Panel
@onready var button: Button = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible = false
	if not Global.is_full_game:
		button.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	Global.Show_ads()
	panel.visible = true
