extends Node
@onready var obstacles: Node = $"../obstacles"
const BLUE_BAR = preload("res://scenes/BARS/blue_bar.tscn")
const RED_BAR = preload("res://scenes/BARS/red_bar.tscn")
const ROTATE_BAR = preload("res://scenes/BARS/rotate_bar.tscn")
const SCALING_BAR = preload("res://scenes/BARS/scaling_bar.tscn")
const LEVEL_END_BAR = preload("res://scenes/BARS/level_end_bar.tscn")
const SCORE = preload("res://scenes/BARS/score.tscn")
const INVISIBLE_BAR = preload("res://scenes/BARS/invisible_bar.tscn")
@onready var pause: Button = %PAUSE
@onready var panel_2: Panel = %Panel2
@onready var panel: Panel = %Panel
@onready var label: Label = %Label












func start_scoring():
	await get_tree().process_frame
	while true:
		if not is_inside_tree():
			break
		if get_tree().paused:
			await get_tree().process_frame
			continue
		await get_tree().create_timer(0.1,true).timeout
		Global.endless_score += 1
		if Global.best_endless_score < Global.endless_score:
			var score = Global.endless_score - Global.best_endless_score
			Global.best_endless_score += score
	Save.save()
func spawing_scoring():
	await get_tree().process_frame
	while true:
		if not is_inside_tree():
			break
		if get_tree().paused:
			await get_tree().process_frame
			continue
		await get_tree().create_timer(randi_range(10,30),true).timeout
		var score_bar = SCORE.instantiate()
		score_bar.position = Vector2(10000,randi_range(-2000,2000))
		score_bar.scale = Vector2(8,8)
		obstacles.add_child(score_bar)
	
	
	
func despawing():
	for bar in [BLUE_BAR,RED_BAR,ROTATE_BAR,SCALING_BAR,INVISIBLE_BAR]:
		if bar.position.x > 150000:
			bar.queue_free()
	
func _ready() -> void:
	Global.is_endless_mode = true
	randomize()
	if Global.is_full_game:
		if not get_tree().paused:
			start_scoring()
			spawing_scoring()
			spwaing(RED_BAR,60,10, 0.0)
			spwaing(BLUE_BAR,50,10, 0.0)
			spwaing(ROTATE_BAR,40,3, 30)
			spwaing(SCALING_BAR,40,5, 60)
			spwaing(INVISIBLE_BAR,40,10, 90)
	else:
		if not get_tree().paused:
			start_scoring()
			spawing_scoring()
			spwaing(RED_BAR,60,10, 0.0)
			spwaing(BLUE_BAR,50,10, 0.0)
			spwaing(ROTATE_BAR,40,3, 30)
			spwaing(SCALING_BAR,40,5, 60)
			spwaing(INVISIBLE_BAR,40,10, 90)
			await get_tree().create_timer(90,false).timeout
			get_tree().paused = true
			panel_2.visible = true
			pause.visible = false
			more_endless_time()

				
				
func more_endless_time():
	if not Global.is_panel_showing:
		while true:
			await get_tree().create_timer(0.1).timeout
			if Global.endless_time_updated:
				panel.visible = true
				label.text = "Score -- " + str(Global.endless_score)
				panel_2.visible = false
				await get_tree().create_timer(30,false).timeout
				get_tree().paused = true
				panel_2.visible = true
				pause.visible = false
				Global.endless_time_updated = false 
				continue
		
func percentage(needed):
	var float_needed:float = needed/100.0
	if randf() < float_needed:
		return true
		
func spwaing(bar, percentage_no:int ,random:int, sec_to_wait_for_spawn:float):
	await get_tree().process_frame
	if not get_tree().paused:
		await get_tree().create_timer(3,true).timeout
		await get_tree().create_timer(sec_to_wait_for_spawn,true).timeout
		while true:
			if not is_inside_tree():
				break
			if get_tree().paused:
				await get_tree().process_frame
				continue
			await get_tree().create_timer(2.0,true).timeout
			if percentage(percentage_no):
				var ini_bar = bar.instantiate()
				ini_bar.position = Vector2(10000,randi_range(-3000,3000))
				var random_scale = randi_range(1,random)
				ini_bar.scale = Vector2(random_scale,random_scale)
				obstacles.add_child(ini_bar)
