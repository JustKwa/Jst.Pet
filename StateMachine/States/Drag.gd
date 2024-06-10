class_name StateDrag
extends State

enum DraggingState {Dragging, NotDragging}

var is_draggable: bool= false
var state: DraggingState = DraggingState.NotDragging
var mouse_vectors: Array[Vector2] = []

@export var drop_state: StateDrop
@export var area_2d: Area2D

func _ready() -> void:
	area_2d.connect("mouse_entered", _on_mouse_entered)
	area_2d.connect("mouse_exited", _on_mouse_exited)

func enter() -> void:
	root_node.play_animation(animation_name)

func _input(event: InputEvent) -> void:
	if state == DraggingState.Dragging:
		if !(event is InputEventMouseButton):
			return

		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if !(mouse_event.button_index == 1):
			return

		if !(mouse_event.pressed):
			state = DraggingState.NotDragging
			DisplayServer.cursor_set_custom_image(root_node.mouse_open_texture)
			drop_state.set_inertia(mouse_vectors)
			mouse_vectors.clear()
			parent.change_state(drop_state)
		return

	if is_draggable:
		if !(event is InputEventMouseButton):
			return

		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if !(mouse_event.button_index == 1):
			return

		if (mouse_event.pressed):
			state = DraggingState.Dragging
			DisplayServer.cursor_set_custom_image(root_node.mouse_close_texture)
			parent.change_state(self)

func process_frame(_delta: float) -> State:
	get_window().position = DisplayServer.mouse_get_position() - Vector2i(40, 30)
	record_mouse_pos(DisplayServer.mouse_get_position())
	return null

func record_mouse_pos(mouse_pos: Vector2) -> void:
	mouse_vectors.append(mouse_pos)
	if mouse_vectors.size() > 5:
		mouse_vectors.pop_front()

func _on_mouse_entered() -> void:
	is_draggable = true

func _on_mouse_exited() -> void:
	is_draggable = false
