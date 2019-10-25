extends Control

onready var nameLabel = $Panel/EntityNameLabel
onready var contentLabel = $Panel/ContentLabel

func start_dialogue(entityName):
	DialogueManager.build_dialogue(entityName)
	run_dialogue()
	self.show()
	pass

func run_dialogue():
	DialogueManager.run_dialgoue()
	nameLabel.text = DialogueManager.current_node_name
	contentLabel.text = DialogueManager.current_node_conent

func end_dialogue():
	DialogueManager.current_node_next_node_id = 0 # resets the dialgoue to start from the first node
	self.hide()

func _on_Button_pressed():
	if DialogueManager.current_node_next_node_id == -1:
		end_dialogue()
	else:
		run_dialogue()
