extends IkarosCharacterState


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	character.velocity.y = character.jump_velocity


func physics_update(delta: float) -> void:
	character.move_and_slide()

	if character.velocity.y >= 0:
		finished.emit(FALLING)
