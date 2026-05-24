extends Node2D

@onready var fire_visual: MeshInstance2D = $FireVisual
@onready var fire_area: Area2D = $FireArea


func _ready() -> void:
	fire_visual.hide()
	fire_area.monitoring = false
	Game.flamethrow_tick.connect(flame_throw)
	Game.flameduration_tick.connect(flame_stop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func flame_throw() -> void:
	fire_visual.show()
	fire_area.monitoring = true


func flame_stop() -> void:
	fire_visual.hide()
	fire_area.monitoring = false

func _on_fire_area_body_entered(body: Node2D) -> void:
	if body.has_method("add_burn"):
		body.take_damage(20)
		body.add_burn(4)
