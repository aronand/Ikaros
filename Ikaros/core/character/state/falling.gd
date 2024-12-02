extends IkarosCharacterState


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	pass


func physics_update(delta: float) -> void:
	character.velocity.y -= Ikaros.gravity * delta
	character.move_and_slide()

	if character.is_on_floor():
		finished.emit(IDLE)
