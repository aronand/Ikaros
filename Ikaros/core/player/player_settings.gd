class_name IkarosPlayerSettings
extends Resource

## If true, player character will rotate towards movement direction when in third person mode.
## If false, player will strafe instead.
@export var face_movement_direction: bool = true

## If true, player is able to sprint.
@export var can_sprint: bool = true

## If true, player can move in first person mode. Otherwise third person mode
## is entered when movement is initialized.
@export var can_move_in_first_person: bool = true

## If true, player has full control over movement while in the air.
@export var can_move_in_air: bool = true

## If true, player is able to jump in the air even if they entered
## the falling state by walking off a ledge.
@export var can_jump_when_falling: bool = false

## Defines how many times the player can jump consecutively (ground + air jumps).
@export var max_jumps: int = 2

## Getter for max_jumps > 1
var can_multi_jump: bool:
	get:
		return max_jumps > 1
