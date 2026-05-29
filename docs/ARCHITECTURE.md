# 🏗️ Life: Technical Architecture

## Overview

This document describes the technical architecture of the Life game, including core systems, data flow, and design patterns.

## System Architecture

### Core Systems

1. **RaceManager**
   - Manages race definitions and stat modifiers
   - Handles weighted random race selection
   - Central source of truth for race data

2. **ReincarnationSystem**
   - Tracks player lifetimes and legacy data
   - Handles death mechanics and respawning
   - Manages race selection algorithm

3. **NeedsSystem**
   - Tracks four core needs (hunger, energy, social, alignment)
   - Updates needs over time
   - Emits signals for UI and game logic

4. **CharacterController**
   - Handles player movement and input
   - Manages character state (age, race, stats)
   - Integrates with NeedsSystem and RaceManager

5. **MultiplayerManager** (Future)
   - Manages lobbies and player spawning
   - Handles server connections
   - Synchronizes player data across network

6. **NetworkSync** (Future)
   - Real-time synchronization of player positions, animations, needs
   - Handles RPC calls for actions and interactions
   - Optimizes network traffic

## Data Flow

```
Input Event
    ↓
CharacterController._physics_process()
    ↓
    ├→ Movement (move_and_slide)
    ├→ Age increment
    ├→ Lifespan check
    └→ Interact/Action handling
    
NeedsSystem._process()
    ↓
    ├→ Deplete needs over time
    ├→ Emit need_changed signal
    ├→ Check critical/depleted thresholds
    └→ Emit need_critical/need_depleted signals

Need Depletion
    ↓
CharacterController._on_need_depleted()
    ↓
ReincarnationSystem.character_died()
    ↓
    ├→ Create lifetime record
    ├→ Emit character_died signal
    └→ Show death screen

Death Screen
    ↓
Player selects new race
    ↓
ReincarnationSystem.respawn_as_race()
    ↓
CharacterController._setup_race()
    ↓
New character spawned
```

## Class Hierarchy

```
Node (Godot base)
├── RaceManager
├── ReincarnationSystem
├── NeedsSystem
├── CharacterController (extends CharacterBody2D)
├── RaceSelectorUI (extends CanvasLayer)
└── NeedsBar (extends HBoxContainer)
```

## Design Patterns

### 1. Singleton-like Managers
- **RaceManager** and **ReincarnationSystem** are global managers accessed by other systems
- Initialized in Main scene and referenced globally

### 2. Signal-Driven Events
- **NeedsSystem** emits signals when needs change, become critical, or deplete
- **CharacterController** connects to these signals for game logic
- Decouples systems and allows easy UI updates

### 3. Inheritance & Composition
- **CharacterController** extends CharacterBody2D for built-in physics
- Composition: Contains **NeedsSystem** and references **RaceManager**

### 4. Data-Driven Design
- **GameConstants** centralizes all game constants and race definitions
- Race modifiers are data-driven, not hard-coded in character logic

## Performance Considerations

### Frame Rate Optimization
- NeedsSystem updates only once per "game hour" (not every frame)
- CharacterController movement uses `move_and_slide()` for efficient physics

### Memory Optimization
- Lifetime records stored in array (consider database later for large scale)
- Race data loaded once in RaceManager._ready()

### Network Optimization (Future)
- Position sync only if delta > threshold (position smoothing)
- Needs sync every few seconds (not every frame)
- RPCs batched where possible

## Multiplayer Architecture (Future)

### Server Structure
```
Godot Server
├── World State
│   ├── Player positions
│   ├── NPC states
│   └── Dynamic objects
├── Player Manager
│   ├── Spawn/despawn logic
│   └── Load/save player data
└── Game Loop
    └── Sync game state to clients
```

### Client Structure
```
Godot Client
├── Local Character
│   ├── Player input handling
│   └── Movement prediction
├── Remote Players
│   ├── Interpolated positions
│   └── Synced animations
└── UI & Rendering
    └── Display needs, chat, etc.
```

---

**End of Architecture Document**