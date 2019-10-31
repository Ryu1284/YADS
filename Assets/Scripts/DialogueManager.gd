extends Node

var dialoguePath = "res://Assets/Dialogue/"

var nodes = []

var current_node_id = 0
var current_node_name = ""
var current_node_content = ""
var current_node_next_node_id = 0
var current_node_choices = []

# loads the dialogue into an array
func build_dialogue(entityName):
	var file = File.new()
	var filePath = dialoguePath + entityName + ".json"
	if file.file_exists(filePath):
		nodes = []
		file.open(filePath, file.READ)
		var result = parse_json(file.get_as_text())
		nodes = result["nodes"]
		current_node_id = 0
	else:
		print("Dialogue: file open error")
	file.close()

# advances to the next dialogue node
func run_dialgoue():
	if nodes:
		if current_node_id < 0:
			end_dialogue()
		else:
			if !get_node(current_node_next_node_id):
				end_dialogue()
	else:
		print("No nodes were found")

# returns the info associated with the node, if it exists
func get_node(nodeID):
	for node in nodes:
		if (int(node["id"]) == nodeID):
			current_node_id = node["id"]
			current_node_name = node["name"]
			current_node_content = node["content"]
			current_node_next_node_id = node["next_id"]
			current_node_choices = node["choices"]
			return true
	return false

func end_dialogue():
	current_node_id = -1

