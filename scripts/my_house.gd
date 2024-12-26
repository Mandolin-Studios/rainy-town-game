@tool
extends "res://scenes/buildings/small_house.gd"

# The player's house is different than the others:
#  - Lights are always on.

func _on_doormat_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.drank_coffee == true:
			body.add_action(self, "Press space to go home.")
		else:
			get_tree().current_scene.hud.display_text("You aren't ready yet.")
		

func _on_doormat_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.remove_action()

func interact(player):
	print("Interaction from player to player's house.")
	print(self)
	print(player)
	
	get_tree().current_scene.enter_building("my-house")
