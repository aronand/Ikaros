class_name IkarosCameraController
extends Node


@export var look_sensitivity: float = 0.5

var camera_root: Node3D
var camera: Camera3D

var tilt_lower_limit: float = -90.0
var tilt_upper_limit: float = 90.0

var _rotation_input: float
var _tilt_input: float
var _mouse_rotation: Vector3
var _camera_rotation: Vector3


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	camera_root = _create_camera_root()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouse_motion: InputEventMouseMotion = event as InputEventMouseMotion
		_rotation_input = -mouse_motion.relative.x * look_sensitivity
		_tilt_input = -mouse_motion.relative.y * look_sensitivity


# TODO: This whole setup is a candidate for a new class (IkarosCamera)
func _create_camera_root() -> Node3D:
	camera_root = Node3D.new()
	camera = Camera3D.new()
	camera_root.add_child(camera)
	return camera_root


func _process(delta: float) -> void:
	if _rotation_input or _tilt_input:
		handle_camera_rotation(delta)


func handle_camera_rotation(delta: float) -> void:
	_mouse_rotation.y += _rotation_input * delta
	_mouse_rotation.x += -_tilt_input * delta
	_mouse_rotation.x = clamp(
		_mouse_rotation.x,
		deg_to_rad(tilt_lower_limit),
		deg_to_rad(tilt_upper_limit)
	)

	# TODO: Instead of manipulating the camera directly, pass the necessary information to it
	# and let it handle the rest. This way we can attach collision checking to it as well
	# to stop if from passing through solid objects.
	_camera_rotation = Vector3(_mouse_rotation.x, _mouse_rotation.y, 0.0)
	camera_root.transform.basis = Basis.from_euler(_camera_rotation)
	camera_root.rotation.z = 0.0

	_rotation_input = 0.0
	_tilt_input = 0.0
