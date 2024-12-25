class_name IkarosScene
extends IkarosNode

static var count: int = 0

@export var player: IkarosCharacter

var camera_controller: IkarosCameraController


func init() -> void:
	var camera_controller_nodes: Array[Node] = owner.find_children("", "IkarosCameraController")
	camera_controller = camera_controller_nodes.front() as IkarosCameraController

	if camera_controller == null:
		log_error("Scene has no IkarosCameraController node.")
		Ikaros.quit()
		return

	if player == null:
		log_warning("Player not defined in scene")
	else:
		Ikaros.player = player
		attach_camera_to_player()


func attach_camera_to_player() -> void:
	if player == null:
		log_warning("Couldn't attach camera to player: Player not defined or null in scene.")
		return

	if player.is_queued_for_deletion():
		log_warning("Couldn't attach camera to player: Player queued for free.")
		return

	log_info("Attaching camera to player.")
	count += 1
	print(count)
	player.add_child(camera_controller.camera_root)
	camera_controller.camera_root.set_owner(player)
