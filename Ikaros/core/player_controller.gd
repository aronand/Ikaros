class_name PlayerController
extends Node


var _player: IkarosCharacter = null


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_forward"):
		_player.move(Vector3.ZERO)


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	var scene: IkarosScene = get_parent()
	_player = scene.player
