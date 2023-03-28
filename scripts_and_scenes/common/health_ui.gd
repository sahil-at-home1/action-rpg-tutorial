extends Label


const MAX_HEARTS = 4

@onready var hearts = 4:
	set(value): 
		hearts = clamp(value, 0, MAX_HEARTS) 
	get:
		return hearts


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
