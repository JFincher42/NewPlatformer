extends Control

onready var label: Label = $Label

func _ready() -> void:
	# To substitute more than one value, pass them in an array
	label.text = label.text % [PlayerData.score, PlayerData.deaths]
