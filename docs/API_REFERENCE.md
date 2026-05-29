# 📚 Life: GDScript API Reference

## GameConstants

Global constants used throughout the game.

### Properties
- `RACES: Dictionary` – All race definitions
- `NEEDS: Dictionary` – Need types and properties
- `MAX_LEVEL: int` – Maximum player level (50)
- `BASE_XP_FOR_LEVEL: int` – Base XP required per level (100)

---

## RaceManager

Singleton manager for race data and operations.

### Methods

#### `get_random_race(exclude_races: Array = []) -> String`
Returns a random race based on spawn rates.

#### `get_race_data(race_name: String) -> Dictionary`
Returns the data dictionary for a specific race.

#### `apply_stat_modifiers(base_stats: Dictionary, race_name: String) -> Dictionary`
Applies race-specific stat modifiers to base stats.

#### `get_lifespan(race_name: String) -> int`
Returns the lifespan (in years) for a race.

#### `get_all_races() -> Array`
Returns array of all race names.

---

## NeedsSystem

Tracks and updates character needs.

### Properties
- `needs: Dictionary` – Current need values (0-100)

### Methods

#### `set_need(need_name: String, value: float)`
Set a need to a specific value (clamped 0-100).

#### `increase_need(need_name: String, amount: float)`
Increase a need by an amount.

#### `decrease_need(need_name: String, amount: float)`
Decrease a need by an amount.

#### `get_need(need_name: String) -> float`
Get current value of a need.

#### `get_all_needs() -> Dictionary`
Get all needs and their current values.

#### `is_critical() -> bool`
Check if any need is at or below critical threshold.

#### `is_depleted() -> bool`
Check if any need is depleted (should trigger death).

### Signals

#### `need_changed(need_name: String, value: float)`
Emitted when a need value changes.

#### `need_critical(need_name: String)`
Emitted when a need reaches critical level.

#### `need_depleted(need_name: String)`
Emitted when a need reaches zero (depleted).

---

## ReincarnationSystem

Handles death, respawning, and lifetime tracking.

### Methods

#### `character_died(character: Node)`
Record character death and trigger respawn sequence.

#### `respawn_as_race(new_race: String = "") -> String`
Trigger respawn as a specific race (or random if not specified).

#### `get_lifetime_history() -> Array`
Get array of all past lifetimes.

---

## CharacterController

Main player character class.

### Properties
- `race: String` – Current race
- `age: float` – Current age in years
- `gold: int` – Current gold
- `speed: float` – Movement speed
- `player_stats: Dictionary` – Level, XP, attributes

### Methods

#### `eat(food_name: String)`
Eat food to restore hunger.

#### `rest()`
Rest to restore energy.

#### `gain_xp(amount: int)`
Gain experience points.

#### `add_gold(amount: int)`
Gain or lose gold.

#### `get_info() -> Dictionary`
Get comprehensive character information.

---

**End of API Reference**