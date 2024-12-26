extends Area2D

enum {before, during, after}

var mode = before

func interact(player):
	print("Interaction from player to coffee counter.")
	if mode == before:
		player.remove_action()
		mode = during
		$"../sygen_anim".play("make_coffee")
		await $"../sygen_anim".animation_finished
		get_tree().current_scene.hud.display_text("Your coffee's ready!")
		mode = after
		return
	
	if mode == during:
		player.remove_action()
		get_tree().current_scene.hud.display_text("It'll be ready soon.")
		pass
	
	if mode == after:
		player.remove_action()
		mode = during
		$"../sygen_anim".play("receive_coffee")
		await $"../sygen_anim".animation_finished
		get_tree().current_scene.hud.display_text("Thank you for your service!")
		player.receive_coffee()
		mode = before
	
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		match mode:
			before:
				body.add_action(self, "Press space to order some coffee.")
			during:
				body.add_action(self, "...")
			after:
				body.add_action(self, "Press space to receive your coffee")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.remove_action()
