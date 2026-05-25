extends Area2D

@export var SPEED: int = 400
var direction:Vector2

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Game.player.HEALTH -= 15
		queue_free()
