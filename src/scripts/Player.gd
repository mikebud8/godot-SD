extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
enum AtBatResult {STRIKE_OUT, GROUND_OUT, FLY_OUT, WALK, SINGLE, SINGLE_PLUS, DOUBLE, TRIPLE, DINGER}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var val = 2
	var resp = getAtBatResult(val)
	print(resp)
	
	val = 19
	resp = getAtBatResult(val)
	print(resp)
	pass # Replace with function body.


func getAtBatResult(roll: int) -> int:
	if roll <= 10:
		return AtBatResult.STRIKE_OUT
	else:
		return AtBatResult.DOUBLE
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
