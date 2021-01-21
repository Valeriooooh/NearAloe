extends Area2D

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _on_bush_area_entered(area):
	animationState.travel("Bush_colide")
				
				
