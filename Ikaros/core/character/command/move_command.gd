class_name IkarosCharacterMoveCommand
extends IkarosCharacterBaseCommand


func execute(character: IkarosCharacter) -> void:
	character.move(Vector3.FORWARD)
