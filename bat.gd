extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(_delta):
	pass


func _on_hurtbox_area_entered(_area:Area2D):
	queue_free()
