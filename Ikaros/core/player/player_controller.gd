class_name IkarosPlayerController
extends IkarosNode

## Reference to the player collision shape. Null if player is null.
var _col_shape: CollisionShape3D = null:
	get:
		if Ikaros.player == null:
			return null
		if _col_shape == null:
			_col_shape = Ikaros.player.find_child("CollisionShape3D")
		return _col_shape

## Reference to the camera controller.
var _camera_controller: IkarosCameraController  # TODO: Store in Ikaros instead?

## Reference to the camera root node. Null if player is null.
var _camera_root: Node3D = null:
	get:
		if Ikaros.player == null:
			return null
		if _camera_root == null:
			_camera_root = Ikaros.player.find_child("CameraRoot")
		return _camera_root

## Keeps track of movement direction based on user input.
var _direction: Vector3

## Keeps track of movement direction relative to camera rotation.
var _relative_direction: Vector3


func _ready() -> void:
	assert(get_parent() is IkarosSceneManager)
	_camera_controller = get_parent().find_child("IkarosCameraController")


func _process(_delta: float) -> void:
	if Ikaros.player == null:
		return

	# Get a movement direction vector from player input
	var input_dir: Vector2 = get_input_vector()
	_direction = Ikaros.player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	_relative_direction = _direction.rotated(Vector3.UP, _camera_root.rotation.y)

	# HACK: Rotate the player character's collision shape to match with camera node.
	# This will rotate the mesh as well. Cursed af, but works for now.
	# BUG: Player rotates to face camera when switching view. Should be the other way,
	# so we should rotate the camera to match player character orientation.
	if _camera_controller.is_first_person:
		_col_shape.rotation.y = _camera_root.rotation.y

	if not _camera_controller.is_first_person and _direction:
		if Ikaros.player_settings.face_movement_direction:
			_col_shape.look_at(_col_shape.global_transform.origin - _relative_direction)
			_col_shape.rotation.x = 0.0
		else:
			_col_shape.rotation.y = _camera_root.rotation.y

	if _direction:
		Ikaros.player.move(_relative_direction)


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
		Ikaros.player.jump()
		return

	if Input.is_action_just_released("jump"):
		Ikaros.player.should_jump = false
		return


## Verifies that the player is able to jump by checking the current state
## of the player, and settings defined in IkarosPlayerSettings.
func player_can_jump() -> bool:
	if Ikaros.player.jump_count >= Ikaros.player_settings.max_jumps:
		return false

	if Ikaros.player.state.name == IkarosCharacterState.FALLING:
		# Blocks the jump impulse if we've entered the falling state without jumping
		if not Ikaros.player_settings.can_jump_when_falling and Ikaros.player.jump_count == 0:
			return false

	if Ikaros.player.state.name in IkarosCharacter.IN_AIR_STATES:
		if not Ikaros.player_settings.can_multi_jump:
			return false

	return true


## Returns a Vector2 created from movement input. Defaults to returning the input from
## the joypad if it is being used. Note that this may cause false input on a controller
func get_input_vector() -> Vector2:
	var input_vec: Vector2

	# Joypad input
	input_vec = Input.get_vector(
		"move_right_joy", "move_left_joy", "move_backward_joy", "move_forward_joy"
	)

	if input_vec != Vector2.ZERO:
		return input_vec

	# Keyboard input
	return Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
