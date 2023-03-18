extends CharacterBody2D

const ACCELERATION: int = 15
const FRICTION: int = 15
const MAX_SPEED: int = 150

@onready
var animation_tree: AnimationTree = $AnimationTree
@onready
var animation_state = animation_tree.get("parameters/playback")

func _physics_process(_delta):
	var input: Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()

	if input != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input)
		animation_tree.set("parameters/Run/blend_position", input)
		animation_state.travel("Run")
		self.velocity = self.velocity.move_toward(input * MAX_SPEED, ACCELERATION)
		self.velocity.x = clamp(self.velocity.x, -1 * MAX_SPEED, MAX_SPEED)
		self.velocity.y = clamp(self.velocity.y, -1 * MAX_SPEED, MAX_SPEED)
	else:
		animation_state.travel("Idle")
		self.velocity = self.velocity.move_toward(Vector2.ZERO, FRICTION)
		
	self.move_and_slide()
