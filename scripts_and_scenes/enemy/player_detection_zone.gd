extends Area2D

@onready var player: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_mask_value(PlayerVars.collision_map["player"], true)
	body_entered.connect(_on_player_detection_zone_body_entered)
	body_exited.connect(_on_player_detection_zone_body_exited)

func _on_player_detection_zone_body_entered(body: Node2D):
	player = body

func _on_player_detection_zone_body_exited(_body: Node2D):
	player = null

func can_see_player() -> bool:
	return player != null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
