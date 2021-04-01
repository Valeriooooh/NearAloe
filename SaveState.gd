extends Node

var save_file_path = "user://save.sav"

func _ready() -> void:
	pass

func save_game():
	var save_file  = File.new()	
	save_file.open(save_file_path, File.WRITE)
	var saved_nodes = get_tree().get_nodes_in_group("Saved")
	

	for node in saved_nodes:
		if node.filename.empty():
			break
		var node_details = node.get_save_stats()
		save_file.store_line(to_json(node_details))

	save_file.close()

func load_game():
	var save_file = File.new()
	if !save_file.file_exists(save_file_path):
		return
	var saved_nodes = get_tree().get_nodes_in_group("Saved")
	for node in saved_nodes:
		node.queue_free()
	save_file.open(save_file_path, File.READ)
	while save_file.get_position() < save_file.get_len():
		var node_data = parse_json(save_file.get_line())
		var new_obj = load(node_data.filename).instance()
		get_node(node_data.parent).call_deferred('add_child',new_obj)
		new_obj.load_save_stats(node_data)
