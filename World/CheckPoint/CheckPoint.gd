extends Area2D
	
func _on_CheckPoint_body_entered(_body) -> void:
	SaveState.save_game()
