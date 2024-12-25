class_name IkarosSceneManager
extends IkarosNode

@export var default_scene: PackedScene = null


func _init() -> void:
	pass


func _ready() -> void:
	assert(has_node("IkarosCameraController"))
	assert(has_node("IkarosPlayerController"))
	assert(default_scene != null)


func _process(_delta: float) -> void:
	pass
