extends Node2D
const FLAME_BULLET = preload("uid://bxrct3w1ff1ov")

@onready var bullet_spawn_point: Marker2D = $bulletSpawnPoint
var NAME = "GUN"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.shoot_tick.connect(shoot_tick)

func shoot_tick() -> void:
	var bullet = FLAME_BULLET.instantiate()
	Game.bullets.add_child.call_deferred(bullet)
	bullet.direction = Vector2.UP.rotated(bullet_spawn_point.global_rotation)
	bullet.global_position = bullet_spawn_point.global_position
	bullet.global_rotation = bullet_spawn_point.global_rotation
