extends Node

@export var max_health: int = 1: set = set_max_health
var health: int = 0: set = set_health
		
signal health_depleted
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value: int):
	max_health = value
	# make sure current health is higher than max health
	health = min(health, max_health)
	max_health_changed.emit(max_health)
	print("emitting max health signal to " + str(max_health))

func set_health(value: int) -> void:
	health = value
	health_changed.emit(health)
	if health <= 0:
		health_depleted.emit()

func _ready():
	health = max_health
