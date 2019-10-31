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
	contentLabel.text = DialogueManager.current_node_content
	if DialogueManager.current_node_choices != []:
		# create choices buttons
		
		for choice in DialogueManager.current_node_choices:
			var button = Button.new()
			button.text = choice["name"]
			button.connect("pressed", self, "_on_choice_Button_pressed", [choice["next_id"]])
			$Panel/ButtonList.add_child(button)
		$Panel/Button.hide()
		$Panel/ButtonList.show()
		pass
	else:
		$Panel/Button.show()
		$Panel/ButtonList.hide()

func end_dialogue():
	DialogueManager.current_node_next_node_id = 0 # resets the dialgoue to start from the first node
	self.hide()

func _on_Button_pressed():
	if DialogueManager.current_node_next_node_id == -1:
		end_dialogue()
	else:
		run_dialogue()

func _on_choice_Button_pressed(next_id):
	
	for button in $Panel/ButtonList.get_children():
		button.queue_free()
	
	DialogueManager.current_node_next_node_id = next_id
	if DialogueManager.current_node_next_node_id == -1:
		end_dialogue()
	else:
		run_dialogue()