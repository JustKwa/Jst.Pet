class_name StateWalk
extends State

var direction_option: Array = [- 1, 1]
var direction: int

@export var speed: float = 100.0
@export var idle_state: StateIdle

func enter():
	super()
	direction = get_random_direction()
	if direction > 0:
		root_node.animated_sprite.flip_h = false
	elif direction < 0:
		root_node.animated_sprite.flip_h = true

func process_frame(delta: float) -> State:
	super(delta)
	if current_duration >= max_duration:
		return parent.get_transitional_state()

	root_node.play_animation(animation_name)
	get_window().position.x += int(speed * delta) * direction

	return null

func get_random_direction() -> int:
	return direction_option.pick_random()
