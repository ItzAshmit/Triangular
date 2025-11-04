extends Area2D


@export_multiline var text:String = ""
@export var speed := -2000
@export_enum("Left", "Right", "Up", "Down") var direction := "Left"
@export var is_score_bar:bool = false
@export var is_level_end_bar: bool = false
@onready var timer: Timer = %Timer
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var animation_player_2: AnimationPlayer = %AnimationPlayer2
@onready var area_2d: Area2D = $"."
@onready var animation_player_3: AnimationPlayer = %AnimationPlayer3
@onready var timer_2: Timer = %Timer2
@onready var game_over: Panel = %game_over
@onready var pause: Button = %PAUSE
@onready var info_label: Label = $info_label



	
func scoring():
	if is_score_bar:
		while true:
			await get_tree().create_timer(0.1).timeout
			info_label.text = "SCORE -- " + str(Global.endless_score)

func _ready() -> void:
	info_label.text = text
	if get_tree().current_scene.scene_file_path == "res://scenes/endless_mode.tscn":
		if is_score_bar:
			scoring()
		Global.is_endless_mode = true
		game_over.visible = false
		


func get_direction() -> Vector2:
	match direction:
		"Right":
			return Vector2.LEFT
		"Left":
			return Vector2.RIGHT
		"Down":
			return Vector2.UP
		"Up":
			return Vector2.DOWN
		_:
			return Vector2.ZERO

func _process(delta: float) -> void:
	position += get_direction() * delta * speed

func _on_area_entered(_area: Area2D) -> void:
	if not Global.is_endless_mode:
		if is_level_end_bar:
			set_process(false)
			timer.start()
			animation_player.play("player")
			animation_player_2.play("background")


			
		else:
			animation_player_2.play("background")
			animation_player_3.play("dying")
			timer_2.start()

	else:
			pause.visible = false
func _on_timer_2_timeout() -> void:
	animation_player_2.play("RESET")
	animation_player_3.play("RESET")
	get_tree().reload_current_scene()


func _on_timer_timeout() -> void:
	if not Global.is_endless_mode:
		var current_lev = Global.current_path.split("res://scenes/levels 1-10/level_")
		var current_leve = current_lev[1].split(".tscn")
		var current_level = current_leve[0]
		animation_player.play("RESET")
		animation_player_2.play("RESET")
		if Global.is_full_game:
			if Global.is_tutorial == false:
				set_process(true)
				if int(current_level) == Global.level:
					Global.level += 1
				var next_level = "res://scenes/levels 1-10/level_" + str(Global.level) + ".tscn"
				get_tree().change_scene_to_file(next_level)
				Global.current_path = next_level
			else:
				var next_level = "res://scenes/levels 1-10/level_" + str(1) + ".tscn"
				get_tree().change_scene_to_file(next_level)
				Global.current_path = next_level
				Global.is_tutorial = false
		if not Global.is_full_game and not Global.is_tutorial and Global.level > Global.free_levels:
			get_tree().change_scene_to_file("res://scenes/premium.tscn")
			if int(current_level) == Global.level:
				Global.level += 1
		else:
			if Global.is_tutorial == false:
				set_process(true)
				if int(current_level) == Global.level:
					Global.level += 1
				var next_level = "res://scenes/levels 1-10/level_" + str(Global.level) + ".tscn"
				if is_inside_tree():
					get_tree().change_scene_to_file(next_level)
				Global.current_path = next_level
			else:
				var next_level = "res://scenes/levels 1-10/level_" + str(1) + ".tscn"
				get_tree().change_scene_to_file(next_level)
				Global.current_path = next_level
				Global.is_tutorial = false
	Save.save()
