extends Node2D

@onready var enimies: Node2D = $Enimies

const SEEKER = preload("uid://cui5dche5q4g2")
const WINDMILL = preload("uid://b3xldxg7vkmhj")
const SHOOTER = preload("uid://dvh7tdg5q7s1y")
const WAVE_SHOOTER = preload("uid://d2tiyuo7w80n5")

@export var enemy_scenes: Array[PackedScene]
@export var player: Node2D   
@export var min_spawn_radius: float = 400.0
@export var max_spawn_radius: float = 700.0 
@export var spawn_cooldown: float = 2.0
@onready var spawn_timer: Timer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.first_pickup.connect(start_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Stats.KILLS >=5:
		spawn_timer.wait_time = 6.0
		Stats.ENEMY_MAX = 6
	if Stats.KILLS >=10:
		spawn_timer.wait_time = 5.0
		Stats.ENEMY_MAX = 10
	if Stats.KILLS >=20:
		spawn_timer.wait_time = 4.0
		Stats.ENEMY_MAX = 15
	if Stats.KILLS >=40:
		spawn_timer.wait_time = 3.0
		Stats.ENEMY_MAX = 20

func start_game():
	print("star ggasme")
	spawn_enemy_around_player()
	spawn_timer.start()

func spawn_enemy_around_player() -> void:
	var spawn_pos = get_random_spawn_position()
	if is_position_safe(spawn_pos):
		var random_enemy_scene = enemy_scenes.pick_random()
		var enemy_instance = random_enemy_scene.instantiate()
		
		enimies.call_deferred("add_child",enemy_instance)
		enemy_instance.global_position = spawn_pos

func get_random_spawn_position() -> Vector2:
	var random_angle = randf_range(0.0, TAU)
	var random_distance = randf_range(min_spawn_radius, max_spawn_radius)
	var offset = Vector2.RIGHT.rotated(random_angle) * random_distance
	return player.global_position + offset

func is_position_safe(pos: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	var circle = CircleShape2D.new()
	circle.radius = 16.0
	query.shape = circle
	query.transform = Transform2D(0, pos)
	query.collision_mask = 1 
	var result = space_state.intersect_shape(query)
	return result.is_empty()

func _on_spawn_timer_timeout() -> void:
	spawn_enemy_around_player()
