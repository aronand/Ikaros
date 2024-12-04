extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	character.velocity.x = 0.0
	character.velocity.z = 0.0


func physics_update(delta: float) -> void:
	character.velocity.y -= Ikaros.gravity * delta
	character.move_and_slide()

	if not character.is_on_floor():
		finished.emit(FALLING)
	elif character.should_jump:
		finished.emit(JUMPING)
	elif character.direction != Vector3.ZERO:
		finished.emit(WALKING)
