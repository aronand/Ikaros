extends Label

func _process(_delta: float) -> void:
	var parent: IkarosScene = owner as IkarosScene
	var state_machine: IkarosStateMachine = parent.player.find_child("IkarosStateMachine")
	var state: IkarosCharacterState = state_machine.state
	text = "State: %s" % state.name
