class_name IkarosScene
extends IkarosNode

@export var player: IkarosCharacter

var camera_controller: IkarosCameraController


func init(camera_controller: IkarosCameraController) -> void:
	self.camera_controller = camera_controller

	if self.camera_controller == null:
		log_error("Scene has no reference to the IkarosCameraController.")
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
	player.add_child(camera_controller.camera_root)
	camera_controller.camera_root.set_owner(player)
