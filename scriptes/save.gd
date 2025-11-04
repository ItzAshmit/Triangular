extends Node


var save_path = "user://Saved2.save"





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), Global.h_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), Global.music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sound effects"), Global.sfx_volume)

	load_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func save():
	print("saving")
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var(Global.level)
	file.store_var(Global.free_levels)
	file.store_var(Global.h_volume)
	file.store_var(Global.sfx_volume)
	file.store_var(Global.music_volume)
	file.store_var(Global.best_endless_score)
	file.store_var(Global.is_fullscreen)
	file.store_var(Global.is_full_game)
	file.close()
	
	
func load_data():
	if FileAccess.file_exists(save_path):
		print("Loading")
		var file = FileAccess.open(save_path,FileAccess.READ)
		Global.level = file.get_var()
		Global.free_levels = file.get_var()
		Global.h_volume = file.get_var()
		Global.sfx_volume = file.get_var()
		Global.music_volume = file.get_var()
		Global.best_endless_score = file.get_var()
		Global.is_fullscreen = file.get_var()
		Global.is_full_game = file.get_var()
		file.close()
		
