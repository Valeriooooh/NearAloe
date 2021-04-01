extends Area2D

export(String) var levelString


func _on_Portal_body_entered(_body) -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(levelString)
