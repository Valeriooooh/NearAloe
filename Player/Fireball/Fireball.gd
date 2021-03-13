extends Area2D

const SPEED = 100
var velocity = Vector2()

func _physics_process(delta: float):
	velocity.x = SPEED * delta
	translate(velocity)


