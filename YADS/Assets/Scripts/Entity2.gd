extends Node2D

var entityName = "Entity2"
var activeEntity = false
onready var dialogueUI = get_parent().find_node("DialogueUI")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()

func get_input():
	
	if Input.is_action_just_pressed("ui_mouse_0"):
		if activeEntity:
			dialogueUI.start_dialogue(entityName)


func _on_Area2D_mouse_entered():
	activeEntity = true


func _on_Area2D_mouse_exited():
	activeEntity = false
