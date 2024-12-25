extends Label

var state_machine: IkarosStateMachine = null:
	get:
		if state_machine == null:
			state_machine = Ikaros.player.find_child("IkarosStateMachine")
		return state_machine


func _process(_delta: float) -> void:
	text = "State: %s" % state_machine.state.name
