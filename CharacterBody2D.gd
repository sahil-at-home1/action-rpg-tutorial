extends CharacterBody2D

const ACCELERATION: int = 50
const FRICTION: int = 50 
const MAX_SPEED: int = 300

func _physics_process(delta):
	var input: Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()

	if input != Vector2.ZERO:
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
		velocity.x = clamp(velocity.x, -1 * MAX_SPEED * delta, MAX_SPEED * delta)
		velocity.y = clamp(velocity.y, -1 * MAX_SPEED * delta, MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_collide(velocity)
