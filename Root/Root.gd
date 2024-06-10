class_name RootNode
extends Node2D

var current_position: Vector2 = Vector2(300, 0)

@export var animated_sprite: AnimatedSprite2D

@onready var game_resolution: Vector2i = Vector2i(
	ProjectSettings.get_setting("display/window/size/viewport_width"),
	ProjectSettings.get_setting("display/window/size/viewport_height"))
@onready var usable_desktop_resolution: Vector2i = DisplayServer.screen_get_usable_rect().size
## X-axis of viewport
@onready var world_bound_x: Vector2i = Vector2i(0, usable_desktop_resolution.x - game_resolution.x)
## Y-axis of viewport
@onready var world_bound_y: Vector2i = Vector2i(0, usable_desktop_resolution.y - game_resolution.y)

func _ready():
	set_spawn_location()
	set_max_fps_base_on_refresh_rate()
	set_transparent_bg()

func _process(delta: float) -> void:
	if (get_window().position.x <= world_bound_x.x - game_resolution.x):
		get_window().position.x += usable_desktop_resolution.x + game_resolution.x
	if (get_window().position.x >= world_bound_x.y + game_resolution.x):
		get_window().position.x -= usable_desktop_resolution.x + game_resolution.x
	$StateMachine.process_frame(delta)

func play_animation(animation_name: String):
	animated_sprite.play(animation_name)

## Checking if the window is currently within the viewport
func is_within_world_bound() -> bool:
	return !(get_window().position.x < world_bound_x.x 
			|| get_window().position.x > world_bound_x.y)

## Set the window flag to enable transparency for background
func set_transparent_bg() -> void:
	get_viewport().set_transparent_background(true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)

## Setting the max fps of the game to refresh rate to avoid jittering and visual tearing
func set_max_fps_base_on_refresh_rate() -> void:
	Engine.set_max_fps(DisplayServer.screen_get_refresh_rate())

## Setting the initial spawn location of the game window
func set_spawn_location() -> void:
	current_position.y = world_bound_y.x - game_resolution.y
	get_window().position = current_position
