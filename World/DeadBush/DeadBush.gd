extends Area2D
onready var animation = $AnimatedSprite

var nameCheck = "bush"
	

func _on_Bush_body_entered(_body) -> void:
	animation.play("Collide")
	pass # Replace with function body.


func _on_Bush_body_exited(_body) -> void:
	animation.playing = false
	animation.frame = 0
