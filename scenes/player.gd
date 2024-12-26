extends CharacterBody2D

enum compass{NORTH, SOUTH, EAST, WEST}
var angle = compass.SOUTH

var speed = 200  # speed in pixels/sec
var action : Node = null
var has_coffee = false
var drank_coffee = false
var idle = true
var input_enabled = false

signal display_text
signal hide_text
signal show_coffee
signal hide_coffee

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.y < 0:
		angle = compass.NORTH
	if velocity.y > 0:
		angle = compass.SOUTH
	if velocity.x > 0:
		angle = compass.EAST
	if velocity.x < 0:
		angle = compass.WEST

		
	match angle:
		compass.NORTH:
			$Sprite.animation = "walk-north"
		compass.SOUTH:
			$Sprite.animation = "walk-south"
		compass.EAST:
			$Sprite.animation = "walk-east"
		compass.WEST:
			$Sprite.animation = "walk-west"
	
	if velocity.length() > 0.95:
		idle = false
		#$Sprite.play($Sprite.animation)
		$AnimationPlayer.play("walk")
	else:
		if idle == false:
			#$AnimationTree/AnimationPlayer.play("idle")
			$AnimationPlayer.stop()
			idle = true
			#$AnimationTree/AnimationPlayer.seek(0.6)
	
	if Input.is_action_just_pressed("interact"):
		if action != null:
			action.interact(self)
		elif has_coffee:
			drink_coffee()
		
	pass
	

func get_input():
	if input_enabled == false:
		velocity = Vector2(0, 0)
		return
	var movement = false
	var ax = 0
	var ay = 0
	if Input.is_action_pressed('movement_right'):
		ax += 1
		movement = true
	if Input.is_action_pressed('movement_left'):
		ax -= 1
		movement = true
	if Input.is_action_pressed('movement_down'):
		ay += 1
		movement = true
	if Input.is_action_pressed('movement_up'):
		ay -= 1
		movement = true
	
	var acceleration = Vector2(ax,ay).normalized() * speed
	
	
	if movement == true:
		velocity = acceleration
	else:
		velocity = velocity * 0.75

func _physics_process(delta):
	get_input()
	move_and_slide()


func add_action(obj : Node, mesg : String):
	display_text.emit(mesg)
	if obj.is_in_group("has_action"):
		action = obj

func remove_action():
	hide_text.emit()
	action = null
	if has_coffee == true:
		display_text.emit("Press space to drink.")

func receive_coffee():
	has_coffee = true
	show_coffee.emit()
	display_text.emit("Press space to drink.")

func drink_coffee():
	$"drink-sounds".play()
	await $"drink-sounds".finished
	has_coffee = false
	drank_coffee = true;
	hide_coffee.emit()
	hide_text.emit()
