extends CharacterBody2D
const DEATH_EXPLOSION = preload("uid://cebkyf60hxx1g")
const WAVE_BULLET = preload("uid://jmlht0ua4j58")
const GUN_PICKUP = preload("uid://4fn0r0cy5akp")
const PLAYER_UPGRADE = preload("uid://wj7f43hg72gd")

var player:Player

@export var speed: float = 150.0
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var shoot_cooldown: Timer = $ShootCooldown

var range = 600.0
var distance_to_player
var can_shoot:bool = true

var burn_ticks:int = 0:
	set(value):
		burn_ticks = clamp(value, 0, 4)

func _ready() -> void:
	Game.burn_tick.connect(burn)
	player = Game.player

func _physics_process(_delta: float) -> void:
	look_at(Game.player.global_position)
	rotation_degrees -= 90
	progress_bar.global_position = global_position + Vector2(-50, -96)
	
	distance_to_player = global_position.distance_to(Game.player.global_position)
	if distance_to_player <= range:
		if can_shoot:
			shoot()
	else:
		var direction = global_position.direction_to(Game.player.global_position)
		self.velocity = direction * self.speed;
		self.move_and_slide()

func take_damage(damage: int):
	progress_bar.value -= damage
	if progress_bar.value <= 0:
		if randf() <= 0.30:
			var pickup = GUN_PICKUP.instantiate()
			get_tree().current_scene.call_deferred("add_child", pickup)
			pickup.global_position = global_position
		elif randf() <= 0.60:
			var pickup = PLAYER_UPGRADE.instantiate()
			get_tree().current_scene.call_deferred("add_child",pickup)
			pickup.global_position = global_position
		Stats.KILLS += 1
		queue_free()

func add_burn(ticks:int):
	burn_ticks += ticks

func burn():
	if burn_ticks > 0:
		burn_ticks-=1
		take_damage(5)

func shoot():
	var bullet = WAVE_BULLET.instantiate()
	Game.bullets.add_child.call_deferred(bullet)
	bullet.direction = Vector2.DOWN.rotated(%bullet_spawn.global_rotation)
	bullet.global_position = %bullet_spawn.global_position
	bullet.global_rotation = %bullet_spawn.global_rotation
	can_shoot = false
	shoot_cooldown.start()


func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
