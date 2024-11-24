class_name IkarosScene
extends Node


@export var player: IkarosCharacter

var _logger: LogStream
var camera_controller: IkarosCameraController


func _init() -> void:
	_logger = Ikaros.get_logger("Scene")


func _ready() -> void:
	camera_controller = find_children("", "IkarosCameraController")[0]  # CRITICAL: Major assumption

	if player == null:
		_logger.warn("Player not defined in scene")
	else:
		attach_camera_to_player()


func attach_camera_to_player() -> void:
	if player == null:
		_logger.warn("Couldn't attach camera to player: Player not defined or null in scene.")
		return

	if player.is_queued_for_deletion():
		_logger.warn("Couldn't attach camera to player: Player queued for free.")
		return

	player.add_child(camera_controller.camera_root)

	## Attach a camera to the player
	#var camera: Camera3D = Camera3D.new()
	#camera.current = true
	#player.add_child(camera)
#
	## Move and rotate camera to proper position
	#var camera_root: Node3D = player.find_child("CameraRoot")
	#var camera_position: Node3D = player.find_child("CameraPosition")
	## TODO: Rethink this setup. We could get rid of camera_position by exposing the camera settings
	## in the editor instead.
	#camera.position = camera_position.position
	#camera.position.y = camera_root.position.y
	#camera.rotation_degrees.y = 180
