extends CharacterBody2D

const ACCELERATION: int = 25
const FRICTION: int = 25 
const MAX_SPEED: int = 200

func _physics_process(delta):
	var input: Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()

	if input != Vector2.ZERO:
		velocity += input * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -1 * MAX_SPEED * delta, MAX_SPEED * delta)
		velocity.y = clamp(velocity.y, -1 * MAX_SPEED * delta, MAX_SPEED * delta)
		# velocity.x = clamp(velocity.x, 0, MAX_SPEED * delta)
		# velocity.y = clamp(velocity.y, 0, MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		# velocity = Vector2.ZERO

	print(velocity)
	move_and_collide(velocity)
