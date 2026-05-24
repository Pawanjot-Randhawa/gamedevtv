extends Area2D
class_name Socket

@export var NAME: String

var connected: bool = false #If this socket is connected to a part
var connected_parts: Array #Stores refernces to the parts that have been connected

##Called in order to connect a part to this socket
func connect_part(part : Node):
	connected = true
	connected_parts.append(part)
	call_deferred("add_child", part)

#Called in order to clear this sockets ucrrent child and to replace it with the upgrade version
func upgrade_part():
	connected_parts.get(0).queue_free()

func get_location():
	return %CollisionShape2D.position
