# NeedsBar.gd
# UI component for displaying a single need bar

extends HBoxContainer

class_name NeedsBar

@export var need_name: String = "hunger"

var needs_system: NeedsSystem
var progress_bar: ProgressBar
var label: Label

func _ready():
	# Find parent character
	var parent = get_parent()
	while parent != null:
		if parent.has_method("get_info"):
			needs_system = parent.needs_system
			break
		parent = parent.get_parent()
	
	if needs_system == null:
		return
	
	# Create visual elements
	label = Label.new()
	label.text = GameConstants.NEEDS[need_name]["name"]
	label.custom_minimum_size = Vector2(80, 0)
	add_child(label)
	
	progress_bar = ProgressBar.new()
	progress_bar.custom_minimum_size = Vector2(200, 20)
	progress_bar.modulate = GameConstants.NEEDS[need_name]["color"]
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	add_child(progress_bar)
	
	# Connect to needs system
	needs_system.need_changed.connect(_on_need_changed)

func _on_need_changed(changed_need: String, value: float):
	if changed_need == need_name:
		progress_bar.value = value