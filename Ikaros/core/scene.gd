class_name IkarosScene
extends Node


@export var player: IkarosCharacter

var _logger: LogStream


func _init() -> void:
	_logger = Ikaros.get_logger("Scene")


func _ready() -> void:
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

	# Attach a camera to the player
	var camera: Camera3D = Camera3D.new()
	camera.current = true
	player.add_child(camera)

	# Move and rotate camera to proper position
	var camera_position: Node3D = player.find_child("CameraPosition")
	camera.position = camera_position.position
	camera.rotation_degrees.y = 180
