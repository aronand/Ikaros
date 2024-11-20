class_name IkarosScene
extends Node


@export var player: IkarosCharacter


func _init() -> void:
	pass


func _ready() -> void:
	if player == null:
		printerr("Player not defined in scene")
