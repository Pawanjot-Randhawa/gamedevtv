extends CharacterBody2D

var player:Player

@export var speed: float = 150.0
@onready var progress_bar: ProgressBar = $ProgressBar

var burn_ticks:int = 0:
	set(value):
		burn_ticks = clamp(value, 0, 4)

func _ready() -> void:
	Game.burn_tick.connect(burn)
	player = Game.player

const SPEED = 300.0

var rotate_speed = 3

func _physics_process(delta: float) -> void:
	rotate(self.rotate_speed * delta)
	
	var direction = global_position.direction_to(Game.player.global_position)
	self.velocity = direction * self.speed;
	
	self.move_and_slide()
	progress_bar.global_position = global_position + Vector2(-50, -96)


func take_damage(damage: int):
	progress_bar.value -= damage
	if progress_bar.value <= 0:
		queue_free()

func add_burn(ticks:int):
	burn_ticks += ticks

func burn():
	if burn_ticks > 0:
		burn_ticks-=1
		take_damage(5)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		Game.player.HEALTH -= 5
