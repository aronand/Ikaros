class_name IkarosScene
extends Node


@export var player: IkarosCharacter


func _init() -> void:
	pass


func _ready() -> void:
	if player == null:
		printerr("Player not defined in scene")
	else:
		attach_camera_to_player()


func attach_camera_to_player() -> void:
	# Attach a camera to the player
	var camera: Camera3D = Camera3D.new()
	camera.current = true
	player.add_child(camera)

	# Move and rotate camera to proper position
	var camera_position: Node3D = player.find_child("CameraPosition")
	camera.position = camera_position.position
	camera.rotation_degrees.y = 180
