class_name IkarosCharacterJumpCommand
extends IkarosCharacterBaseCommand


func execute(character: IkarosCharacter, _params: Object = null) -> void:
	character.jump()
