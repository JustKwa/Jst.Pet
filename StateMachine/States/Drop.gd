class_name StateDrop
extends State

@export var idle_state: StateIdle
@export var gravity: float

func enter() -> void:
	root_node.play_animation(animation_name)

func process_frame(delta: float) -> State:
	get_window().position.y += int(delta * gravity)
	if get_window().position.y >= root_node.world_bound_y.y:
		get_window().position.y = root_node.world_bound_y.y
		return idle_state
	return null
