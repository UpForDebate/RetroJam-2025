class_name Interactable extends Node

signal interacted()
signal finish_interaction()

@export_subgroup("Dialogue")
@export var dialogue : DialogicTimeline

@export_category("Prompt Settings")
@export_enum(
	"game_interact",
	"text",
	) var prompt_action : String = "game_interact"
@export_multiline var prompt_message : String = "Interact"
@export var prompt_key_override : bool = false
@export_multiline var override_text : String = ""

@export var _hasDialogue : bool = false

var _dialogue_index : int = 1

func _ready() -> void:
	pass

func get_key() -> String:
	var key_name = ""
	if prompt_key_override:
		return override_text
	else:
		for action in InputMap.action_get_events(prompt_action):
			if action is InputEventKey:
				key_name = action.as_text_physical_keycode()
				break
	return key_name

func get_prompt() -> String:
	return prompt_message

func interact(body) -> void:
	interacted.emit()
	finish_interaction.emit()

func run_dialogue() -> void:
	Dialogic.start_timeline(dialogue)
	await Dialogic.timeline_ended
	finish_interaction.emit()
