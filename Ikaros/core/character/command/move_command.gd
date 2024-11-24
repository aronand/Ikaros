class_name IkarosCharacterMoveCommand
extends IkarosCharacterBaseCommand


class Params:
	var direction: Vector3

	func _init(direction: Vector3 = Vector3.ZERO) -> void:
		self.direction = direction


func execute(character: IkarosCharacter, params: Object = null) -> void:
	if params is Params:
		params = params as Params
		character.move(params.direction)
