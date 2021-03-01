extends Area2D
onready var animation = $AnimatedSprite

# func _on_Bush_area_entered():
# 	animation.play("Collide")
	

func _on_Bush_body_entered(body) -> void:
	animation.play("Collide")
	pass # Replace with function body.


func _on_Bush_body_exited(body) -> void:
	animation.playing = false
	animation.frame = 0

#DONE bush collide animation 
