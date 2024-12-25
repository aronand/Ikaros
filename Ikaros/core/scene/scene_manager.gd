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
	_load_default_scene()


func _process(_delta: float) -> void:
	pass


func _load_default_scene() -> void:
	var scene = default_scene.instantiate()
	add_child(scene)
	scene.owner = self
	scene.init()
	current_scene = scene
