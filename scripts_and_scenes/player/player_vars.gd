extends Node

var collision_map: Dictionary = {}

func _ready():
	for i in range(10):
		var layer_name: String = "layer_" + str(i)
		var temp: Variant = ProjectSettings.get_setting("layer_names/2d_physics/layer_" + str(i))
		if temp:
			layer_name = temp
			collision_map[layer_name] = i
	print(collision_map)
