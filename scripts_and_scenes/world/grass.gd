extends Node2D

const grass_effect_scene: PackedScene = preload("res://scripts_and_scenes/effects/grass_effect.tscn")

func create_effect(caller: Node, effect_scene: PackedScene):
	var effect: Node = effect_scene.instantiate()
	caller.get_parent().add_child(effect)
	effect.global_position = caller.global_position
	
func _on_hurtbox_area_entered(_area:Area2D):
	create_effect(self, grass_effect_scene) 
	queue_free()
