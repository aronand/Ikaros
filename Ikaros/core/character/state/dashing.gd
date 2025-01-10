extends IkarosCharacterState

var start_position: Vector3
var direction: Vector3


func enter(_previous_state_path: String, data: Dictionary = {}) -> void:
	start_position = character.position
	# TODO: If not moving, dash forward or backward?
	direction = data["direction"]  # Ensures that the direction never changes


func physics_update(_delta: float) -> void:
	character.velocity.x = direction.x * character.dash_velocity
	character.velocity.z = direction.z * character.dash_velocity
	character.move_and_slide()

	if character.position.distance_to(start_position) >= character.dash_distance:
		_enter_state(IDLE)
	# TODO: Turn this into a player setting
	elif not character.is_on_floor():
		_enter_state(FALLING)
	elif character.is_on_wall():
		_enter_state(IDLE)


## Stops dashing and enters the given state.
func _enter_state(state: String) -> void:
	character.should_dash = false
	finished.emit(state)
