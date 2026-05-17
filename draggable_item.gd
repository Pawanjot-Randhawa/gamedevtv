extends CharacterBody2D

var is_dragging: bool = false
var is_attached: bool = false
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var bottom_detector: Area2D = $BottomDetector


# For CharacterBody2D, ensure 'input_pickable' is enabled in the Inspector
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if is_attached: return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = event.pressed
		
		if not is_dragging:
			check_for_snap()

func _physics_process(delta: float) -> void:
	
	
	if is_dragging and not is_attached:
		var rotation = Input.is_action_just_pressed("rotate")
		var target_position = get_global_mouse_position()
		if rotation:
			rotation_degrees += 90
		
		# Calculate velocity needed to get to the mouse
		# Multiplying helps it snap faster, adjust '20' to change responsiveness
		velocity = (target_position - global_position) * 20 
		
		# This automatically stops the object when it hits walls/players
		move_and_slide() 
	else:
		velocity = Vector2.ZERO

func check_for_snap() -> void:
	var overlap = bottom_detector.get_overlapping_areas()
	
	if overlap.size()>0:
		snap_to_player(overlap[0])

func snap_to_player(socket: Area2D) -> void:
	is_dragging = false
	is_attached = true
	collision_shape_2d.disabled=true
	
	reparent(socket)
	var tween= create_tween()
	tween.tween_property(self,"position",Vector2.ZERO,0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
