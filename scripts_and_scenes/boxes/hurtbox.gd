extends Area2D

const hit_effect_scene: PackedScene = preload("res://scripts_and_scenes/effects/hit_effect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_hurtbox_area_entered)
	pass # Replace with function body.

func _on_hurtbox_area_entered(_area: Area2D):
	# add effect node to parent before deleting
	var effect: AnimatedSprite2D = hit_effect_scene.instantiate()
	get_parent().add_child(effect)
	queue_free()
	effect.animation_finished.connect(effect.queue_free)
	effect.global_position = self.global_position
	effect.offset = Vector2(0, -8)
	effect.frame = 0
	effect.play()




