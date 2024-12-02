class_name IkarosPlayerController
extends Node

var _player: IkarosCharacter
var _direction: Vector3

var _camera_controller: IkarosCameraController

var _camera_root: Node3D = null:
	get:
		if _player == null:
			return null
		if _camera_root == null:
			_camera_root = _player.find_child("CameraRoot")
		return _camera_root

var _col_shape: CollisionShape3D = null:
	get:
		if _player == null:
			return null
		if _col_shape == null:
			_col_shape = _player.find_child("CollisionShape3D")
		return _col_shape


func _init() -> void:
	_player = null


func _process(_delta: float) -> void:
	if _player == null:
		return

	var input_dir: Vector2 = Input.get_vector(
		"move_right", "move_left", "move_backward", "move_forward"
	)

	_direction = (_player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).limit_length()

	# HACK: Rotate the player character's collision shape to match with camera node.
	# This will rotate the mesh as well. Cursed af, but works for now.
	# BUG: Player rotates to face camera when switching view. Should be the other way,
	# so we should rotate the camera to match player character orientation.
	if _camera_controller.is_first_person:
		_col_shape.rotation.y = _camera_root.rotation.y

	if not _camera_controller.is_first_person and _direction:
		_col_shape.rotation.y = _camera_root.rotation.y

	if _direction:
		var relative_dir: Vector3 = _direction.rotated(Vector3.UP, _camera_root.rotation.y)
		_player.move(relative_dir)

	if Input.is_action_just_pressed("jump"):
		_player.jump()


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	var scene: IkarosScene = get_parent()
	_camera_controller = scene.find_child("IkarosCameraController")
	_player = scene.player


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventJoypadButton:
		if Input.is_action_just_pressed("toggle_camera_view"):
			if not _camera_controller.is_first_person:
				# TODO: Handle rotating camera to match with character rotation.
				pass
			_camera_controller.is_first_person = not _camera_controller.is_first_person
