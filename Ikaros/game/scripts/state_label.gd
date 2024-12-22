extends Label

var state_machine: IkarosStateMachine
var state: IkarosCharacterState


func _ready() -> void:
	var parent: IkarosScene = owner as IkarosScene
	state_machine = parent.player.find_child("IkarosStateMachine")


func _process(_delta: float) -> void:
	state = state_machine.state
	text = "State: %s" % state.name
