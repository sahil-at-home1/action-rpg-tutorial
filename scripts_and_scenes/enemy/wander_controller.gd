extends Node2D

@export var wander_range: int = 16

@onready var timer: Timer = $Timer
@onready var start_position: Vector2 = global_position
@onready var target_position: Vector2 = global_position
@onready var fired: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)

func update_target_position():
	var rand_x: int = randi_range(-wander_range, wander_range)
	var rand_y: int = randi_range(-wander_range, wander_range)
	var target_vector = Vector2(rand_x, rand_y)
	target_position = start_position + target_vector

func _on_timer_timeout():
	print(get_parent().name, " wander timeout")
	fired = true
	update_target_position()

func get_time_left() -> float:
	return timer.time_left

func timer_fired() -> bool:
	return fired

func set_wander_timer(duration: int):
	fired = false
	timer.start(duration)
