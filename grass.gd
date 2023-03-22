extends Node2D

func create_grass_effect():
	var world: Node = get_tree().current_scene
	var grass_effect_scene: PackedScene = load("res://GrassEffect.tscn")
	var grass_effect: Node = grass_effect_scene.instantiate()
	grass_effect.global_position = self.global_position
	world.add_child(grass_effect)
	
func _on_hurtbox_area_entered(_area:Area2D):
	create_grass_effect()
	queue_free()