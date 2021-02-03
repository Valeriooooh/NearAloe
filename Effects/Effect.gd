extends AnimatedSprite

onready var animatedSprite = $AnimatedSprite

func _ready():
	connect("animation_finished",self, "animation_finished" )
	frame = 0
	play("Animate")

func animation_finished():
	queue_free()
