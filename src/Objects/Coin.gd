extends Area2D

# Get a reference to the animation player
# Shortcut for declaring this in the _on_ready functions
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var score: = 100

func _on_body_entered(body: PhysicsBody2D) -> void:
	PlayerData.score += score
	anim_player.play("fade_out")
