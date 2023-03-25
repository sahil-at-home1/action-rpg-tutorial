extends Area2D

@onready var knockback_vector = Vector2.ZERO

func _ready():
	# set up collision layer and masks
	self.set_collision_layer_value(PlayerVars.collision_map["player_hitbox"], true)