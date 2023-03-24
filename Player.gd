extends CharacterBody2D

const ACCELERATION: int = 15
const FRICTION: int = 15
const MAX_SPEED: int = 150
const ROLL_SPEED: int = 200

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

enum State {
	MOVE,
	ROLL,
	ROLL_SLOWDOWN,
	ATTACK,
}

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

var state: State = State.MOVE
var roll_vector: Vector2 = Vector2.LEFT

func _ready() -> void:
	animation_tree.active = true
	# set up animation roll slowdown method calls
	for direction in Direction:
		var anim_name: String = "roll_" + String(direction).to_lower()
		var roll_anim = $AnimationPlayer.get_animation(anim_name)
		var track_index = roll_anim.add_track(Animation.TYPE_METHOD)
		roll_anim.track_set_path(track_index, ".")
		roll_anim.track_insert_key(track_index, 0.4, {
			"method": "roll_slowdown",
			"args": [],
		}, 0)

func _process(_delta: float) -> void:
	# if self.state == State.ROLL or self.state == State.ROLL_SLOWDOWN:
	# 	print(self.velocity)

	# start in move state
	match state:
		State.MOVE:
			move_state()
		State.ROLL:
			roll_state()
		State.ROLL_SLOWDOWN:
			roll_slowdown()
		State.ATTACK:
			attack_state()

func move_state() -> void:
	var input: Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()

	if input != Vector2.ZERO:
		roll_vector = input # store direction player was facing
		animation_tree.set("parameters/Idle/blend_position", input)
		animation_tree.set("parameters/Run/blend_position", input)
		animation_tree.set("parameters/Attack/blend_position", input)
		animation_tree.set("parameters/Roll/blend_position", input)
		animation_state.travel("Run")
		self.velocity = self.velocity.move_toward(input * MAX_SPEED, ACCELERATION)
		self.velocity.x = clamp(self.velocity.x, -1 * MAX_SPEED, MAX_SPEED)
		self.velocity.y = clamp(self.velocity.y, -1 * MAX_SPEED, MAX_SPEED)
	else:
		animation_state.travel("Idle")
		self.velocity = self.velocity.move_toward(Vector2.ZERO, FRICTION)

	if Input.is_action_just_pressed("attack"):
		state = State.ATTACK
	if Input.is_action_just_pressed("roll"):
		state = State.ROLL

	self.move_and_slide()

func attack_state() -> void:
	animation_state.travel("Attack")

func roll_slowdown() -> void: 
	self.state = State.ROLL_SLOWDOWN
	self.velocity = self.velocity.move_toward(Vector2.ZERO, FRICTION * 2)
	print("slowing!")
	self.move_and_slide()

func roll_state() -> void:
	# self.velocity = self.roll_vector * MAX_SPEED
	self.velocity = self.roll_vector * ROLL_SPEED
	print("rolling!")
	self.move_and_slide()
	animation_state.travel("Roll")

func _on_animation_tree_animation_finished(anim_name):
	if "roll" in anim_name:
		print("stopping!")
		self.velocity = Vector2.ZERO
		state = State.MOVE
	elif "attack" in anim_name:
		state = State.MOVE