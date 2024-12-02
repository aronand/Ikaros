extends IkarosCharacterState


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	character.velocity.x = 0.0
	character.velocity.z = 0.0


func physics_update(delta: float) -> void:
	character.velocity.y -= Ikaros.gravity * delta
	character.move_and_slide()

	if not character.is_on_floor():
		finished.emit(FALLING)
