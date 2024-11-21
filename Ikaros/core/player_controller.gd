class_name PlayerController
extends Node


var _player: IkarosCharacter = null

var _move_command := IkarosCharacterMoveCommand.new()


func _process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction: Vector3 = (_player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		var move_params := IkarosCharacterMoveCommand.Params.new()
		move_params.direction = direction
		_move_command.execute(_player, move_params)


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	var scene: IkarosScene = get_parent()
	_player = scene.player
