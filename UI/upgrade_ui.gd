extends CanvasLayer
class_name Upgrade_UI

# Preload your custom card template scene
const UPGRADE_CARD = preload("uid://d3e0reumoty6i")

# Drag your HBoxContainer from the scene tree into the script holding Ctrl to auto-path
@onready var choice_holder:Node = $CenterContainer/MarginContainer/HBoxContainer
func _ready() -> void:
	hide()

func display_upgrade_options():
	
	# 1. Open menu
	show()
	Game.upgrade_menu_on.emit(true)
	get_tree().paused = true
	
	# 2. Flush out previous round's upgrade choices
	for child in choice_holder.get_children():
		child.queue_free()
		
	# 3. Filter valid upgrades from your Data dictionary
	var available: Array = []
	for key in Data.upgrades.keys():
		if Data.upgrades[key][0] < 5: # If current level is less than max
			available.append(key)
			
	available.shuffle()
	
	# 4. Instantiate up to 3 cards
	var limit = min(3, available.size())
	for i in range(limit):
		var upgrade_name = available[i]
		var upgrade_level = Data.upgrades[upgrade_name][0]
		var upgrade_desc = Data.upgrades[upgrade_name][1]
		
		# Instantiate card layout asset
		var card_instance = UPGRADE_CARD.instantiate()
		choice_holder.add_child(card_instance)
		
		# Set up the text elements inside your card node
		# (Assuming your card script has a setup function or direct label references)
		card_instance.get_node("MarginContainer/VBoxContainer/Level").texture = Data.levels[upgrade_level + 1]
		card_instance.get_node("MarginContainer/VBoxContainer/Title").text = upgrade_name 
		card_instance.get_node("MarginContainer/VBoxContainer/Icon").texture = load(Data.upgrades[upgrade_name][2])
		card_instance.get_node("MarginContainer/VBoxContainer/Description").text = upgrade_desc
		
		# Hook up the button press to run your selection logic
		var btn = card_instance.get_node("MarginContainer/VBoxContainer/SelectButton")
		btn.pressed.connect(on_option_chosen.bind(upgrade_name))

func on_option_chosen(chosen_upgrade: String):
	Data.upgrades[chosen_upgrade][0] += 1
	Game.player.upgrade(chosen_upgrade)
	get_tree().paused = false
	Game.upgrade_menu_on.emit(false)
	hide()
