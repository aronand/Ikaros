class_name IkarosCameraController
extends Node

@export_category("Look Sensitivity")
@export var mouse_sensitivity: float = 0.5
@export var joystick_sensitivity: float = 4.0

@export_category("Camera Config")
## Controls camera distance from the camera root.
## Negative values move the camera ahead of the root.
@export var camera_distance: float = 4.0
## Controls camera height.
@export var camera_height: float = 1.5
## Controls camera horizontal position.
@export var camera_horizontal_position: float = 0.0
## Controls how high up the camera can rotate to.
@export var tilt_upper_limit: float = 90.0
## Controls how low down the camera can rotate to.
@export var tilt_lower_limit: float = -90.0

## Camera root node. Acts as the camera arm/holder. Defined when accessed if not yet defined.
var camera_root: Node3D = null:
	get:
		if camera_root == null:
			_create_camera_root()
		return camera_root

## Camera node. Defined when accessed if not yet defined.
var camera: Camera3D = null:
	get:
		if camera_root == null:
			_create_camera_root()  # Creating the camera root also creates the camera.
		return camera

var _logger: LogStream = Ikaros.get_logger("CameraController")
var _rotation_input: float
var _tilt_input: float
var _mouse_rotation: Vector3
var _camera_rotation: Vector3

## Controls camera position. Camera position is automatically adjusted when this value changes.
var _is_first_person: bool = false:
	set(value):
		if value == _is_first_person:
			return

		if value == false:
			_logger.debug("Switching to third person view.")
			camera.position.z = -camera_distance
		else:
			_logger.debug("Switching to first person view.")
			# TODO: Experiment with a small positive value (mimics actual head movement)
			camera.position.z = 0.0
		_is_first_person = value


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouse_motion: InputEventMouseMotion = event as InputEventMouseMotion
		_rotation_input = -mouse_motion.relative.x * mouse_sensitivity
		_tilt_input = -mouse_motion.relative.y * mouse_sensitivity
	elif event is InputEventKey or event is InputEventJoypadButton:
		if Input.is_action_just_pressed("toggle_camera_view"):
			_is_first_person = not _is_first_person


# TODO: This whole setup is a candidate for a new class (IkarosCamera)
func _create_camera_root() -> void:
	_logger.info("Creating camera root and camera.")
	camera_root = Node3D.new()
	camera_root.name = "CameraRoot"
	camera = Camera3D.new()
	camera_root.add_child(camera)
	# Move camera to proper distance from root
	camera.position.z = -camera_distance
	# Move camera to proper horizontal position
	camera.position.x = -camera_horizontal_position
	# Rotate camera to face forward
	camera.rotation_degrees.y = 180.0
	# Move camera root to proper height so the camera isn't underground
	camera_root.position.y = camera_height


func _process(delta: float) -> void:
	var joystick_motion: Vector2 = Input.get_vector(
		"look_left", "look_right", "look_up", "look_down"
	)
	if joystick_motion:
		# TODO: Allow inverting controls via menu
		_rotation_input = -joystick_motion.x * joystick_sensitivity
		_tilt_input = -joystick_motion.y * joystick_sensitivity

	if _rotation_input or _tilt_input:
		handle_camera_rotation(delta)


func handle_camera_rotation(delta: float) -> void:
	_mouse_rotation.y += _rotation_input * delta
	_mouse_rotation.x += -_tilt_input * delta
	_mouse_rotation.x = clamp(
		_mouse_rotation.x, deg_to_rad(tilt_lower_limit), deg_to_rad(tilt_upper_limit)
	)

	# TODO: Instead of manipulating the camera directly, pass the necessary information to it
	# and let it handle the rest. This way we can attach collision checking to it as well
	# to stop if from passing through solid objects.
	_camera_rotation = Vector3(_mouse_rotation.x, _mouse_rotation.y, 0.0)
	camera_root.transform.basis = Basis.from_euler(_camera_rotation)
	camera_root.rotation.z = 0.0

	_rotation_input = 0.0
	_tilt_input = 0.0
