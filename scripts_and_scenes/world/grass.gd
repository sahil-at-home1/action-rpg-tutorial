extends Node2D

func create_grass_effect():
	var grass_effect_scene: PackedScene = load("res://scripts_and_scenes/effects/grass_effect.tscn")
	var grass_effect: Node = grass_effect_scene.instantiate()
	var world: Node = get_tree().current_scene
	world.add_child(grass_effect)
	grass_effect.global_position = self.global_position
	
func _on_hurtbox_area_entered(_area:Area2D):
	create_grass_effect()
	queue_free()
