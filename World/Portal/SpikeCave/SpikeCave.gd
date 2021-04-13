extends Area2D

func _ready() -> void:
	if PlayerStats.BossSpikeDefeated:
		$Portal/CollisionShape2D.set_deferred("disabled",true)
		set_scale(Vector2(0.25,0.25))
