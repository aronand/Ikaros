class_name IkarosCharacter
extends CharacterBody3D

@export var speed: float = 2.5
@export var jump_velocity: float = 4.5

var _state_machine: IkarosStateMachine


func _enter_tree() -> void:
	add_to_group("characters")


func _exit_tree() -> void:
	remove_from_group("characters")


func _ready() -> void:
	_state_machine = find_child("IkarosStateMachine")


func jump() -> void:
	if not is_on_floor():
		return

	var state: IkarosCharacterState = _state_machine.state
	state.finished.emit(IkarosCharacterState.JUMPING)


func move(direction: Vector3) -> void:
	if not is_on_floor():
		return

	var state: IkarosCharacterState = _state_machine.state
	var data: Dictionary = {"direction": direction}
	state.finished.emit(IkarosCharacterState.WALKING, data)
