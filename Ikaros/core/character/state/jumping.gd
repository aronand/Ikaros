extends IkarosCharacterState


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	character.velocity.y = character.jump_velocity
	character.jump_count += 1
	character.should_jump = false


func physics_update(delta: float) -> void:
	if Ikaros.player_settings.can_move_in_air and character == Ikaros.player:
		character.apply_direction_to_velocity(delta)
	var collided: bool = character.move_and_slide()
	finished.emit(FALLING)
