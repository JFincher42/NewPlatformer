extends Actor

export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

# Called when it collides with an enemy
func _on_EnemyDetector_body_entered(body: Node) -> void:
	die()


# Is called once per frame
func _physics_process(delta: float) -> void:
	# Checks if the user released the jump key
	# If so, we stop the jump - this allows us to do short jumps
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	if _velocity.x > 0:
		$AnimatedSprite.play("walk_right")
	elif _velocity.x < 0:
		$AnimatedSprite.play("walk_left")
	elif _velocity.x == 0:
		$AnimatedSprite.play("stand")
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

	
func get_direction() -> Vector2:
	# move_right returns a 1.0, while move_left returns -1.0
	# subtracting them gives us a cheap way to figure out what the user is doing
	#
	# We also process the jump, and use is_on_floor to prevent mid-air jumps
	#
	# This gives us a unit vector, which we can multiply out later.
	# 
	# TBD: How to enable double-jumps?
	# TBD: Enable jumping after just leaving a platform
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity:Vector2,	# Current active velocity
		direction: Vector2,			# Direction from user input
		speed: Vector2,				# Raw speed numbers
		is_jump_interrupted: bool	# Are we jumping?
	) -> Vector2:
	
	var out: = linear_velocity
	# Split the processing of horizontal and vertical
	out.x = speed.x * direction.x
	
	# Vertical is more work - first, add the effects of gravity
	out.y += gravity * get_physics_process_delta_time()
	
	# If we just jumped, add that to the mix
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	
	# If the user just let off the jump key, stop moving
	if is_jump_interrupted:
		out.y = 0.0
	
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	
	out.y = -impulse
	return out


func die() -> void:
	PlayerData.deaths += 1
	queue_free()
