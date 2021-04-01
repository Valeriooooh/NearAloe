extends Control

func _physics_process(_delta: float) -> void:
	if PlayerStats.InBossLevel:
		$Button2.disabled = true


func _input(event):
	if event.is_action_pressed("pause"):
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state


func _on_Button_pressed():
	var pause_state = not get_tree().paused
	get_tree().paused = pause_state
	visible = pause_state


func _on_Button3_pressed():
	# warning-ignore:return_value_discarded
	get_tree().paused = false
	get_tree().change_scene("res://UI/TitleScreen/TitleScreen.tscn")

#START Save system


func _on_Button2_pressed() -> void:
	SaveState.save_game()
