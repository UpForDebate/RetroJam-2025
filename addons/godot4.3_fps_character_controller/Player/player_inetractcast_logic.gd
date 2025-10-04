extends RayCast3D

@export var Prompt : RichTextLabel

func _physics_process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			if collider.prompt_action == "game_interact":
				# Prompt Logic
				if Prompt.text == collider.get_prompt()+ " ["+collider.get_key()+"]":
					pass
				else:
					Prompt.text = collider.get_prompt()+ " ["+collider.get_key()+"]"
				if Dialogic.current_timeline:
					return
				# Key Pressed Logic
				if Input.is_action_just_pressed(collider.prompt_action):
					if collider._hasDialogue:
						Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
						collider.run_dialogue()
					else:
						collider.interact(owner)
					await collider.finish_interaction
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				Prompt.text = collider.get_prompt()
	else:
		Prompt.text = ""
