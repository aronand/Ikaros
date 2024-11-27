class_name IkarosScene
extends Node


@export var player: IkarosCharacter

var camera_controller: IkarosCameraController

var _logger: LogStream


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

	_logger.info("Attaching camera to player.")
	player.add_child(camera_controller.camera_root)
