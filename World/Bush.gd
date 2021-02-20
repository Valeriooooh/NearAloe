extends Node2D


const GrassDestroy = preload("res://Effects/GrassDestroy.tscn")
	
func create_grass_effect():
	var grass_destroy = GrassDestroy.instance()
	get_parent().add_child(grass_destroy)
	grass_destroy.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
