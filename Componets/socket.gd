extends Area2D
class_name Socket

@export var NAME: String

var connected: bool = false #If this socket is connected to a part
var connected_parts: Array #Stores refernces to the parts that have been connected

##Called in order to connect a part to this socket
func connect_part(part : Node):
	connected = true
	connected_parts.append(part)
	add_child(part)

func get_location():
	return %CollisionShape2D.position
