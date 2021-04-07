extends AnimatedSprite


func _ready():
	# warning-ignore:return_value_discarded
	connect("animation_finished",self, "animation_finished" )
	set_deferred("frame", 0)
	call_deferred("play","Animate")

func animation_finished():
	call_deferred("queue_free")
