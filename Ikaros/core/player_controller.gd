class_name PlayerController
extends Node


var _player: IkarosCharacter = null

var _move_command := IkarosCharacterMoveCommand.new()


func _process(delta: float) -> void:
	if Input.is_action_pressed("move_forward"):
		_move_command.execute(_player)


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	var scene: IkarosScene = get_parent()
	_player = scene.player
