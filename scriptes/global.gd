extends Node


signal purchase_restored(success: bool)

func _ready() -> void:
	Save.load_data()
	purchase_updated1 = false
	await get_tree().create_timer(1,false).timeout
	MobileAds.initialize()
	
	
	
	
	
	
	
	
	#///////////////////////////////////////////Play In App Purchases System///////////////////////////////////////////
	
	
	
	
	
	
	if Engine.has_singleton("GodotGooglePlayBilling"):
		print("Billing plugin exists................................")
		billing = Engine.get_singleton("GodotGooglePlayBilling")
		billing.connect("connected", Callable(self, "connected"))
		billing.connect("disconnected", Callable(self, "disconnected"))
		billing.connect("connect_error", Callable(self, "connect_error"))
		billing.connect("purchases_updated", Callable(self, "purchases_updated"))
		billing.connect("purchase_error", Callable(self, "purchase_error"))
		billing.connect("sku_details_query_completed", Callable(self, "sku_details_query_completed"))
		billing.connect("sku_details_query_error", Callable(self, "sku_details_query_error"))
		billing.connect("purchase_aknowledged", Callable(self, "purchase_aknowledged"))
		billing.connect("purchase_aknowledgement_error", Callable(self, "purchase_aknowledgement_error"))
		billing.connect("purchase_consumed", Callable(self, "purchase_consumed"))
		billing.connect("purchases_consumption_error", Callable(self, "purchases_consumption_error"))
		billing.startConnection()

func connected():
	billing.querySkuDetails(["full_game"], "inapp")
	
func  purchase_consumed(token):
	print("item was consumed" + token)

	
	
func purchase_acknowledged(token):
	print("purchase was acknowledged" + token)
	is_full_game = true
	Firebase.unlock_full_game()
	Save.save()


func purchases_updated(items):
	print("purchase was updated  " + items)
	for item in items:
		if !item.is_acknowledged:
			print(item.purchase_token)
			billing.acknowledgePurchase(item.purchase_token)
	if items.size()>0:
		is_full_game = true
		Save.save()
		itemToken = items[items.size()-1].purchase_token

func purchase_item():
	var response = billing.purchase("full_game")
	print(response.status)
	if response.status != OK:
		print("error purchasing item")

func use_item():
	if itemToken == null:
		print("error you need to buy this first")
	else:
		print("consumin item")
		billing.consumePurchase(itemToken)















#///////////////////////////////////////////Play In App Purchases System///////////////////////////////////////////










#///////////////////////////////////////////Ads system intersititial///////////////////////////////////////////





var _interstitial_ad: InterstitialAd


func Show_ads():
	if not is_full_game:
		if randi_range(1,100) <= 10:
			print("ad showed")
			#free memory
			if _interstitial_ad:
				#always call this method on all AdFormats to free memory on Android/iOS
				_interstitial_ad.destroy()
				_interstitial_ad = null

			var unit_id : String
			if OS.get_name() == "Android":
				unit_id = "ca-app-pub-5129141358491490/1259703512"
			elif OS.get_name() == "iOS":
				unit_id = "ca-app-pub-3940256099942544/4411468910"

			var interstitial_ad_load_callback := InterstitialAdLoadCallback.new()
			interstitial_ad_load_callback.on_ad_failed_to_load = func(adError : LoadAdError) -> void:
				print(adError.message)

			interstitial_ad_load_callback.on_ad_loaded = func(interstitial_ad : InterstitialAd) -> void:
				print("interstitial ad loaded" + str(interstitial_ad._uid))
				if interstitial_ad:
					interstitial_ad.show()
				_interstitial_ad = interstitial_ad

			InterstitialAdLoader.new().load(unit_id, AdRequest.new(), interstitial_ad_load_callback)











#///////////////////////////////////////////Ads system intersititial///////////////////////////////////////////






var is_panel_showing:bool
var resume_should_show:bool
var free_levels := 7
var purchase_updated1 = false
var watched_free_level_ad := false
var endless_free_time := 90
var endless_time_updated := false
var endless_score := 0.0
var is_endless_mode:bool = false
var billing
var itemToken
var is_tutorial:bool = false
var is_full_game: bool = false
var current_path = ""
var h_volume := 1.0
var music_volume := 1.0
var sfx_volume := 1.0
var level := 1
var is_fullscreen:bool = true
var best_endless_score := 0.0
