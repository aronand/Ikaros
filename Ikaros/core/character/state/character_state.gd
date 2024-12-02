class_name IkarosCharacterState
extends IkarosState

const IDLE: String = "idle"
const WALKING: String = "walking"
const JUMPING: String = "jumping"
const FALLING: String = "falling"

var character: IkarosCharacter


func _ready() -> void:
	assert(owner is IkarosCharacter)
	await owner.ready
	character = owner
