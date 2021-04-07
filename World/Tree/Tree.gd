extends StaticBody2D


func _ready() -> void:
	set_process(true)
	$AnimationPlayer.play("Idle")

func _process(_delta: float) -> void:
	if $VisibilityNotifier2D.is_on_screen():
		$AnimationPlayer.play("Move")
