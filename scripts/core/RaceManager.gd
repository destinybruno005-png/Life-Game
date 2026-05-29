# RaceManager.gd
# Manages race selection, spawning, and stat calculations

extends Node

class_name RaceManager

# Cached race data
var races: Dictionary = {}
var race_list: Array = []
var race_spawn_weights: Dictionary = {}

func _ready():
	_load_races()
	_calculate_spawn_weights()

# Load all races from constants
func _load_races():
	races = GameConstants.RACES.duplicate(true)
	race_list = races.keys()

# Calculate spawn weight for each race
func _calculate_spawn_weights():
	var total_weight = 0.0
	
	for race_name in race_list:
		var spawn_rate = races[race_name]["spawn_rate"]
		race_spawn_weights[race_name] = spawn_rate
		total_weight += spawn_rate
	
	# Normalize weights
	for race_name in race_list:
		race_spawn_weights[race_name] /= total_weight

# Get a random race based on spawn rates
func get_random_race(exclude_races: Array = []) -> String:
	var available_races = race_list.filter(func(r): return r not in exclude_races)
	
	if available_races.is_empty():
		return "Human"
	
	var rand = randf()
	var cumulative = 0.0
	
	for race in available_races:
		cumulative += race_spawn_weights[race]
		if rand <= cumulative:
			return race
	
	return available_races[0]

# Get race data
func get_race_data(race_name: String) -> Dictionary:
	if race_name in races:
		return races[race_name]
	return races["Human"]

# Apply stat modifiers for a race
func apply_stat_modifiers(base_stats: Dictionary, race_name: String) -> Dictionary:
	var race_data = get_race_data(race_name)
	var modified_stats = base_stats.duplicate()
	
	for stat_name in race_data.get("stat_modifiers", {}):
		var modifier = race_data["stat_modifiers"][stat_name]
		if stat_name in modified_stats:
			modified_stats[stat_name] *= (1.0 + modifier)
	
	return modified_stats

# Get all races
func get_all_races() -> Array:
	return race_list

# Get spawn rate for a race
func get_spawn_rate(race_name: String) -> float:
	var race_data = get_race_data(race_name)
	return race_data.get("spawn_rate", 0.0)

# Get lifespan for a race (in years)
func get_lifespan(race_name: String) -> int:
	var race_data = get_race_data(race_name)
	return race_data.get("lifespan", 70)