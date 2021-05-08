extends Area2D

func _ready() -> void:
	var c = 0
	if PlayerStats.BossSpikeDefeated && c == 0:
		$Portal/CollisionShape2D.set_deferred("disabled",true)
		set_scale(Vector2(0.25,0.25))
		c = 1
