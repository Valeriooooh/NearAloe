extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
	}

export var ACCELERATION = 300
export var MAX_SPEED = 50

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
export var FRICTION = 200
var state  = CHASE
onready var stats = $Stats
onready var PlayerDetectionZone = $PlayerDetectionZone
onready var sprite = $Wasp
onready var hurtBox = $Hurtbox
onready var bar = $LifeBar
onready var softCollision = $SoftCollision
onready var wanderController = $WanderControl
onready var animationPlayer = $HurtAnimation
var nameCheck = "enemy"

func _ready() -> void:
	print(stats.MaxHealth)
	print(stats.health)
	bar.visible = false
	bar.max_value = stats.MaxHealth

func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta) 
	knockback = move_and_slide(knockback)
	sprite.flip_h = velocity.x < 0
	bar.value = stats.health

	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			sprite.play("Idle")
			seek_player()
			state_timer()
		WANDER:
			sprite.play("Idle")
			seek_player()
			state_timer()
			var direction = global_position.direction_to(wanderController.targetPosition)
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		CHASE:
			sprite.play("Attack")
			bar.visible = true
			var player = PlayerDetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else: state = IDLE
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)
func seek_player():
	if PlayerDetectionZone.can_see_player():
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

		
func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * FRICTION
	stats.health -= area.damage
	hurtBox.create_hit_effect()
	hurtBox.start_invincibility(0.4)

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position - Vector2(0, 8)

func state_timer():
	if wanderController.get_time_left() == 0:
		state = pick_random_state([IDLE, WANDER])
		wanderController.start_wander_timer(rand_range(1,3))

func _on_Hurtbox_invincibility_ended() -> void:
	animationPlayer.play("Stop")


func _on_Hurtbox_invincibility_started() -> void:
	animationPlayer.play("Start")
