class_name IkarosPlayerController
extends Node

var _player: IkarosCharacter
var _direction: Vector3

var _jump_command: IkarosCharacterJumpCommand
var _move_command: IkarosCharacterMoveCommand
var _move_params: IkarosCharacterMoveCommand.Params


func _init() -> void:
	_player = null
	_jump_command = IkarosCharacterJumpCommand.new()
	_move_command = IkarosCharacterMoveCommand.new()
	_move_params = IkarosCharacterMoveCommand.Params.new()


func _process(_delta: float) -> void:
	if _player == null:
		return

	var input_dir: Vector2 = Input.get_vector(
		"move_right", "move_left", "move_backward", "move_forward"
	)

	_direction = (_player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).limit_length()
	if _direction:
		# HACK: Rotate the player character's collision shape to match with camera node.
		# This will rotate the mesh as well. Cursed af, but works for now.
		var camera_root: Node3D = _player.find_child("CameraRoot")
		var col_shape: CollisionShape3D = _player.find_child("CollisionShape3D")
		col_shape.rotation.y = camera_root.rotation.y

		var relative_dir: Vector3 = _direction.rotated(Vector3.UP, camera_root.rotation.y)
		_move_params.direction = relative_dir
		_move_command.execute(_player, _move_params)

	if Input.is_action_just_pressed("jump"):
		_jump_command.execute(_player)


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	var scene: IkarosScene = get_parent()
	_player = scene.player
