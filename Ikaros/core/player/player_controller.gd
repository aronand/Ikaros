class_name IkarosPlayerController
extends IkarosNode

var _player: IkarosCharacter

var _col_shape: CollisionShape3D = null:
	get:
		if _player == null:
			return null
		if _col_shape == null:
			_col_shape = _player.find_child("CollisionShape3D")
		return _col_shape

var _camera_controller: IkarosCameraController
var _camera_root: Node3D = null:
	get:
		if _player == null:
			return null
		if _camera_root == null:
			_camera_root = _player.find_child("CameraRoot")
		return _camera_root

var _direction: Vector3
var _relative_direction: Vector3:
	get:
		if _direction != Vector3.ZERO:
			return _direction.rotated(Vector3.UP, _camera_root.rotation.y)
		return Vector3.ZERO


func _init() -> void:
	_player = null


#func _ready() -> void:
	#assert(get_parent() is IkarosScene)
	#var scene: IkarosScene = get_parent()
	#_camera_controller = scene.find_child("IkarosCameraController")
	#_player = scene.player


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
		if Ikaros.player_settings.face_movement_direction:
			# TODO: Janky, make it better
			_col_shape.look_at(_col_shape.global_transform.origin - _relative_direction)
			_col_shape.rotation.x = 0.0
		else:
			_col_shape.rotation.y = _camera_root.rotation.y

	if _direction:
		_player.move(_relative_direction)


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventKey and event is not InputEventJoypadButton:
		return

	if Input.is_action_just_pressed("toggle_camera_view"):
		if not _camera_controller.is_first_person:
			# TODO: Handle rotating camera to match with character rotation.
			pass
		_camera_controller.is_first_person = not _camera_controller.is_first_person
		return

	if Input.is_action_just_pressed("jump") and player_can_jump():
		_player.jump()
		return

	if Input.is_action_just_released("jump"):
		_player.should_jump = false
		return


func player_can_jump() -> bool:
	if _player.jump_count >= Ikaros.player_settings.max_jumps:
		return false

	if _player.state.name == IkarosCharacterState.FALLING:
		# Blocks the jump impulse if we've entered the falling state without jumping
		if not Ikaros.player_settings.can_jump_when_falling and _player.jump_count == 0:
			return false

	if _player.state.name in IkarosCharacter.IN_AIR_STATES:
		if not Ikaros.player_settings.can_multi_jump:
			return false

	return true
