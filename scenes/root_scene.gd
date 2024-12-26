extends Node2D

var town_scene = preload("res://scenes/maps/town.tscn")
var coffee_shop_scene = preload("res://scenes/maps/coffee-shop.tscn")
var my_house_scene = preload("res://scenes/maps/my_house.tscn")
var player_scene = preload("res://scenes/player.tscn")

var player = null
var map = null

@onready var hud: Control = $CanvasLayer/Control
@onready var weather: Node2D = $Weather

var circle_transition_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = player_scene.instantiate()
	add_child(player)
	player.connect("display_text", hud.display_text)
	player.connect("hide_text", hud.hide_text)
	
	player.connect("show_coffee", hud.display_item)
	player.connect("hide_coffee", hud.hide_item)
	
	weather.follow = player
	
	load_map(town_scene)
	wake_up()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func load_map(scene):
	if map != null:
		map.queue_free()
	
	map = scene.instantiate()
	add_child(map)
	
	var spawn : Marker2D = map.get_node("spawn")
	player.position = spawn.position
	
	print(map.type)
	if map.type == "outdoors-rainy":
		weather.weatherType = "rain"
	else:
		weather.weatherType = "clear"
	weather.change_weather()
	
func load_shop():
	load_map(coffee_shop_scene)

func load_town():
	load_map(town_scene)

func wake_up():
	$CanvasLayer/ColorRect.show()
	$transitions.play("fade_in_from_dark")
	await $transitions.animation_finished
	$CanvasLayer/ColorRect.hide()
	player.input_enabled = true

func enter_building(name):
	player.input_enabled = false
	$CanvasLayer/ColorRect2.show()
	$transitions.play("shrink_to_center")
	await $transitions.animation_finished
	print("Ready to load!")
	match name:
		"coffee-shop":
			load_map(coffee_shop_scene)
		"my-house":
			load_map(my_house_scene)
			get_tree().current_scene.hud.display_text("The start to a new day.")
	print("Done loading!")
	$transitions.play("expand_from_center")
	await $transitions.animation_finished
	$CanvasLayer/ColorRect2.hide()
	player.input_enabled = true

func exit_building(name):  #name = from where
	player.input_enabled = false
	$CanvasLayer/ColorRect2.show()
	$transitions.play("shrink_to_center")
	await $transitions.animation_finished
	load_map(town_scene)
	match name:
		"coffee-shop":
			var spawn : Marker2D = map.get_node("coffee_shop_exit_point")
			player.position = spawn.position
		"my-house":
			var spawn : Marker2D = map.get_node("spawn")
			player.position = spawn.position
	$transitions.play("expand_from_center")
	await $transitions.animation_finished
	$CanvasLayer/ColorRect2.hide()
	player.input_enabled = true
