@tool
extends StaticBody2D

var red_skin = preload("res://assets/textures/buildings/small_houses/house1.png")
var blue_skin = preload("res://assets/textures/buildings/small_houses/house2.png")
var white_skin = preload("res://assets/textures/buildings/small_houses/house4.png")
var green_skin = preload("res://assets/textures/buildings/small_houses/house3.png")


@export_enum("red", "blue", "green", "white")  var texture : String:
	set(value):
		print("Setting Texture to " + value)
		texture = value
		update_texture()

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


func update_texture():
	if $Sprite == null:
		return
	match texture:
		"red":
			$Sprite.texture = red_skin
		"blue":
			$Sprite.texture = blue_skin
		"white":
			$Sprite.texture = white_skin
		"green":
			$Sprite.texture = green_skin
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_texture()
	if not Engine.is_editor_hint():
		$light1.enabled = lights
		$light2.enabled = lights
		$downspout_spray.emitting = false
		$roof_drips.emitting = in_rain


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#update_texture()
	#pass


func _on_doormat_body_entered(body: Node2D) -> void:
	lights = true
	if body.is_in_group("player"):
		body.add_action(self, "Press space to knock.")

func _on_doormat_body_exited(body: Node2D) -> void:
	lights = false
	if body.is_in_group("player"):
		body.remove_action()

func interact(player):
	print("Interaction from player to small house.")
	print(self)
	print(player)
	$knockSound.play()
	
