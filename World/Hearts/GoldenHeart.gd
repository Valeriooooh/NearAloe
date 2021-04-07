extends Node2D
var HeartSounds = preload("res://Player/Sounds/GoldenHeartSound.tscn").instance()

func _on_Heart_body_entered(_body):
	get_tree().current_scene.add_child(HeartSounds)
	
	var canvas = CanvasLayer.new()
	add_child(canvas)
	var new_dialog = Dialogic.start("AloeLeaf")
	canvas.add_child(new_dialog)
	$golden/Sprite.set_deferred("visible", false)
	$golden/CollisionShape2D.set_deferred("disabled", true)
	Dialogic.set_variable("Leafs",PlayerStats.AloeLeaves)
	
func _on_Heart_area_entered(_body):
	get_tree().current_scene.add_child(HeartSounds)
	queue_free()


func _ready() -> void:
	pass # Replace with function body.
