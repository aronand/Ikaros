class_name IkarosScene
extends IkarosNode

@export var player: IkarosCharacter

var camera_controller: IkarosCameraController

var _logger: LogStream


func _init() -> void:
	_logger = Ikaros.get_logger(get_class_name())


func _ready() -> void:
	var camera_controller_nodes: Array[Node] = find_children("", "IkarosCameraController")
	camera_controller = camera_controller_nodes.front() as IkarosCameraController

	if camera_controller == null:
		_logger.error("Scene has no IkarosCameraController node.")
		Ikaros.quit()
		return

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
