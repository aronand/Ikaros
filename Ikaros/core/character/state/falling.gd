extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	pass


func physics_update(delta: float) -> void:
	if Ikaros.player_settings.can_move_in_air and character == Ikaros.player:
		character.apply_direction_to_velocity(delta)
	character.velocity.y -= Ikaros.gravity * delta
	character.move_and_slide()

	if character.is_on_floor():
		character.jump_count = 0
		if character.direction == Vector3.ZERO:
			finished.emit(IDLE)
		else:
			finished.emit(WALKING)

	# Player specific functionality below this line
	if character != Ikaros.player:
		return

	# Double jumping
	if character.should_jump and Ikaros.player_settings.can_multi_jump:
		if character.jump_count < Ikaros.player_settings.max_jumps:
			finished.emit(JUMPING)
