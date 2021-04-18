extends Control

func _physics_process(_delta: float) -> void:
	if PlayerStats.InBossLevel:
		$Button2.disabled = true


func _input(event):
	if event.is_action_pressed("pause") && int(Dialogic.get_variable("inDialog")) == 0:
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state
		if pause_state:
			Dialogic.set_variable("InDialog",1)
		else:
			Dialogic.set_variable("InDialog",0)


func _on_Button_pressed():
	get_tree().set_pause(false)
	Dialogic.set_variable("InDialog",0)
	visible = false


func _on_Button3_pressed():
	# warning-ignore:return_value_discarded
	get_tree().set_deferred("pause", false)
	get_tree().call_deferred("change_scene","res://UI/TitleScreen/TitleScreen.tscn")
#	get_tree().change_scene("res://UI/TitleScreen/TitleScreen.tscn")

func _on_Button2_pressed() -> void:
	SaveState.save_game()
