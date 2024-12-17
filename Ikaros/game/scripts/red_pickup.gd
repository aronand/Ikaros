extends Area3D

@onready var _col_shape: CollisionShape3D = find_child("CollisionShape3D") as CollisionShape3D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(_delta: float) -> void:
	_col_shape.look_at(Ikaros.player.position)
	_col_shape.rotation.x = 0.0


func _on_body_entered(body: Node3D) -> void:
	if body is not IkarosCharacter:
		return

	if body != Ikaros.player:
		return

	Ikaros.score += 1
	queue_free()
