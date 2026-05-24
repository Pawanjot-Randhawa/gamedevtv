extends Area2D

@export var SPEED: int = 500
var direction:Vector2

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta

func _on_lifespan_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(20)
		queue_free()
