extends CanvasLayer

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.player_health_change.connect(update_bar)
	Game.upgrade_menu_on.connect(showing)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_bar():
	progress_bar.value = Game.player.HEALTH

func showing(on:bool):
	if on:
		hide()
	else:
		show()
