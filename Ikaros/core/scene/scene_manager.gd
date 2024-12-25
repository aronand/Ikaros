class_name IkarosSceneManager
extends IkarosNode

@export var default_scene: PackedScene = null

var current_scene: IkarosScene = null


func _init() -> void:
	pass


func _ready() -> void:
	assert(has_node("IkarosCameraController"))
	assert(has_node("IkarosPlayerController"))
	assert(default_scene != null)
	_add_scene(default_scene.instantiate() as IkarosScene)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_1):
		change_map("res://game/levels/test_gym.tscn")


func _add_scene(scene: IkarosScene) -> void:
	add_child(scene)
	scene.owner = self
	scene.init()
	current_scene = scene


func change_map(path: String) -> void:
	var _change_map = func (path: String) -> void:
		remove_child(current_scene)
		current_scene.free()
		var scene: IkarosScene = load(path).instantiate() as IkarosScene
		_add_scene(scene)

	# BUG: scene.init() is sometimes called multiple times
	_change_map.call_deferred(path)
