class_name IkarosCharacter
extends CharacterBody3D


@export var speed: float = 2.5

var _direction: Vector3


func _enter_tree() -> void:
	add_to_group("characters")


func _exit_tree() -> void:
	remove_from_group("characters")


func _physics_process(delta: float) -> void:
	if _direction:
		velocity.x = _direction.x * speed
		velocity.z = _direction.z * speed
		_direction = Vector3.ZERO
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()


func move(direction: Vector3) -> void:
	_direction = direction
