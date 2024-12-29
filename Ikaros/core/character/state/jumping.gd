extends IkarosCharacterState

## The Y coordinate the jump was initiated at. Used to calculate if max jump height is reached.
var _start_y: float

## Defines how quickly the character reaches their jump_velocity.
var _jump_acceleration: float


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	_start_y = character.position.y
	_jump_acceleration = character.jump_velocity * 6
	character.jump_count += 1


func physics_update(delta: float) -> void:
	character.velocity.y = lerp(
		character.velocity.y, character.jump_velocity, _jump_acceleration * delta
	)
	if Ikaros.player_settings.can_move_in_air and character == Ikaros.player:
		character.apply_direction_to_velocity(delta)
	var collided: bool = character.move_and_slide()

	# BUG: This will trigger for _any_ collision, not just collisions overhead
	if collided:
		character.should_jump = false
	elif character.position.y - _start_y >= character.jump_max_height:
		character.should_jump = false

	if not character.should_jump:
		finished.emit(FALLING)
