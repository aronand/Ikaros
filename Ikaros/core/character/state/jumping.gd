extends IkarosCharacterState

var _start_y: float


func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	_start_y = character.position.y
	character.velocity.y = character.jump_velocity
	character.should_jump = false


func physics_update(_delta: float) -> void:
	if Ikaros.player_settings.can_move_in_air and character == Ikaros.player:
		character.apply_direction_to_velocity()
	character.move_and_slide()

	# BUG: The jump will not end until the jump_max_height is reached.
	# This means that the jumping state will not exit if the player, for example,
	# bumps into an obstacle that is overhead.
	if character.position.y - _start_y >= character.jump_max_height:
		finished.emit(FALLING)
