tool
extends Area2D

export var next_scene: PackedScene
# The dollar is the same as get_node - the two lines below do the same thing
onready var anim_player: AnimationPlayer = $AnimationPlayer
# onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func _on_body_entered(body: PhysicsBody2D) -> void:
	# Masking means the only thing that can touch us is the player,
	# so no further checking is required yet
	print_debug("Portal touched...")
	teleport()
	
	
func _get_configuration_warning() -> String:
	return "The next scene property cannot be empty." if not next_scene else ""


func teleport() -> void:
	# Play our fade animation
	anim_player.play("fade_in")
	
	# yield() will synchronize an async function, like animation playback
	# We wait on a signal (2nd param) from a node (1st param)
	yield(anim_player, "animation_finished")
	
	# Changing the scene is a scene tree function
	get_tree().change_scene_to(next_scene)
