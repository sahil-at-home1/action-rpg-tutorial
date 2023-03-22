extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		var world: Node = get_tree().current_scene
		var grass_effect_scene: PackedScene = load("res://GrassEffect.tscn")
		var grass_effect: Node = grass_effect_scene.instantiate()
		grass_effect.global_position = self.global_position
		world.add_child(grass_effect)
		queue_free()
	