extends Node

@export var max_health: int = 1
@onready var health: int = max_health: 
	get = get_health, set = set_health
		
signal health_depleted

func get_health() -> int:
	return health

func set_health(value: int) -> void:
	health = value
	if health <= 0:
		health_depleted.emit()

func _ready():
	pass
