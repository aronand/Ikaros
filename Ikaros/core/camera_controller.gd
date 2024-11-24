class_name IkarosCameraController
extends Node


var camera_root: Node3D
var camera: Camera3D


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	camera_root = _create_camera_root()


func _create_camera_root() -> Node3D:
	camera_root = Node3D.new()
	camera = Camera3D.new()
	camera_root.add_child(camera)
	return camera_root
