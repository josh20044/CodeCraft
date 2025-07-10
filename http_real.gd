extends HTTPRequest

const host : String = "https://codecraft-database-default-rtdb.asia-southeast1.firebasedatabase.app/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func send_data(data: Dictionary, id : String):
	var user_data = JSON.stringify(data)
	var url = host + ("user/%s.json" % id)
	print("send data")
	request(url, [], HTTPClient.METHOD_PUT, user_data)
