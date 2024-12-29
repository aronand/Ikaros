class_name IkarosCharacter
extends CharacterBody3D

## States that signify that the character is currently in the air.
## Useful when trying to block actions while in the air, for example.
const IN_AIR_STATES: Array[String] = [
	IkarosCharacterState.FALLING,
	IkarosCharacterState.JUMPING,
]

## Character's movement speed
@export var speed: float = 2.5

## Character's jump speed
@export var jump_velocity: float = 4.0

## Character's maximum jump height
@export var jump_max_height: float = 0.5

## Controls jumping. When true, the state machine will move to jumping state
## when in a state that can transition to a jump.
var should_jump: bool = false

## Tracks how many times the player has jumped before touching the ground again.
## Sets itself back to 0 when accessed while on the ground.
var jump_count: int = 0:
	get:
		if is_on_floor():
			jump_count = 0
		return jump_count

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
	# NOTE: Player specific check can be found from IkarosPlayerController
	if state.name in IN_AIR_STATES and not self == Ikaros.player:
		return
	should_jump = true


func move(move_direction: Vector3) -> void:
	direction = move_direction


## Applies direction to velocity. This method should only be called from
## within the state machine.
func apply_direction_to_velocity(_delta: float) -> void:
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	direction = Vector3.ZERO
