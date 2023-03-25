extends CharacterBody2D

const FRICTION: float = 200 
@onready var knockback: Vector2 = Vector2.ZERO
@onready var hurtbox: Area2D = $Hurtbox

func _ready():
	hurtbox.set_collision_layer_value(PlayerVars.collision_map["enemy_hurtbox"], true)
	hurtbox.set_collision_mask_value(PlayerVars.collision_map["player_hitbox"], true)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = knockback
	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D):
	knockback = area.knockback_vector * 100
	# queue_free()
