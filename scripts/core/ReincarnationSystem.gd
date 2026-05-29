# ReincarnationSystem.gd
# Handles death, respawning, race selection, and legacy persistence

extends Node

class_name ReincarnationSystem

var race_manager: RaceManager
var player_lifetimes: Array = []  # Track all past lives
var current_lifetime_index: int = 0

signal character_died(lifetime_data: Dictionary)
signal character_respawned(new_race: String)
signal lifetime_milestone(message: String)

func _ready():
	race_manager = get_tree().root.get_child(0).find_child("RaceManager")
	if race_manager == null:
		race_manager = RaceManager.new()

# Record death and trigger respawn
func character_died(character: Node):
	var lifetime_data = _create_lifetime_record(character)
	player_lifetimes.append(lifetime_data)
	
	character_died.emit(lifetime_data)
	
	# Show death screen
	_show_death_screen(lifetime_data)

# Internal: Create lifetime record
func _create_lifetime_record(character: Node) -> Dictionary:
	var stats = character.player_stats if character.has_meta("player_stats") else {}
	
	return {
		"lifetime_index": len(player_lifetimes),
		"race": character.race if character.has_meta("race") else "Human",
		"level": stats.get("level", 0) if stats else 0,
		"age": character.age if character.has_meta("age") else 0,
		"gold": character.gold if character.has_meta("gold") else 0,
		"children": [],
		"timestamp": Time.get_ticks_msec(),
		"deeds": {}
	}

# Respawn player as new race
func respawn_as_race(new_race: String = "") -> String:
	if new_race == "":
		# Get last played race to exclude (cooldown)
		var last_race = ""
		if len(player_lifetimes) > 0:
			last_race = player_lifetimes[-1]["race"]
		
		new_race = race_manager.get_random_race([last_race])
	
	character_respawned.emit(new_race)
	return new_race

# Get lifetime history
func get_lifetime_history() -> Array:
	return player_lifetimes

# Get current lifetime index
func get_current_lifetime() -> int:
	return len(player_lifetimes)

# Internal: Show death screen (placeholder)
func _show_death_screen(lifetime_data: Dictionary):
	print("Death Screen - Lifetime %d as %s" % [lifetime_data["lifetime_index"], lifetime_data["race"]])
	print("Level: %d, Age: %d, Gold: %d" % [lifetime_data["level"], lifetime_data["age"], lifetime_data["gold"]])