extends CharacterBody2D
class_name Player
@onready var camera_2d: Camera2D = $Camera2D

var zoomX: float = 1.0:
	set(value):
		zoomX = clamp(value, 0.5, 1.5)
var zoomY: float = 1.0:
	set(value):
		zoomY = clamp(value, 0.5, 1.5)

var SPEED = 500.0
var ROTATION_SPEED = 2.0
var HEALTH_MAX = 100
var HEALTH = 100:
	set(value):
		HEALTH = clamp(value, 0, HEALTH_MAX)
		Game.player_health_change.emit()
var REGEN_AMOUNT = 10
var rotation_direction

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		zoomX += 0.1
		zoomY += 0.1
		camera_2d.zoom = Vector2(zoomX, zoomY)
	if event.is_action_pressed("zoom_out"):
		zoomX -= 0.1
		zoomY -= 0.1
		camera_2d.zoom = Vector2(zoomX, zoomY)

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
	move_and_slide()

func regen():
	HEALTH += REGEN_AMOUNT

func upgrade(upgrade: String):
	if upgrade == "Movement":
		SPEED += 100
	elif upgrade == "Rotation":
		ROTATION_SPEED += 1
	elif upgrade == "Health":
		HEALTH_MAX += 50
		HEALTH += 50
	elif upgrade == "Regen":
		REGEN_AMOUNT += 10
