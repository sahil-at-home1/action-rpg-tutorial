extends Area2D


signal invincibility_started
signal invincibility_ended

const hit_effect_scene: PackedScene = preload("res://scripts_and_scenes/effects/hit_effect.tscn")

@onready var timer: Timer = $Timer
@onready var _is_invincible: bool = false

func _ready():
	timer.timeout.connect(_on_hurtbox_timer_timeout)
	invincibility_started.connect(_on_hurtbox_invincibility_started)
	invincibility_ended.connect(_on_hurtbox_invincibility_ended)

func start_invincibility(duration: float):
	_is_invincible = true 
	timer.start(duration)
	invincibility_started.emit()

func end_invincibility():
	_is_invincible = false
	invincibility_ended.emit()

func _on_hurtbox_timer_timeout():
	end_invincibility()

func _on_hurtbox_invincibility_started():
	# will not register things entereing hurtbox area
	# so it will not emit area_entered signals
	set_deferred("monitoring", false)

func _on_hurtbox_invincibility_ended():
	set_deferred("monitoring", true)

func create_hit_effect():
	# add effect node to parent for position in case this node gets deleted
	var effect: AnimatedSprite2D = hit_effect_scene.instantiate()
	get_parent().add_child(effect)
	effect.animation_finished.connect(effect.queue_free)
	effect.global_position = self.global_position
	effect.offset = Vector2(0, -8)
	effect.frame = 0
	effect.play()




