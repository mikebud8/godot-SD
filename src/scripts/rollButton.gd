extends Button


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _pressed() -> void:
	print("button pressed")
	var httpReq = load("res://src/scripts/getRollHTTP.gd").new()
	print("httpReq object made")
	httpReq.requestRoll()
	#$HTTPRequest.requestRoll()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
