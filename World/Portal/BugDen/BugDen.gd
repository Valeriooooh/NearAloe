extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var c = 0
	if PlayerStats.BossBugDefeated && c == 0:
		$Portal/CollisionShape2D.set_deferred("disabled",true)
		set_scale(Vector2(1,0.25))
		c = 1
#	if PlayerStats.BossSpikeDefeated:
#		$Ground/SpikeCave/Portal/CollisionShape2D.set_deferred("disabled",true)
#		$Ground/SpikeCave/Sprite.set_scale(0.25,0.25)
