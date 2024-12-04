extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	pass


func physics_update(delta: float) -> void:
	if Ikaros.player_can_move_in_air and character == Ikaros.player:
		character.handle_move()
	character.velocity.y -= Ikaros.gravity * delta
	character.move_and_slide()

	if character.is_on_floor() and character.direction == Vector3.ZERO:
		finished.emit(IDLE)
	elif character.is_on_floor() and character.direction != Vector3.ZERO:
		finished.emit(WALKING)
