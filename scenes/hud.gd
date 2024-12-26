extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func display_text(text):
	$Label.text = text
	$Label.show()

func hide_text():
	$Label.hide()

func display_item():
	$CenterContainer.show()

func hide_item():
	$CenterContainer.hide()
