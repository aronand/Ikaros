extends Area3D

## A persistent pickup will not get removed upon interaction.
@export var is_persistent: bool = false

## A magnetic pickup will float towards the player when close enough.
@export var is_magnetic: bool = false  # TODO: Implement

## A pickup that requires input behaves like an interactable object,
## with the difference that it requires the player to have also entered
## the pickup's collision shape.
@export var requires_input: bool = false  # TODO: Implement

## Pickup rotates to always face the player if true.
@export var faces_player: bool = false

@onready var _col_shape: CollisionShape3D = find_child("CollisionShape3D") as CollisionShape3D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(_delta: float) -> void:
	if faces_player:
		_col_shape.look_at(Ikaros.player.position)
		_col_shape.rotation.x = 0.0


func _physics_process(_delta: float) -> void:
	if not is_magnetic:
		return
	# TODO: Implement magnetic pickup behaviour


func _on_body_entered(body: Node3D) -> void:
	if body is not IkarosCharacter:
		return

	if body != Ikaros.player:
		return

	Ikaros.score += 1
	if not is_persistent:
		queue_free()
