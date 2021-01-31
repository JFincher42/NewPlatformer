extends Node

# This whole code implements the subscriber model

# Whenever the score changes
signal score_updated
# Whenever the player dies
signal player_died

# setget allows you to define setters and getters
# setter comes first, getter is optional
var score: = 0 setget set_score #, get_score
var deaths: = 0 setget set_death


# Example - somewhere in code, someone types:
#  PlayerData.score += 1
# THIS DOES NOT UPDATE THE score VARIABLE
# It calls the setter, where you have to set it yourself

func set_score(value: int) -> void:
	score = value
	# To alert listeners that the score has changed
	emit_signal("score_updated")
	return
	
func set_death(value: int) -> void:
	deaths = value
	emit_signal("player_died")

# Reset everything
# This will not call call the setters at all.
func reset() -> void:
	score = 0
	deaths = 0
