class_name IkarosCharacter
extends CharacterBody3D

@export var speed: float = 2.5
@export var jump_velocity: float = 4.5

## Controls jumping. When true, the state machine will move to jumping state
## when in a state that can transition to a jump.
var should_jump: bool = false

## Controls movement direction. State machine will move to moving state if this
## is not equal to Vector3.ZERO
var direction: Vector3 = Vector3.ZERO

## Getter for character's current state.
var state: IkarosCharacterState:
	get:
		return _state_machine.state

var _state_machine: IkarosStateMachine


func _enter_tree() -> void:
	add_to_group("characters")


func _exit_tree() -> void:
	remove_from_group("characters")


func _ready() -> void:
	_state_machine = find_child("IkarosStateMachine")


func jump() -> void:
	if state.name in [IkarosCharacterState.FALLING, IkarosCharacterState.JUMPING]:
		return

	should_jump = true


func move(move_direction: Vector3) -> void:
	direction = move_direction
