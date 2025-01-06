extends IkarosCharacterState
# TODO: If moving in a direction, dash in that direction
# TODO: If not moving, dash forward or backward?

var start_position: Vector3
var direction: Vector3


func enter(_previous_state_path: String, data: Dictionary = {}) -> void:
	start_position = character.position
	direction = data["direction"]  # Ensures that the direction never changes


func physics_update(delta: float) -> void:
	character.velocity.x = direction.x * character.dash_velocity
	character.velocity.z = direction.z * character.dash_velocity
	var collided: bool = character.move_and_slide()  # CRITICAL: Will always collide because we are on the ground
	if character.position.distance_to(start_position) >= character.dash_distance:
		character.should_dash = false
		finished.emit(IDLE)
	elif not character.is_on_floor():
		character.should_dash = false
		finished.emit(FALLING)
