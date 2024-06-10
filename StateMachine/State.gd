class_name State
extends Node

var root_node: RootNode = null
var parent: StateMachine = null
var max_duration: float
var current_duration: float

@export var animation_name: String
@export var state_duration_range: Vector2

func _init():
	return

func enter() -> void:
	root_node.play_animation(animation_name)
	max_duration = randf_range(
		state_duration_range.x,
		state_duration_range.y
	)
	current_duration = .0

func exit() -> void:
	return

func process_frame(delta: float) -> State:
	current_duration += delta
	if current_duration >= max_duration:
		return parent.get_transitional_state()
	return null
