extends Node
#TODO crash leva a save corrompido
#TODO já não crasha mas perde
var save_file_path = "user://save.sav"

func _ready() -> void:
	pass
var node_data
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
	save_file.open(save_file_path, File.READ)
	for node in saved_nodes:
		while save_file.get_position() < save_file.get_len():
			node_data = parse_json(save_file.get_line())
			node.load_save_pos(node_data)
			node.load_save_stats(node_data)
			
