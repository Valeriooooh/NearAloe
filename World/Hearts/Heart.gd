extends Node2D

func _on_Heart_body_entered(_body):
	queue_free()
	
func _on_Heart_area_entered(_body):
	queue_free()


func _ready() -> void:
	pass # Replace with function body.
