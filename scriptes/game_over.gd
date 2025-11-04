extends Panel
@onready var game_over: Panel = %game_over
@onready var pause: Button = $"../PAUSE"
@onready var animation_player_game_over_: AnimationPlayer = %"AnimationPlayer(game_over)"
@onready var label: Label = $Label


func _ready() -> void:
	game_over.visible = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if Global.is_endless_mode:
		label.text = "SCORE -- " + str(Global.endless_score)
		if Global.best_endless_score <= Global.endless_score:
			label.text = "NEW BEST SCORE -- " + str(Global.best_endless_score)
		get_tree().paused = true
		pause.visible = false
		animation_player_game_over_.play("game_over")
		await get_tree().create_timer(1.0)
		game_over.visible = true
		
