extends Node

@onready var player: Player = $level/Player

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		player.set_process_input(true)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.player = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(Game.player.position)
