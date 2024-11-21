class_name IkarosCharacter
extends CharacterBody3D


@export var speed: float = 2.5
@export var jump_velocity: float = 4.5

var _direction: Vector3
var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _enter_tree() -> void:
	add_to_group("characters")


func _exit_tree() -> void:
	remove_from_group("characters")


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y -= _gravity * delta
	
	# Directional movement
	if _direction:
		velocity.x = _direction.x * speed
		velocity.z = _direction.z * speed
		_direction = Vector3.ZERO
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()


func jump() -> void:
	if not is_on_floor():
		return
	
	velocity.y = jump_velocity


func move(direction: Vector3) -> void:
	_direction = direction
