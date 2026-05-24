extends Node

signal burn_tick
signal saw_tick
signal shoot_tick
signal flamethrow_tick
signal flameduration_tick

var player:Player = null

var bullets: Node = null


func _on_burn_timer_timeout() -> void:
	burn_tick.emit()


func _on_saw_tick_timer_timeout() -> void:
	saw_tick.emit()


func _on_shooting_timer_timeout() -> void:
	shoot_tick.emit()


func _on_flame_throw_timer_timeout() -> void:
	flamethrow_tick.emit()
	%FlameDurationTimer.start()


func _on_flame_duration_timer_timeout() -> void:
	flameduration_tick.emit()
