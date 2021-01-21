extends KinematicBody2D

var knockback = Vector2.ZERO
const FRICTION = 150
onready var stats = $Stats

func _ready() -> void:
	print(stats.MaxHealth)
	print(stats.health)

func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta) 
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * FRICTION
	stats.health -= area.damage

func _on_Stats_no_health():
	queue_free()
