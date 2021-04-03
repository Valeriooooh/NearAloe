extends Area2D

export(String) var levelString


func _on_Portal_body_entered(_body) -> void:
# warning-ignore:return_value_discarded
	var canvas = CanvasLayer.new()
	add_child(canvas)
	#	PlayerStats.inDialog = true
	var new_dialog = Dialogic.start(levelString)
	canvas.add_child(new_dialog)
