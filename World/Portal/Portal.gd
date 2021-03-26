extends Area2D

export(String) var levelString = ""


# warning-ignore:unused_argument
func _on_Portal_body_entered(body: Node) -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(levelString)
