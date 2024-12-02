class_name IkarosCharacterState
extends IkarosState

const IDLE = "idle"
const WALKING = "walking"
const JUMPING = "jumping"
const FALLING = "falling"

var character: IkarosCharacter


func _ready() -> void:
	assert(owner is IkarosCharacter)
	await owner.ready
	character = owner
