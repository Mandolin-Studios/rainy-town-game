@tool
extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = [0,0,1,1,2,2,3,3,4,5].pick_random()
	scale = Vector2(1.25,1.25) * [1,1.5,1.1,1.5,1.25,1.25,2,2,3].pick_random()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
