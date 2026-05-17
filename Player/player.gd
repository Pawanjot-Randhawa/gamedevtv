extends CharacterBody2D


const SPEED = 500.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Get Player input direction vector
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		# Velocity is a propety of the player2d node
		# Modify the x and y parts of velocity with direction
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		#If we are not moving, the velcoity should move towards 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	#Move and slide uses velcoity to move our guy
	move_and_slide()
