extends Area2D

func _on_body_exited(body: Node2D) -> void:
	get_tree().current_scene.hud.display_text("You can't leave yet.")


func _on_body_entered(body: Node2D) -> void:
	get_tree().current_scene.hud.hide_text()
