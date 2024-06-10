class_name StateFloop
extends State

@export
var idle_state: StateIdle

func enter() -> void:
	root_node.play_animation(animation_name)
	max_duration = 1.0
	current_duration = .0

func process_frame(delta: float) -> State:
	current_duration += delta
	if current_duration >= max_duration:
		return idle_state
	return null
