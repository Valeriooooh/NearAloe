extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PlayerStats.BossBugDefeated:
		$Portal/CollisionShape2D.set_deferred("disabled",true)
		set_scale(Vector2(1,0.25))
#	if PlayerStats.BossSpikeDefeated:
#		$Ground/SpikeCave/Portal/CollisionShape2D.set_deferred("disabled",true)
#		$Ground/SpikeCave/Sprite.set_scale(0.25,0.25)
