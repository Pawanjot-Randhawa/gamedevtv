extends Area2D

const GUN = preload("uid://bj1fwdi0ljtnk")
const FLAME_GUN = preload("uid://cglicmsxp2rf5")
const SAW_GUN = preload("uid://diwd6b36ng5cn")
const GUN_DELUXE = preload("uid://danmsw7nlenr4")


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
			if parts.size() == 1:
				var part_name = parts.get(0)
				if part_name.NAME == "FLAME":
					part = FLAME_GUN.instantiate()
					area.upgrade_part()
					area.connect_part(part)
				elif part_name.NAME == "GUN":
					part = GUN_DELUXE.instantiate()
					area.upgrade_part()
					area.connect_part(part)
				elif part_name.NAME == "SAW":
					part = SAW_GUN.instantiate()
					area.upgrade_part()
					area.connect_part(part)
				queue_free()
			if parts.size() == 2:#FULL SOCKET
				return
		else:#No connected parts in this socket
			part = GUN.instantiate()
			area.connect_part(part)
			queue_free()
