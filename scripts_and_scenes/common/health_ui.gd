extends Control


@onready var max_hearts_ui = 4: set=set_max_hearts
@onready var hearts_ui = 4: set=set_hearts
@onready var player_stats: Node = get_node("/root/World/y-sort node/not-grass/Player/player_stats")
@onready var label: Label = $Label
@onready var heart_ui_empty: TextureRect = $heart_ui_empty
@onready var heart_ui_full: TextureRect = $heart_ui_full


func set_hearts(value: int):
	# if label != null:
	# 	label.text = "HP = %s" % str(hearts)
	hearts_ui = clamp(value, 0, max_hearts_ui) 
	var heart_full_size: Vector2 = heart_ui_full.texture.get_size()
	if heart_ui_full != null:
		heart_ui_full.size.x = hearts_ui * heart_full_size.x

func set_max_hearts(value: int):
	max_hearts_ui = max(1, value)
	var heart_empty_size: Vector2 = heart_ui_empty.texture.get_size()
	if heart_ui_empty != null:
		heart_ui_empty.size.x = max_hearts_ui * heart_empty_size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	player_stats.health_changed.connect(set_hearts)
	player_stats.max_health_changed.connect(set_max_hearts)
	max_hearts_ui = player_stats.max_health
	hearts_ui = player_stats.health
	# make it so the hearts can have a size of 0
	heart_ui_full.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	# label.text = "HP = %s" % str(max_hearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
