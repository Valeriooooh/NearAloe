extends Control

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
	get_tree().change_scene("res://UI/TitleScreen/TitleScreen.tscn")

#TODO Save system
