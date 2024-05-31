class_name StateDrag
extends State

enum DraggingState {Dragging, NotDragging}

var is_draggable: bool = false
var state: DraggingState = DraggingState.NotDragging

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
            parent.change_state(self)
        else:
            parent.change_state(drop_state)

func process_frame(_delta: float) -> State:
    get_window().position = DisplayServer.mouse_get_position() - Vector2i(40, 51)
    return null

func _on_mouse_entered() -> void:
    is_draggable = true

func _on_mouse_exited() -> void:
    is_draggable = false
