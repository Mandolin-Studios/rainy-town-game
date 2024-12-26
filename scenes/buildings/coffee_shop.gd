extends StaticBody2D

@export var lights : bool:
	set(value):
		lights = value
		$light1.enabled = lights
		$light2.enabled = lights

@export var in_rain : bool = true:
	set(value):
		in_rain = value
		#$downspout_spray.emitting = in_rain
		#$roof_drips.emitting = in_rain

	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$light1.enabled = lights
	#$light2.enabled = lights
	$downspout_spray.emitting = in_rain
	$roof_drips.emitting = in_rain


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#update_texture()
	#pass


func _on_doormat_body_entered(body: Node2D) -> void:
	#lights = true
	if body.is_in_group("player"):
		body.add_action(self, "Press space to enter the shop.")

func _on_doormat_body_exited(body: Node2D) -> void:
	#lights = false
	if body.is_in_group("player"):
		body.remove_action()

func interact(player):
	print("Interaction from player to coffee shop.")
	#Play door sounds
	#$knockSound.play()
	
	get_tree().current_scene.enter_building("coffee-shop")
	
