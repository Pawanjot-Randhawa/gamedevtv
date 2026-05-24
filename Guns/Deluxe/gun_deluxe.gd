extends Node2D
const BULLET = preload("uid://c2qsenuq46g6x")

@onready var bullet_spawn_point: Marker2D = $bulletSpawnPoint
@onready var bullet_spawn_point_2: Marker2D = $bulletSpawnPoint2
@onready var bullet_spawn_point_3: Marker2D = $bulletSpawnPoint3
var NAME = "GUN"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.shoot_tick.connect(shoot_tick)

func shoot_tick() -> void:
	add_bullet(bullet_spawn_point)
	add_bullet(bullet_spawn_point_2)
	add_bullet(bullet_spawn_point_3)

func add_bullet(point:Marker2D):
	var bullet = BULLET.instantiate()
	Game.bullets.add_child.call_deferred(bullet)
	bullet.direction = Vector2.UP.rotated(point.global_rotation)
	bullet.global_position = point.global_position
	bullet.global_rotation = point.global_rotation
