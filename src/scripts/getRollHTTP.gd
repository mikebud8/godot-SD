extends HTTPRequest


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var rollButton: Button = get_parent().get_node("Button")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_use_threads(true)
	rollButton.connect("pressed",self, "requestRoll")
	self.connect("request_completed", self, "doSomething")
	print("HTTP Request initialized")
	pass

func requestRoll() -> void:
	self.request("http://192.168.1.20:8080/roll")
	pass # Replace with function body.

func doSomething(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var data = body.get_string_from_utf8()
	var p = JSON.parse(data)
	
	print(data)
	get_parent().get_node("Label").text = str(p.result["roll"])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
