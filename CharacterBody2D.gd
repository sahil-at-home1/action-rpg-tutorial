extends CharacterBody2D

const ACCELERATION: int = 15
const FRICTION: int = 15
const MAX_SPEED: int = 150

@onready
var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):
	var input: Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()

	if input != Vector2.ZERO:
		self.velocity = self.velocity.move_toward(input * MAX_SPEED, ACCELERATION)
		self.velocity.x = clamp(self.velocity.x, -1 * MAX_SPEED, MAX_SPEED)
		self.velocity.y = clamp(self.velocity.y, -1 * MAX_SPEED, MAX_SPEED)
		if velocity.x > 0:
			animation_player.play("run_right")
		elif velocity.x < 0:
			animation_player.play("run_left")
		elif velocity.y < 0:
			animation_player.play("run_up")
		elif velocity.y > 0:
			animation_player.play("run_down")
	else:
		animation_player.play("idle_right")
		self.velocity = self.velocity.move_toward(Vector2.ZERO, FRICTION)

	# move_and_collide(velocity)
	self.move_and_slide()
