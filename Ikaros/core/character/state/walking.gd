extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	pass


func physics_update(delta: float) -> void:
	var direction: Vector3 = character.direction
	character.apply_direction_to_velocity(delta)
	character.move_and_slide()

	if not character.is_on_floor():
		finished.emit(FALLING)
	elif _character_has_stopped() and character.direction == Vector3.ZERO:
		finished.emit(IDLE)
	elif character.should_jump:
		finished.emit(JUMPING)
	elif character.should_dash:
		finished.emit(DASHING, {"direction": direction})


func _character_has_stopped() -> bool:
	return is_equal_approx(character.velocity.x, 0.0) and is_equal_approx(character.velocity.z, 0.0)
