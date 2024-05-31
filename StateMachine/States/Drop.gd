class_name StateDrop
extends State

var inertia: Vector2i = Vector2i.ZERO

@export var idle_state: StateIdle
@export var gravity: float

func enter() -> void:
	root_node.play_animation(animation_name)

func process_frame(delta: float) -> State:
	get_window().position.x -= int(inertia.x * delta)
	get_window().position.y -= int(inertia.y * delta)
	inertia.y -= int(gravity * delta * 1.5)

	if get_window().position.y >= root_node.world_bound_y.y:
		get_window().position.y = root_node.world_bound_y.y
		return idle_state

	return null

func set_inertia(mouse_vectors: Array[Vector2]) -> void:
	inertia = mouse_vectors.front() - mouse_vectors.back()
	if inertia.x < 0:
		root_node.animated_sprite.flip_h = false
	if inertia.x > 0:
		root_node.animated_sprite.flip_h = true
	
