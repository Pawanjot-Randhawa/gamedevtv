extends Area2D
class_name Socket

@export var socket_parent: Node

var connected: bool = false #If this socket is connected to a part
var connected_part = null #Stores refernce to the part that has been connected

##Called in order to connect a part to this socket
func connect_part(parent : Node):
	%CollisionShape2D.disabled = true
	socket_parent = parent
	connected = true

func get_location():
	return %CollisionShape2D.position
