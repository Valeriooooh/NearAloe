extends KinematicBody2D


const ACCELERATION = 500
const MAX_SPEED = 70
const ROLL_SPEED = MAX_SPEED * 1.5
const FRICTION = 500
export var DeathScreen:PackedScene 
#const playerHurtSound = preload("res://Player/Sounds/PlayerHurtSound.tscn")
export var playerHurtSound:PackedScene
enum {
	MOVE,
	ROLL,
	ATTACK,
	FIREBALL
	}
	
var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $SwordPivot/SwordHitbox
onready var hurtBox = $Hurtbox
onready var hurtAnimation = $HurtAnimation


func _ready():
	stats.connect("no_health", self, 'die')
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	randomize()

	
func _physics_process(delta):
	match state:
		MOVE:
			call_deferred("move_state",delta)
		ROLL:
			call_deferred("roll_state")
		ATTACK:
			call_deferred("attack_state")
			
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set_deferred("parameters/idle/blend_position", input_vector)
		animationTree.set_deferred("parameters/run/blend_position", input_vector)
		animationTree.set_deferred("parameters/attack/blend_position", input_vector)
		animationTree.set_deferred("parameters/roll/blend_position", input_vector)
		animationState.travel("run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move()
	if Input.is_action_just_pressed("Attack"):
		velocity = Vector2.ZERO
		state = ATTACK
	if Input.is_action_just_pressed("Roll"):
		state = ROLL


func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.call_deferred("travel","roll")
	call_deferred("move")
		


func attack_state():
	velocity = Vector2.ZERO
	animationState.call_deferred("travel","attack")
#	animationState.travel("attack")
	


func back_to_run():
	set_deferred("state", MOVE)


func move():
	velocity = move_and_slide(velocity)
	
func die():
	print("dead")
	# warning-ignore:return_value_discarded
#	get_tree().change_scene("res://Levels/World.tscn")
#	set_deferred("stats:health","stats:MaxHealth")
	stats.health = stats.MaxHealth
#	get_tree().call_deferred("change_scene", "res://UI/DeathScreen/DeathScreen.tscn")
	


func _on_Hurtbox_area_entered(area):
	if area.nameCheck == "enemy":
		stats.health -= area.damage
		hurtBox.start_invincibility(0.5)
		hurtBox.create_hit_effect()
		var PlayerHurtSounds = playerHurtSound.instance()
		get_tree().current_scene.add_child(PlayerHurtSounds)
	elif area.nameCheck == "golden":
		stats.MaxHealth += 1
		stats.health = stats.MaxHealth
		hurtBox.start_invincibility(0.5)
	elif area.nameCheck == "heart":
		if stats.MaxHealth > stats.health:
			stats.health -= area.damage
			hurtBox.start_invincibility(0.5)
	else:
		pass
		

func _on_Hurtbox_invincibility_ended() -> void:
	hurtAnimation.play("Stop")


func _on_Hurtbox_invincibility_started() -> void:
	hurtAnimation.play("Start")


func get_save_stats():
	return {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'xpos' : global_transform.origin.x,
		'ypos' : global_transform.origin.y,
		'stats':{
		'maxHearts': stats.MaxHealth,
		'Hearts': stats.health
		}
	}

func load_save_stats(save):
	global_transform.origin = Vector2(save.xpos, save.ypos)
	stats.MaxHealth = save.stats.maxHearts
	stats.health = save.stats.Hearts
	
#TODO Animação não parece fluida, Braços precisam de ser melhorados a andar
