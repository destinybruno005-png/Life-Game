# GameConstants.gd
# Central place for all game-wide constants and race definitions

extends Node

# ===== RACE DEFINITIONS =====
const RACES = {
	"Angel": {
		"spawn_rate": 0.0025,
		"lifespan": 100,
		"display_name": "Angel",
		"description": "Rare celestial beings sent to protect mortals.",
		"stat_modifiers": {
			"strength": -0.2,
			"magic": 0.4,
			"luck": 0.3,
			"charisma": 0.2
		},
		"color": Color.WHITE
	},
	"Demon": {
		"spawn_rate": 0.005,
		"lifespan": 80,
		"display_name": "Demon",
		"description": "Powerful but chaotic beings from the abyss.",
		"stat_modifiers": {
			"magic": 0.5,
			"speed": 0.2,
			"charisma": -0.3
		},
		"color": Color.RED
	},
	"Dragon": {
		"spawn_rate": 0.0075,
		"lifespan": 200,
		"display_name": "Dragon",
		"description": "Ancient, proud, and territorial beings.",
		"stat_modifiers": {
			"strength": 0.6,
			"magic": 0.4,
			"charisma": -0.4,
			"speed": -0.3
		},
		"color": Color.GOLD
	},
	"Elf": {
		"spawn_rate": 0.015,
		"lifespan": 120,
		"display_name": "Elf",
		"description": "Graceful, wise, deeply connected to nature.",
		"stat_modifiers": {
			"magic": 0.2,
			"dexterity": 0.3,
			"charisma": 0.25
		},
		"color": Color.GREEN
	},
	"Necromancy": {
		"spawn_rate": 0.02,
		"lifespan": 999,
		"display_name": "Necromancy",
		"description": "Cursed undead creatures feared by many.",
		"stat_modifiers": {
			"magic": 0.4,
			"strength": 0.2,
			"charisma": -0.5
		},
		"color": Color.MEDIUM_PURPLE
	},
	"Dwarf": {
		"spawn_rate": 0.04,
		"lifespan": 90,
		"display_name": "Dwarf",
		"description": "Hardy, community-oriented craftspeople.",
		"stat_modifiers": {
			"strength": 0.35,
			"craftsmanship": 0.3,
			"speed": -0.2
		},
		"color": Color.ORANGE
	},
	"Human": {
		"spawn_rate": 0.8,
		"lifespan": 70,
		"display_name": "Human",
		"description": "Versatile, adaptable, backbone of civilization.",
		"stat_modifiers": {},
		"color": Color.LIGHT_GRAY
	},
	"Goblin": {
		"spawn_rate": 0.08,
		"lifespan": 50,
		"display_name": "Goblin",
		"description": "Chaotic, opportunistic, fun-loving hustlers.",
		"stat_modifiers": {
			"speed": 0.3,
			"dexterity": 0.2,
			"strength": -0.4,
			"charisma": -0.2
		},
		"color": Color.GREEN_YELLOW
	}
}

# ===== NEEDS SYSTEM =====
const NEEDS = {
	"hunger": {
		"name": "Hunger",
		"depletion_rate": 0.05,
		"critical_threshold": 0.2,
		"color": Color.ORANGE
	},
	"energy": {
		"name": "Energy",
		"depletion_rate": 0.03,
		"critical_threshold": 0.2,
		"color": Color.YELLOW
	},
	"social": {
		"name": "Social",
		"depletion_rate": 0.02,
		"critical_threshold": 0.2,
		"color": Color.CYAN
	},
	"alignment": {
		"name": "Alignment",
		"depletion_rate": 0.0,
		"critical_threshold": 0.0,
		"color": Color.WHITE
	}
}

# ===== PROGRESSION =====
const MAX_LEVEL = 50
const BASE_XP_FOR_LEVEL = 100

# ===== WORLD =====
const WORLD_WIDTH = 2000
const WORLD_HEIGHT = 2000
const VILLAGE_CENTER = Vector2(1000, 1000)

# ===== TIMING =====
const REAL_MINUTE_TO_GAME_HOUR = 6.0
const GAME_HOUR_DURATION = 60.0 / REAL_MINUTE_TO_GAME_HOUR