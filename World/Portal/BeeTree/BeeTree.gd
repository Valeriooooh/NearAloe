extends Area2D


func _physics_process(_delta):
	var c = 0
	if PlayerStats.BossBeeDefeated && c == 0:
		set_rotation_degrees(90)
		$Portal/CollisionShape2D.set_deferred("disabled",true)
		c = 1

