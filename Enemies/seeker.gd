extends CharacterBody2D

var chase_player: bool = false

@export var speed: float = 150.0
@export var player: CharacterBody2D

func _physics_process(_delta: float) -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			if collision.get_collider().has_method("player"):
				queue_free()
	
	if not self.chase_player: return
	
	var direction = global_position.direction_to(player.global_position);
	self.velocity = direction * self.speed;
	
	self.move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		chase_player = true;
