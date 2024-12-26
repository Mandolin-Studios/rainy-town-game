@tool
extends "res://scenes/buildings/small_house.gd"


func interact(player):
	print("Interaction from player to small house.  Enter")
	print(self)
	print(player)
	$knockSound.play()
	
	print(get_tree().root)
	print(get_tree().current_scene)
	get_tree().current_scene.load_shop()
	
