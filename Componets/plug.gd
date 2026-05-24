extends Area2D
class_name Plug

@export var parent: Node

func connect_to_socket(socket: Area2D) -> void:
	#If the Area if not a socket, we should return as this isnt suposed to happen
	if socket is Socket:
		socket.connect_part(parent)
		parent.reparent(socket)
		
		var location = socket.get_location()
		var tween = create_tween()
		parent.position = location
		#tween.tween_property(parent,"position",Vector2(location),0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		print("Connected")
	else:
		print("Not a socket")
		print(socket)
		return


func _on_area_entered(area: Area2D) -> void:
	if area is Socket:
		var socket = area
		socket.connect_part(parent)
		parent.reparent(socket)
		
		var location = socket.get_location()
		var tween = create_tween()
		tween.tween_property(parent,"position",Vector2(location),0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		print("Connected")
