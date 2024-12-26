extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().current_scene.exit_building("my-house")


#func _on_body_exited(body: Node2D) -> void:
#	pass # Replace with function body.
