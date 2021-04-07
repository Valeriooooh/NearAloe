extends Node2D


func _ready():
	Dialogic.set_variable("InDialog",0)
	SaveState.load_game()
	print(Dialogic.get_variable("Leafs"))
	PlayerStats.InBossLevel = false
	PlayerStats.wasInGame = true
#	PlayerStats.health = PlayerStats.MaxHealth

func _physics_process(_delta: float) -> void:
	if int(Dialogic.get_variable("InDialog")) == 1:
		get_tree().set_pause(true)
	else:
		get_tree().set_pause(false)
	if PlayerStats.BossBeeDefeated:
		$Ground/BeeTree.set_rotation_degrees(90)
		$Ground/BeeTree/Portal/CollisionShape2D.set_deferred("disabled",true)
	if PlayerStats.BossBugDefeated:
		$Ground/BugDen/Portal/CollisionShape2D.set_deferred("disabled",true)
		$Ground/BugDen/Sprite.set_scale(1,0.25)
	if PlayerStats.BossSpikeDefeated:
		$Ground/SpikeCave/Portal/CollisionShape2D.set_deferred("disabled",true)
		$Ground/SpikeCave/Sprite.set_scale(0.25,0.25)
