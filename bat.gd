extends CharacterBody2D

const FRICTION: float = 200 
@onready
var knockback: Vector2 = Vector2.ZERO

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = knockback
	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D):
	knockback = area.knockback_vector * 100
	# queue_free()
