@tool
extends Control

# COLLIDER: Woks as a "Tool" in the Godot Editor.
# If you resize the CollisionShape2D, the collider changes,
# this way you can easily place the collider where you want on the map.

@export var weatherType = 'sun' # (String, 'clear', 'rain', 'snow')
@export var wind = 0 # (float, -1, 1)
@export var size = 0.3 # (float, 0, 1)
@export var amount = 1500 # (int, 100, 3000)
@export var setLight: bool = false
@export var light = 1 # (float, 0, 1)
@export var lightChangeTime = 2 # (float, 1, 10)
@export var delayWeatherChange: bool = true # Wait light change before changing weather
@export var weatherChangeTime = 2 # (float, 1, 300)

@export var weatherNode: NodePath = "../Weather"

@onready var weather: Node2D = get_node(weatherNode)
@onready var collisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	_control_Area2D_shape(collisionShape2D)

func _process(delta: float) -> void:
	changeCollisionShapeTool()
	
func changeCollisionShapeTool() -> void:
	if Engine.is_editor_hint(): # Only works in "Editor", not during the game...
		var collisionShape2D = $Area2D/CollisionShape2D # UNNECESARY... already defined
		_control_Area2D_shape(collisionShape2D)

func changeWeather() -> void:
	# print_debug("CHANGE WEATHER!!")
	if weather.last_control != self:
		weather.last_control = self
		weather.weatherType = weatherType
		weather.wind = wind
		weather.size = size
		weather.amount = amount
		weather.lightChangeTime = lightChangeTime
		weather.delayWeatherChange = delayWeatherChange
		weather.weatherChangeTime = weatherChangeTime
		
		if setLight == true: weather.light = light
		
		weather.change_weather()

func _on_Area2D_body_entered(body: Node) -> void:
	changeWeather()

func _control_Area2D_shape(weather_shape) -> void:
		weather_shape.position = size / 2
		
		# MAKES EVERY INSTANCE SHAPE UNIQUE to follow individual "Control" node shape...
		weather_shape.shape = RectangleShape2D.new()
		weather_shape.shape.extents = size / 2
		# print_debug("Shape: ", collisionShape2D.shape.extents, " Rect: ", rect.rect_size)
