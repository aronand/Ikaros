class_name IkarosCameraController
extends Node


var camera_root: Node3D


func _ready() -> void:
	assert(get_parent() is IkarosScene)
	camera_root = _create_camera_root()


func _create_camera_root() -> Node3D:
	var camera_root: Node3D = Node3D.new()
	var camera: Camera3D = Camera3D.new()
	camera_root.add_child(camera)
	return camera_root
