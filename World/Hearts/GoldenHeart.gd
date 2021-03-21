extends Node2D
var HeartSounds = preload("res://Player/Sounds/GoldenHeartSound.tscn").instance()
func _on_Heart_body_entered(_body):
	get_tree().current_scene.add_child(HeartSounds)
	queue_free()
	
func _on_Heart_area_entered(_body):
	get_tree().current_scene.add_child(HeartSounds)
	queue_free()


func _ready() -> void:
	pass # Replace with function body.
