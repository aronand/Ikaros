class_name IkarosSceneManager
extends IkarosNode

@export var default_scene: PackedScene = null


func _init() -> void:
	pass


func _ready() -> void:
	assert(has_node("IkarosCameraController"))
	assert(has_node("IkarosPlayerController"))
	assert(default_scene != null)
	var scene = default_scene.instantiate()
	add_child(scene)
	scene.owner = self
	scene.init()


func _process(_delta: float) -> void:
	pass
