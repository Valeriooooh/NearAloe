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
	var nodenew
	for node in saved_nodes:
		nodenew = node
		pass
	save_file.open(save_file_path, File.READ)
	while save_file.get_position() < save_file.get_len():
		var node_data = parse_json(save_file.get_line())
#		var new_obj = load(node_data.filename).instance()
#		get_node(node_data.parent).add_child(new_obj)
		nodenew.load_save_pos(node_data)
		nodenew.load_save_stats(node_data)
		if !PlayerStats.wasInGame:
			nodenew.load_save_stats(node_data)
