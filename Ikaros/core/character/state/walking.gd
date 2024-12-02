extends IkarosCharacterState

var _direction: Vector3


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	_direction = data.get("direction", Vector3.ZERO)


func physics_update(delta: float) -> void:
	character.velocity.x = _direction.x * character.speed
	character.velocity.z = _direction.z * character.speed
	character.move_and_slide()
	_direction = Vector3.ZERO

	if not character.is_on_floor():
		finished.emit(FALLING)
	elif is_equal_approx(_direction.x, 0.0) and is_equal_approx(_direction.y, 0.0):
		finished.emit(IDLE)
