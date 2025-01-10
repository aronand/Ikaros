class_name IkarosSceneManager
extends IkarosNode

@export var default_scene: PackedScene = null

var current_scene: IkarosScene = null

var camera_controller: IkarosCameraController:
	get:
		return find_child("IkarosCameraController")


func _init() -> void:
	Ikaros.scene_manager = self


func _ready() -> void:
	assert(has_node("IkarosCameraController"))
	assert(has_node("IkarosPlayerController"))
	assert(default_scene != null)
	_add_scene(default_scene.instantiate() as IkarosScene)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_debug_menu"):
		change_map("res://game/levels/test_gym.tscn")


func _add_scene(scene: IkarosScene) -> void:
	add_child(scene)
	scene.owner = self
	scene.init(camera_controller)
	current_scene = scene


func change_map(path: String) -> void:
	var change_map_lambda = func(path: String) -> void:
		remove_child(current_scene)
		current_scene.free()
		var scene: Resource = load(path)
		_add_scene(scene.instantiate() as IkarosScene)
		camera_controller.reset_rotation_vectors()

	change_map_lambda.call_deferred(path)
