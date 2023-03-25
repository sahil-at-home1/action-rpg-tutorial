extends Entity

const grass_effect_scene: PackedScene = preload("res://scripts_and_scenes/effects/grass_effect.tscn")

func _on_hurtbox_area_entered(_area:Area2D):
	despawn(grass_effect_scene)
