extends Area2D

func _on_Aloe_body_entered(_body: Node) -> void:
	if !PlayerStats.FirstEncounter:
		var canvas = CanvasLayer.new()
		add_child(canvas)
	#	PlayerStats.inDialog = true
		var new_dialog = Dialogic.start('AloeMeet')
		canvas.add_child(new_dialog)
		PlayerStats.FirstEncounter = true
	match PlayerStats.AloeLeaves:
		1:
			$AnimatedSprite.play("1")
		2: 
			$AnimatedSprite.play("2")
		3:
			$AnimatedSprite.play("3")


