extends Node2D
var HeartSounds = preload("res://Player/Sounds/GoldenHeartSound.tscn").instance()

func _on_Heart_body_entered(_body):
	get_tree().current_scene.add_child(HeartSounds)
	PlayerStats.set_max_health(PlayerStats.MaxHealth +1)
	PlayerStats.set_health(PlayerStats.MaxHealth)
	PlayerStats.set_leaves(PlayerStats.AloeLeaves+1)
	Dialogic.set_variable("Left", str(3 - PlayerStats.AloeLeaves))
	var canvas = CanvasLayer.new()
	add_child(canvas)
	var new_dialog = Dialogic.start("AloeLeaf")
	canvas.add_child(new_dialog)
	$golden/Sprite.set_deferred("visible", false)
	$golden/CollisionShape2D.set_deferred("disabled", true)
	
func _on_Heart_area_entered(_body):
	get_tree().current_scene.add_child(HeartSounds)
	queue_free()


func _ready() -> void:
	pass # Replace with function body.
