extends Control

var save_file_path = "user://save.sav"



func _ready() -> void:
	var save_file = File.new()
	if !save_file.file_exists(save_file_path):
		$Continue.disabled = true

func _on_Button_pressed():
	# warning-ignore:return_value_discarded
	get_tree().call_deferred("change_scene", "res://Levels/World.tscn")
#	get_tree().change_scene("res://Levels/World.tscn")
	pass

func _on_Button2_pressed():
#	get_tree().change_scene("res://UI/SettingsScreen/SettingsScreen.tscn")
	get_tree().call_deferred("change_scene", "res://UI/SettingsScreen/SettingsScreen.tscn")

func _on_Button3_pressed():
	get_tree().quit(0)
	pass


func _on_Continue_pressed() -> void:
#	SaveState.load_game()
#	get_tree().call_deferred("change_scene", "res://Levels/WorldContinue.tscn")
	var new_dialog = Dialogic.start('AloeMeet')
	add_child(new_dialog)
