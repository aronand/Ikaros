extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	pass


func physics_update(delta: float) -> void:
	character.velocity.y -= Ikaros.gravity * delta
	character.move_and_slide()

	if character.is_on_floor():
		finished.emit(IDLE)
