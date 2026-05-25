extends Node

var upgrades:Dictionary = {
	#upgrade name, [count of how many tiems its been selected, description]
	"Movement": [0, "Upgrade the your movment Speed", "res://assets/icons/cursor_move_256px.png"],
	"Rotation": [0, "Upgrade the your rotation Speed", "res://assets/icons/refresh_256px.png"],
	"Health": [0, "Increase your health by 100", "res://assets/icons/hearts_256px.png"],
	"Regen": [0, "Increase your Health Regen Rate", "res://assets/icons/heart_card_256px.png"]
}

var levels:Dictionary = {
	1:preload("uid://bktil4ildeec8"),
	2:preload("uid://ypbd3u2wckw5"),
	3:preload("uid://cv0gnvq5ri427"),
	4:preload("uid://ou3ri8pi6h0i"),
	5:preload("uid://c77fhisi1htsu")
}
