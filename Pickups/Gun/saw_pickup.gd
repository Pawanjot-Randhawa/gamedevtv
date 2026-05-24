extends Area2D

const SAW = preload("uid://cyksvvt0kyw1s")

var part
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is Socket:
		var parts = area.connected_parts
		if parts:
			pass
		else:#No connected parts in this socket
			part = SAW.instantiate()
			area.connect_part(part)
			queue_free()
