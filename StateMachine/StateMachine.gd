class_name StateMachine
extends Node

var current_state: State

@export var parent: RootNode
@export var available_states: Array[State]
@export var starting_state: State

func _ready():
	for state: State in get_children():
		state.root_node = parent
		state.parent = self
	change_state(starting_state)

func change_state(new_state: State):
	if current_state:
		current_state.exit()

	current_state = new_state

	new_state.enter()

func process_frame(delta) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func get_transitional_state() -> State:
	return available_states.pick_random()
