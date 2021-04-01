extends Area2D



func _on_Aloe_body_entered(body: Node) -> void:
	var new_dialog = Dialogic.start('AloeMeet')
	add_child(new_dialog)
