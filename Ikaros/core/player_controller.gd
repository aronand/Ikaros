class_name IkarosPlayerController
extends Node


var _player: IkarosCharacter

var _jump_command: IkarosCharacterJumpCommand
var _move_command: IkarosCharacterMoveCommand
var _move_params: IkarosCharacterMoveCommand.Params


func _init() -> void:
	_player = null
	_jump_command = IkarosCharacterJumpCommand.new()
	_move_command = IkarosCharacterMoveCommand.new()
	_move_params = IkarosCharacterMoveCommand.Params.new()


func _process(delta: float) -> void:
	if _player == null:
		return

	var input_dir: Vector2 = Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	var direction: Vector3 = (_player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).limit_length()
	if direction:
		_move_params.direction = direction
		_move_command.execute(_player, _move_params)
	
	if Input.is_action_just_pressed("jump"):
		_jump_command.execute(_player)


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	var scene: IkarosScene = get_parent()
	_player = scene.player
