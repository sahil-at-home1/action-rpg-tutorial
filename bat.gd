extends CharacterBody2D

const FRICTION: float = 200 
@onready var knockback: Vector2 = Vector2.ZERO
@onready var hurtbox: Area2D = $Hurtbox
@onready var stats: Node = $Stats

func _ready():
	stats.health_depleted.connect(_on_health_depleted)
	hurtbox.set_collision_layer_value(PlayerVars.collision_map["enemy_hurtbox"], true)
	hurtbox.set_collision_mask_value(PlayerVars.collision_map["player_hitbox"], true)
	print(stats.max_health)
	print(stats.health)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = knockback
	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D):
	knockback = area.knockback_vector * 100
	# godot convention: call down, signal up (on node tree)
	stats.set_health(stats.health - 1)

func _on_health_depleted() -> void:
	print("health depleted!")
	queue_free()
