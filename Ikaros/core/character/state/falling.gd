extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	pass


func physics_update(delta: float) -> void:
	character.velocity.y -= Ikaros.gravity * delta
	character.move_and_slide()

	# CRITICAL: A problem here is that if a character is assignated as the player,
	# we might actually have input ready for movement and should transition to
	# a movement state instead of idle.
	if character.is_on_floor():
		finished.emit(IDLE)
