class_name Entity extends CharacterBody2D

func despawn(effect_scene: PackedScene):
	# add effect node to parent before deleting
	var effect: Node = effect_scene.instantiate()
	get_parent().add_child(effect)
	queue_free()
	# play animation and delete the effect
	# note: since we free ourself before effect, we cannot receive a 
	# signal from it. This is why the free the effect must be called
	# from the effect itself
	effect.animation_finished.connect(effect.queue_free)
	effect.global_position = self.global_position
	effect.frame = 0
	effect.play()
