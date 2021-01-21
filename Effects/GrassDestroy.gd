extends Node2D


onready var animated_sprite = $AnimatedSprite

func _ready():
	animated_sprite.frame = 0
	animated_sprite.play("Destroy")


func _on_AnimatedSprite_animation_finished():
	queue_free()
