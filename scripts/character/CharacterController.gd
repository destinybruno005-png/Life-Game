# CharacterController.gd
# Handles player input, movement, animation, and interaction

extends CharacterBody2D

class_name CharacterController

@export var speed = 150.0
@export var acceleration = 500.0

var race: String = "Human"
var age: float = 0.0
var gold: int = 0
var velocity: Vector2 = Vector2.ZERO

var race_manager: RaceManager
var reincarnation_system: ReincarnationSystem
var needs_system: NeedsSystem
var player_stats: Dictionary = {
	"level": 1,
	"xp": 0,
	"strength": 10,
	"magic": 10,
	"dexterity": 10,
	"luck": 5,
	"charisma": 10
}

func _ready():
	# Initialize systems
	race_manager = get_tree().root.get_child(0).find_child("RaceManager")
	if race_manager == null:
		race_manager = RaceManager.new()
	
	reincarnation_system = get_tree().root.get_child(0).find_child("ReincarnationSystem")
	if reincarnation_system == null:
		reincarnation_system = ReincarnationSystem.new()
	
	# Create needs system as child
	needs_system = NeedsSystem.new()
	add_child(needs_system)
	needs_system.need_depleted.connect(_on_need_depleted)
	
	# Setup race
	_setup_race(race)
	
	# Connect signals
	needs_system.need_changed.connect(_on_need_changed)

func _setup_race(race_name: String):
	race = race_name
	age = 0.0
	
	var race_data = race_manager.get_race_data(race)
	
	# Apply stat modifiers
	var modified_stats = race_manager.apply_stat_modifiers(player_stats, race)
	player_stats = modified_stats
	
	# Update visual (placeholder: color based on race)
	if has_node("ColorRect"):
		$ColorRect.color = race_data.get("color", Color.WHITE)
	
	print("Spawned as: %s" % race)

func _physics_process(delta):
	# Get input
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	input_vector = input_vector.normalized()
	
	# Apply acceleration
	if input_vector.length() > 0:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	
	# Move character
	velocity = move_and_slide(velocity)
	
	# Age over time
	age += delta / 60.0
	
	# Check if reached lifespan
	var lifespan = race_manager.get_lifespan(race)
	if age >= lifespan:
		_on_character_death("old_age")

func _on_need_depleted(need_name: String):
	print("Need depleted: %s" % need_name)
	_on_character_death(need_name)

func _on_character_death(cause: String):
	print("Character died: %s" % cause)
	reincarnation_system.character_died(self)
	queue_free()

func _on_need_changed(need_name: String, value: float):
	pass

func eat(food_name: String):
	needs_system.increase_need("hunger", 30.0)

func rest():
	needs_system.increase_need("energy", 50.0)

func gain_xp(amount: int):
	player_stats["xp"] += amount

func add_gold(amount: int):
	gold += amount

func get_info() -> Dictionary:
	return {
		"race": race,
		"age": age,
		"level": player_stats["level"],
		"gold": gold,
		"needs": needs_system.get_all_needs()
	}