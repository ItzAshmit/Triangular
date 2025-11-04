extends Button

var on_user_earned_reward_listener := OnUserEarnedRewardListener.new()
var _rewarded_ad: RewardedAd



@onready var button_2: Button = %Button2
@onready var button: Button = %Button

func _ready() -> void:
	on_user_earned_reward_listener.on_user_earned_reward = Callable(self, "on_user_earned_reward")
	if Global.is_full_game:
		button.disabled = true
		button.text = "Thanks\n For\n Buying\nNOW ENJOY"


func _on_pressed() -> void:
		Global.purchase_item()
	
func _on_ExtraLevelButton_pressed():
	# Only for free players
	if not Global.is_full_game:
		# Increment the free level counters
		Global.level += 1
		Global.free_levels += 1

		# Build the path for the next level
		var path = "res://scenes/levels 1-10/level_" + str(Global.level) + ".tscn"
		Global.current_path = path

		# Load the next level
		var level_scene = load(path)
		if level_scene:
			get_tree().change_scene_to_file(path)
		else:
			print("Couldn't load level: " + path)
		Global.watched_free_level_ad = false
	Save.save()


func _on_Admob_pressed() -> void:
	if not Global.is_full_game:
		button_2.disabled = true
		if _rewarded_ad:
			#always call this method on all AdFormats to free memory on Android/iOS
			_rewarded_ad.destroy()
			_rewarded_ad = null

		var unit_id : String
		if OS.get_name() == "Android":
			unit_id = "ca-app-pub-5129141358491490/9563637316"
		elif OS.get_name() == "iOS":
			unit_id = "ca-app-pub-3940256099942544/1712485313"

		var rewarded_ad_load_callback := RewardedAdLoadCallback.new()
		rewarded_ad_load_callback.on_ad_failed_to_load = func(adError : LoadAdError) -> void:
			button_2.disabled = false

		rewarded_ad_load_callback.on_ad_loaded = func(rewarded_ad : RewardedAd) -> void:
			if rewarded_ad:
				rewarded_ad.show(on_user_earned_reward_listener)
				button_2.disabled = false
			_rewarded_ad = rewarded_ad

		RewardedAdLoader.new().load(unit_id, AdRequest.new(), rewarded_ad_load_callback)

func on_user_earned_reward(rewarded_item : RewardedItem):
			if not Global.is_endless_mode:
				_on_ExtraLevelButton_pressed()
			else:
				Global.endless_time_updated = true
