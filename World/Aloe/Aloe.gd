extends Area2D
func _ready() -> void:
	match int(PlayerStats.AloeLeaves):
		1:
			$AnimatedSprite.play("0")
		2: 
			$AnimatedSprite.play("1")
		3:
			$AnimatedSprite.play("2")
		0: 
			$AnimatedSprite.play("0")

	


func _on_Aloe_body_entered(_body: Node) -> void:
	if !PlayerStats.FirstEncounter:
		var canvas = CanvasLayer.new()
		add_child(canvas)
		var new_dialog = Dialogic.start('AloeCall')
		canvas.add_child(new_dialog)

func _on_DialogNode_dialogic_signal(value):
	if value == "is_in_dialog":
		print("dialog")

func _on_InnerAloe_body_entered(_body: Node) -> void:
	if !PlayerStats.FirstEncounter:
		var canvas = CanvasLayer.new()
		add_child(canvas)
		var new_dialog = Dialogic.start('AloeMeet')
		canvas.add_child(new_dialog)
		PlayerStats.FirstEncounter = true
	match int(PlayerStats.AloeLeaves):
		1:
			$AnimatedSprite.play("1")
		2: 
			$AnimatedSprite.play("2")
		3:
			$AnimatedSprite.play("3")
		0: 
			$AnimatedSprite.play("0")
