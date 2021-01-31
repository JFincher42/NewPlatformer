extends "res://src/Actors/Actor.gd"

onready var stomp_area : Area2D = $StompDetector

export var score: = 100

func _ready() -> void:
	# Setup the enemy at the start of the level
	_velocity.x = -speed.x
	# Don't turn on physics until the enemy is visible
	set_physics_process(false)


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	# If the body is lower than the enemy, no stomp
#	if body.global_position.y > get_node("StompDetector").global_position.y:
	if body.global_position.y > stomp_area.global_position.y:
		return
	die()
	
	
func _physics_process(delta: float) -> void:
	# Make it fall
	_velocity.y += gravity * delta
	
	# Needs to change directions when it hits a wall
	if is_on_wall():
		_velocity.x *= -1
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func die() -> void:
	PlayerData.score += score
	queue_free()
