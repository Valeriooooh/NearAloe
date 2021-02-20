extends Node2D

export(int) var wr = 32
onready var timer = $Timer
onready var startPosition = global_position
onready var targetPosition = global_position

func update_targetPosition():
	var targetVector = Vector2(rand_range(-wr, wr), rand_range(-wr,wr))
	targetPosition = startPosition + targetVector

func start_wander_timer(duration):
    timer.start(duration)
	
func get_time_left():
    return timer.time_left

	
func _on_Timer_timeout():
	update_targetPosition()
	


