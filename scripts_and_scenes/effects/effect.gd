extends AnimatedSprite2D	

func _ready():
	animation_finished.connect(_on_animated_sprite_2d_animation_finished)
	frame = 0
	play()

func _on_animated_sprite_2d_animation_finished():
	queue_free()