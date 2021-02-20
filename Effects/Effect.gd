extends AnimatedSprite


func _ready():
	# warning-ignore:return_value_discarded
	connect("animation_finished",self, "animation_finished" )
	frame = 0
	play("Animate")

func animation_finished():
	queue_free()
