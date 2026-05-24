extends Node2D

@onready var label: Label = $Label
@onready var progress_bar: ProgressBar = $ProgressBar

var TEMP:bool = true
var burn_ticks:int = 0:
	set(value):
		burn_ticks = clamp(value, 0, 4)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.burn_tick.connect(burn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(damage: int):
	label.text = str(damage)
	progress_bar.value -= damage
	if progress_bar.value <= 0:
		progress_bar.value = 200
	if TEMP:
		TEMP = !TEMP
		label.add_theme_color_override("font_color", Color(0.451, 0.512, 1.0, 1.0))
	else:
		TEMP = !TEMP
		label.add_theme_color_override("font_color", Color(0.976, 0.0, 0.737, 1.0))

func add_burn(ticks:int):
	burn_ticks += ticks

func burn():
	if burn_ticks > 0:
		burn_ticks-=1
		take_damage(5)
