extends Node2D





func _ready() -> void:
	Save.load_data()
	if Global.is_full_game:
		var level_number = Global.level
		var path = "res://scenes/levels 1-10/level_" + str(level_number) + ".tscn"
		var level_scene = load(path)
		Global.current_path = "res://scenes/levels 1-10/level_" + str(level_number) + ".tscn"
		if level_scene:
			var level_instance = level_scene.instantiate()
			add_child(level_instance)
		else:
			print("Couldn't load level: " + path)
			Global.level = 1
			add_child(load("res://scenes/levels 1-10/level_1.tscn").instantiate())
			Global.current_path = "res://scenes/levels 1-10/level_1.tscn"
	if not Global.is_full_game and Global.level > Global.free_levels:
		await get_tree().process_frame
		var sucess = get_tree().change_scene_to_file("res://scenes/premium.tscn")
		return
	else:
		var level_number = Global.level
		var path = "res://scenes/levels 1-10/level_" + str(level_number) + ".tscn"
		var level_scene = load(path)
		Global.current_path = "res://scenes/levels 1-10/level_" + str(level_number) + ".tscn"
		if level_scene:
			var level_instance = level_scene.instantiate()
			add_child(level_instance)
		else:
			print("Couldn't load level: " + path)
			Global.level = 1
			add_child(load("res://scenes/levels 1-10/level_1.tscn").instantiate())
			Global.current_path = "res://scenes/levels 1-10/level_1.tscn"
