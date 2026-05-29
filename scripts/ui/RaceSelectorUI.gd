# RaceSelectorUI.gd
# Beautiful UI for selecting a race at game start

extends CanvasLayer

class_name RaceSelectorUI

var race_manager: RaceManager
var selected_race: String = "Human"

signal race_selected(race: String)

func _ready():
	race_manager = get_tree().root.get_child(0).find_child("RaceManager")
	if race_manager == null:
		race_manager = RaceManager.new()
	
	_build_ui()

func _build_ui():
	var container = VBoxContainer.new()
	container.anchor_left = 0.5
	container.anchor_top = 0.5
	container.offset_left = -300
	container.offset_top = -250
	container.custom_minimum_size = Vector2(600, 500)
	add_child(container)
	
	# Title
	var title = Label.new()
	title.text = "Choose Your Race"
	title.add_theme_font_size_override("font_size", 32)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	container.add_child(title)
	
	var spacing = Control.new()
	spacing.custom_minimum_size = Vector2(0, 20)
	container.add_child(spacing)
	
	# Race buttons in grid
	var h_container = HBoxContainer.new()
	h_container.custom_minimum_size = Vector2(600, 400)
	h_container.add_theme_constant_override("separation", 10)
	container.add_child(h_container)
	
	var races = race_manager.get_all_races()
	var buttons_per_row = 4
	var current_row = null
	var button_count = 0
	
	for race_name in races:
		if button_count % buttons_per_row == 0:
			if current_row != null:
				h_container.add_child(current_row)
			current_row = VBoxContainer.new()
		
		var race_button = _create_race_button(race_name)
		current_row.add_child(race_button)
		button_count += 1
	
	if current_row != null:
		h_container.add_child(current_row)

func _create_race_button(race_name: String) -> Button:
	var race_data = race_manager.get_race_data(race_name)
	
	var button = Button.new()
	button.text = "%s" % race_data["display_name"]
	button.custom_minimum_size = Vector2(120, 60)
	button.modulate = race_data["color"]
	button.pressed.connect(_on_race_selected.bind(race_name))
	
	return button

func _on_race_selected(race: String):
	selected_race = race
	race_selected.emit(race)
	queue_free()