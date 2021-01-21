extends Node2D


func create_grass_effect():
    var GrassDestroy = load("res://Effects/GrassDestroy.tscn")
    var grass_destroy = GrassDestroy.instance()
    var main = get_tree().current_scene
    main.add_child(grass_destroy)
    grass_destroy.global_position = global_position

func _on_Hurtbox_area_entered(area):
    create_grass_effect()
    queue_free()
