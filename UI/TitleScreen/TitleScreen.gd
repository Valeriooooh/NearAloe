extends Control



func _on_Button_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/World.tscn")
	pass

func _on_Button2_pressed():
	pass

func _on_Button3_pressed():
	get_tree().quit()
	pass

# func _ready() -> void:
# 	pass # Replace with function body.
