extends Entity

enum State {
	IDLE,
	WANDER,
	CHASE,
}

const death_effect_scene: PackedScene = preload("res://scripts_and_scenes/effects/bat_death_effect.tscn")

@export var max_speed : float = 70
@export var acceleration: float = 5
@export var friction: float = 5 
@export var soft_collide_coefficient: float = 20 

@onready var sprite: AnimatedSprite2D = $bat_sprite
@onready var knockback: Vector2 = Vector2.ZERO
@onready var hurtbox: Area2D = $Hurtbox
@onready var hitbox: Area2D = $Hitbox
@onready var stats: Node = $Stats
@onready var state: State = State.CHASE
@onready var pdz: Variant = $player_detection_zone
@onready var soft_collision: Area2D = $soft_collision
@onready var wander_controller: Node2D = $wander_controller

func _ready():
	# set movement collisions
	self.set_collision_layer_value(PlayerVars.collision_map["enemy"], true)
	self.set_collision_mask_value(PlayerVars.collision_map["world"], true)
	# hitbox
	hitbox.set_collision_layer_value(PlayerVars.collision_map["enemy_hitbox"], true)
	# hurtbox
	stats.health_depleted.connect(_on_health_depleted)
	hurtbox.set_collision_mask_value(PlayerVars.collision_map["player_hitbox"], true)
	velocity = Vector2.ZERO
	wander_or_idle()

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction)
	if knockback.length() > 0:
		velocity = knockback

	match state:
		State.IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction)
			seek_player()
			if wander_controller.timer_fired():
				wander_or_idle()
		State.WANDER:
			seek_player()
			if wander_controller.timer_fired():
				wander_or_idle()
			move_toward_point(wander_controller.target_position)
			# deal with wobble at the end of wander
			if global_position.distance_squared_to(wander_controller.target_position) <= 1:
				wander_or_idle()
		State.CHASE:
			var player: Node2D = pdz.player
			if player != null:
				move_toward_point(player.global_position)
			else:
				state = State.IDLE
	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() * soft_collide_coefficient 
	move_and_slide()

func move_toward_point(point: Vector2):
	var dir: Vector2 = global_position.direction_to(point) 
	velocity = velocity.move_toward(dir * max_speed, acceleration)
	sprite.flip_h = velocity.x < 0

func wander_or_idle():
	var state_list: Array[State] = [State.WANDER, State.IDLE]
	state_list.shuffle()
	state = state_list[0]
	var time_until_wander: int = randi_range(1, 3)
	wander_controller.set_wander_timer(time_until_wander)

func seek_player():
	if pdz.can_see_player():
		state = State.CHASE

func _on_hurtbox_area_entered(area: Area2D):
	knockback = area.knockback_vector * 100
	hurtbox.start_invincibility(0.1)
	hurtbox.create_hit_effect()
	# godot convention: call down, signal up (on node tree)
	stats.set_health(stats.health - area.damage)

func _on_health_depleted() -> void:
	despawn(death_effect_scene)
