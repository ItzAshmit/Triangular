extends Control
@onready var panel: Panel = %Panel
@onready var h_slider: HSlider = $Panel/HSlider
@onready var v_slider: VSlider = $Panel/VSlider
@onready var h_slider_2: HSlider = $Panel/HSlider2
@onready var close: Button = $close
@onready var check_button: CheckButton = $Panel/CheckButton
@onready var tab_bar: TabBar = $main_settings
@onready var player: Sprite2D = $player
@onready var reset_all_panel: Panel = %"reset all panel"


var Master_volume:float
var Sfx_volume:float
var Music_volume:float





func _ready() -> void:
	Save.load_data()
	
	
	h_slider.value = Global.h_volume
	v_slider.value = Global.sfx_volume
	h_slider_2.value = Global.music_volume
  
	
	
	
	panel.visible = false
	if Global.is_fullscreen:
		check_button.button_pressed = true




func _on_tab_bar_tab_selected(tab: int) -> void:
	reset_all_panel.visible = false
	panel.visible = true


func _on_check_button_toggled(toggled_on: bool) -> void:
	Global.is_fullscreen = toggled_on 
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.is_fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Global.is_fullscreen = false
	Save.save()
	



func _on_close_pressed() -> void:
	Global.Show_ads()
	Save.save()


func _on_locked_tab_selected(tab: int) -> void:
	reset_all_panel.visible = false
	panel.visible = false

func _on_unlocked_tab_selected(tab: int) -> void:
	reset_all_panel.visible = false
	panel.visible = false


#/////////////////////volume settings////////////////////////////
func _process(delta: float) -> void:
	VolumeOfSliders()

func VolumeOfSliders():
	Master_volume = h_slider.value
	Music_volume = h_slider_2.value
	Sfx_volume = v_slider.value
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),Master_volume) 
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"),Music_volume) 
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sound effects"),Sfx_volume) 
	
	Global.h_volume = Master_volume
	Global.music_volume = Music_volume
	Global.sfx_volume = Sfx_volume
	
