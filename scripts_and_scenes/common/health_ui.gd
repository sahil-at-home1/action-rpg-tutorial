extends Control


@onready var max_hearts = 4: set=set_max_hearts
@onready var hearts = 4: set=set_hearts

func set_max_hearts(value):
	max_hearts = max(1, value)

func set_hearts(value: int):
	hearts = clamp(value, 0, max_hearts) 
	if label != null:
		label.text = "HP = %s" % str(hearts)

@onready var player_stats: Node = get_node("../y-sort node/not-grass/Player/player_stats")
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	player_stats.health_changed.connect(set_hearts)
	max_hearts = player_stats.max_health
	hearts = player_stats.health
	label.text = "HP = %s" % str(max_hearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
