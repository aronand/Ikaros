extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	character.velocity.y = character.jump_velocity
	character.should_jump = false


func physics_update(_delta: float) -> void:
	character.move_and_slide()

	if character.velocity.y >= 0:
		finished.emit(FALLING)
