# NeedsSystem.gd
# Tracks and updates character needs (hunger, energy, social, alignment)

extends Node

class_name NeedsSystem

# Current need values (0-100)
var needs: Dictionary = {
	"hunger": 100.0,
	"energy": 100.0,
	"social": 100.0,
	"alignment": 50.0
}

var parent_character = null
var game_time_elapsed = 0.0

signal need_changed(need_name: String, value: float)
signal need_critical(need_name: String)
signal need_depleted(need_name: String)

func _ready():
	parent_character = get_parent()

func _process(delta):
	game_time_elapsed += delta
	
	# Update needs every game "hour"
	if game_time_elapsed >= GameConstants.GAME_HOUR_DURATION:
		_update_needs()
		game_time_elapsed = 0.0

# Update all needs (deplete over time)
func _update_needs():
	for need_name in GameConstants.NEEDS:
		if need_name == "alignment":
			continue  # Alignment doesn't deplete
		
		var depletion_rate = GameConstants.NEEDS[need_name]["depletion_rate"]
		needs[need_name] -= depletion_rate
		needs[need_name] = clamp(needs[need_name], 0.0, 100.0)
		
		need_changed.emit(need_name, needs[need_name])
		
		# Check critical threshold
		var critical_threshold = GameConstants.NEEDS[need_name]["critical_threshold"]
		if needs[need_name] <= critical_threshold:
			need_critical.emit(need_name)
		
		# Check if need is depleted
		if needs[need_name] <= 0.0:
			need_depleted.emit(need_name)

# Set a specific need value
func set_need(need_name: String, value: float):
	if need_name in needs:
		needs[need_name] = clamp(value, 0.0, 100.0)
		need_changed.emit(need_name, needs[need_name])

# Increase a specific need
func increase_need(need_name: String, amount: float):
	set_need(need_name, needs[need_name] + amount)

# Decrease a specific need
func decrease_need(need_name: String, amount: float):
	set_need(need_name, needs[need_name] - amount)

# Get current need value
func get_need(need_name: String) -> float:
	return needs.get(need_name, 0.0)

# Get all needs
func get_all_needs() -> Dictionary:
	return needs.duplicate()

# Check if any need is critical
func is_critical() -> bool:
	for need_name in GameConstants.NEEDS:
		if need_name == "alignment":
			continue
		var critical_threshold = GameConstants.NEEDS[need_name]["critical_threshold"]
		if needs[need_name] <= critical_threshold:
			return true
	return false

# Check if any need is depleted (should trigger death)
func is_depleted() -> bool:
	for need_name in GameConstants.NEEDS:
		if need_name == "alignment":
			continue
		if needs[need_name] <= 0.0:
			return true
	return false