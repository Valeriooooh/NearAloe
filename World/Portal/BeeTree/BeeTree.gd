extends Area2D

func _ready() -> void:
	if PlayerStats.BossBeeDefeated:
		set_rotation_degrees(90)
		$Portal/CollisionShape2D.set_deferred("disabled",true)

