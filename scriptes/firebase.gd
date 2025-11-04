extends Node

var http_request: HTTPRequest

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

	var device_id = OS.get_unique_id()
	var url = "https://device-streaming-0e5e6090-default-rtdb.firebaseio.com/users/%s.json" % device_id
	http_request.request(url)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var parse_result = JSON.parse_string(body.get_string_from_utf8())
		if parse_result != null and parse_result.error == OK:
			var data = parse_result.result
			if data != null and data.has("is_full_game") and data["is_full_game"] == true:
				Global.is_full_game = true
				print("✅ Full game unlocked")
			else:
				Global.is_full_game = false
				print("❌ Demo mode only")
		else:
			print("⚠️ JSON parse error or empty response")
	else:
		print("⚠️ Server error:", response_code)

		
		
func unlock_full_game():
	var device_id = OS.get_unique_id()  # or "user123"
	var url = "https://device-streaming-0e5e6090-default-rtdb.firebaseio.com/users/%s.json" % device_id

	var body_dict = { "is_full_game": true }
	var json_str = JSON.stringify(body_dict)  # must be String

	var err = http_request.request(
		url,
		PackedStringArray(),       # headers
		HTTPClient.METHOD_PUT,     # method
		json_str                   # body as String
	)

	if err != OK:
		print("⚠️ Failed to send PUT request:", err)
