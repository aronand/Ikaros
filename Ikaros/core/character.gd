class_name IkarosCharacter
extends CharacterBody3D


func _enter_tree() -> void:
	add_to_group("characters")


func _exit_tree() -> void:
	remove_from_group("characters")


func move(direction: Vector3) -> void:
	print("Moving")
