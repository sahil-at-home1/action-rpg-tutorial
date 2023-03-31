extends Area2D


@onready var collision_shape = $CollisionShape2D

func _ready():
	set_collision_layer_value(PlayerVars.collision_map["soft_collisions"], true)
	set_collision_mask_value(PlayerVars.collision_map["soft_collisions"], true)

func is_colliding():
	var areas: Array[Area2D] = get_overlapping_areas()
	return areas.size() > 0

func get_push_vector() -> Vector2:
	var areas: Array[Area2D] = get_overlapping_areas()
	var push_vector: Vector2 = Vector2.ZERO
	if is_colliding():
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized()
	return push_vector