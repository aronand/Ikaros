## State machine. Based on finite state machine by GDQuest.
class_name IkarosStateMachine
extends Node

@export var initial_state: IkarosState = null

var state: IkarosState = null


func _ready() -> void:
	state = initial_state if initial_state != null else get_child(0)

	for state_node: IkarosState in find_children("*", "IkarosState"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	state.enter("")


func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr("Trying to transition to a state that doesn't exist.")
		return

	var previous_state_path: String = state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)
