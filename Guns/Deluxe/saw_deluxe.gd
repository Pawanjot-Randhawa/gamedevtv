extends Area2D

var enemeis_in_range: Array

var NAME = "SAW"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.saw_tick.connect(saw_tick)

func saw_tick() -> void:
	if enemeis_in_range:
		for enemy in enemeis_in_range:
			enemy.take_damage(Stats.SAW_DELUXE_DAMAGE)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		enemeis_in_range.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("take_damage"):
		enemeis_in_range.erase(body)
