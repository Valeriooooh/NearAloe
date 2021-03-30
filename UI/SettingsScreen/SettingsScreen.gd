extends Control

export var TitleScene:PackedScene
export(NodePath) var scrn
onready var Scrn = get_node(scrn)
onready var full = true
onready var vsync = true

func _ready() -> void:
	add_scrn()
	
func add_scrn():
	Scrn.add_item("Fullscreen")
	Scrn.add_item("Windowed")

func _on_Apply_pressed() -> void:
	OS.window_fullscreen = full
	OS.vsync_enabled = vsync

func _on_Back_pressed() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(TitleScene)

func _on_Dropdown_item_selected(index: int) -> void:
	if index == 1:
		full = false
	else: 
		full = true

func _on_Vsync_toggled(button_pressed: bool) -> void:
	vsync = button_pressed
	print("vsync -> " + str(vsync))
