extends CharacterBody2D
class_name  Player


var SPEED = 500.0
var ROTATION_SPEED = 2.0
var POWER = 500
var CHARGE_TIME = 2
var HEALTH = 100

var rotation_direction

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("charge"):
		pass 

func _physics_process(delta: float) -> void:
	# Get Player input direction vector
	var direction = Input.get_vector("left", "right", "up", "down")
	#Get roation Vector
	rotation_direction = Input.get_axis("RotateLeft", "RotateRight")
	
	if direction:
		# Velocity is a propety of the player2d node
		# Modify the x and y parts of velocity with direction
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		#If we are not moving, the velcoity should move towards 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	#Adjust roation based on vector
	rotation += rotation_direction * ROTATION_SPEED * delta
	#Move and slide uses velcoity to move our guy
	print(velocity)
	move_and_slide()
