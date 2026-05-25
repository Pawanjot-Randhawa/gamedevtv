extends Area2D

@export var SPEED: int = 250
@export var rotate_speed: int = 3
@onready var saw_sprite: Sprite2D = $"Sprite2D"

var direction:Vector2
var enemeis_in_range: Array


func _ready() -> void:
	Game.saw_tick.connect(saw_tick)

func saw_tick() -> void:
	if enemeis_in_range:
		for enemy in enemeis_in_range:
			enemy.take_damage(Stats.SAW_BULLET_DAMAGE)

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	self.saw_sprite.rotate(self.rotate_speed * delta)

func _on_lifespan_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		enemeis_in_range.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("take_damage"):
		enemeis_in_range.erase(body)
