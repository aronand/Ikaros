extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	pass


func physics_update(delta: float) -> void:
	character.apply_direction_to_velocity(delta)
	character.move_and_slide()

	if not character.is_on_floor():
		finished.emit(FALLING)
	elif _character_has_stopped() and character.direction == Vector3.ZERO:
		finished.emit(IDLE)
	elif not _character_has_stopped() and character.direction != Vector3.ZERO:
		finished.emit(WALKING)
	elif character.should_jump:
		finished.emit(JUMPING)


func _character_has_stopped() -> bool:
	return is_equal_approx(character.velocity.x, 0.0) and is_equal_approx(character.velocity.z, 0.0)
