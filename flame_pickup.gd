extends Area2D

const FLAME = preload("uid://cyqp0kxmee1s0")
const FLAME_SAW = preload("uid://7d40mnlew3no")
const FLAME_GUN = preload("uid://cglicmsxp2rf5")
const FLAME_DELUXE = preload("uid://2yviwvi821rn")


var part
func _on_area_entered(area: Area2D) -> void:
	if area is Socket:
		var parts:Array = area.connected_parts
		if parts:
			if parts.size() == 1:
				var part_name = parts.get(0)
				if part_name.NAME == "SAW":
					part = FLAME_SAW.instantiate()
					area.upgrade_part()
					area.connect_part(part)
				elif part_name.NAME == "GUN":
					part = FLAME_GUN.instantiate()
					area.upgrade_part()
					area.connect_part(part)
				elif part_name.NAME == "FLAME":
					part = FLAME_DELUXE.instantiate()
					area.upgrade_part()
					area.connect_part(part)
				queue_free()
			if parts.size() == 2:#FULL SOCKET
				return
		else:#No connected parts in this socket
			part = FLAME.instantiate()
			area.connect_part(part)
			queue_free()
