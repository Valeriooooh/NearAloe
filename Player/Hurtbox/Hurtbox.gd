extends Area2D

#const HitEffect = preload("res://Effects/EnemyHitEffect.tscn")
export var HitEffect:PackedScene 
var invincible = false setget set_invincible
onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
#	main.add_child(effect)
	main.call_deferred("add_child",effect)
	effect.global_position = global_position


signal invincibility_started
signal invincibility_ended
	
func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)


func _on_Timer_timeout() -> void:
	self.set_deferred("invincible",false)


func _on_Hurtbox_invincibility_ended() -> void:
#	collisionShape.set_deferred("disabled", false)
	collisionShape.call_deferred("set_disabled", false)


func _on_Hurtbox_invincibility_started() -> void:
#	collisionShape.set_deferred("disabled", true)
	collisionShape.call_deferred("set_disabled", true)
	
