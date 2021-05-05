extends KinematicBody2D


const ACCELERATION = 500
var MAX_SPEED = 70
var ROLL_SPEED = MAX_SPEED * 1.5
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
	$HurtAnimation.play("Stop")
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
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	if Dialogic.get_variable("InDialog") == "1":
		input_vector = Vector2.ZERO
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
		animationState.call_deferred("travel","idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move()
	if Dialogic.get_variable("InDialog") == "0":
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
	


func back_to_run():
	set_deferred("state", MOVE)


func move():
	velocity = move_and_slide(velocity)
	
func die():
	print("dead")
	get_tree().call_deferred("change_scene", "res://UI/DeathScreen/DeathScreen.tscn")
	


func _on_Hurtbox_area_entered(area):
	if area.nameCheck == "enemy":
		stats.health -= area.damage
		hurtBox.start_invincibility(0.5)
		hurtBox.create_hit_effect()
		var PlayerHurtSounds = playerHurtSound.instance()
		get_tree().current_scene.add_child(PlayerHurtSounds)
	elif area.nameCheck == "golden":
		PlayerStats.set_max_health(PlayerStats.MaxHealth +1)
		PlayerStats.set_health(PlayerStats.MaxHealth)
		PlayerStats.AloeLeaves = PlayerStats.AloeLeaves+1
		Dialogic.set_variable("Left", str(3 - PlayerStats.AloeLeaves))
	elif area.nameCheck == "heart":
		if stats.MaxHealth > stats.health:
			stats.health -= area.damage
			hurtBox.start_invincibility(3)
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
		'Story':{
			'AloeFirstEncounter': stats.FirstEncounter,
			'BeeDefeated': stats.BossBeeDefeated,
			'BugDefeated': stats.BossBugDefeated,
			'SpikeDefeated': stats.BossSpikeDefeated,
			'AloeLeaves': stats.AloeLeaves
		},
		'stats':{
		'maxHearts': stats.MaxHealth,
		'Hearts': stats.health
		}
	}

func load_save_stats(save):
	#	stats.MaxHealth = save.stats.maxHearts
	stats.set_deferred("MaxHealth",save.stats.maxHearts)
#	stats.health = save.stats.Hearts
	stats.set_deferred("health", save.stats.Hearts)
#	stats.AloeLeaves = save.Story.AloeLeaves
	stats.set_deferred("AloeLeaves", save.Story.AloeLeaves)
	# stats.FirstEncounter = save.Story.AloeFirstEncouter
	stats.set_deferred("FirstEncounter", save.Story.AloeFirstEncounter)
	# stats.BossBeeDefeated = save.Story.BeeDefeated
	stats.set_deferred("BossBeeDefeated", save.Story.BeeDefeated)
	# stats.BossBugDefeated = save.Story.BugDefeated
	stats.set_deferred("BossBugDefeated", save.Story.BugDefeated)
	# stats.BossSpikeDefeated = save.Story.SpikeDefeated
	stats.set_deferred("BossSpikeDefeated", save.Story.SpikeDefeated)

func load_save_pos(save):
	global_transform.origin = Vector2(save.xpos, save.ypos)
