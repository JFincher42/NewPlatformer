extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = $Label
onready var pause_label: Label = $PauseOverlay/Paused

var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		# If you just use paused = not paused, it ignores the setter
		# You can call the setter explicitly, or
		# Use self.paused to force it through the object hierarchy
		self.paused = not paused
		# This prevents other handlers from processing this
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	# The mod operator on strings acts as a format string
	score.text = "Score: %s" % PlayerData.score

func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_label.text = "You Died!"

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

