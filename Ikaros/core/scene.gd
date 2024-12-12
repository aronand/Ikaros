class_name IkarosScene
extends Node

@export var player: IkarosCharacter

var camera_controller: IkarosCameraController

var _logger: LogStream


func _init() -> void:
	_logger = Ikaros.get_logger("Scene")


func _ready() -> void:
	var camera_controller_nodes: Array[Node] = find_children("", "IkarosCameraController")

	if len(camera_controller_nodes) == 0:
		_logger.error("Scene has no IkarosCameraController node.")
		Ikaros.quit()
		return
	# gdlint: ignore=no-else-return
	else:
		# NOTE: This else block seemingly needs to be here, otherwise we won't have
		# the error output when the game exits.
		camera_controller = camera_controller_nodes[0] as IkarosCameraController

	if player == null:
		_logger.warn("Player not defined in scene")
	else:
		Ikaros.player = player
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
	camera_controller.camera_root.set_owner(player)
