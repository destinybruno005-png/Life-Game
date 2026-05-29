# 🎮 Life: A Fantasy Multiplayer Life Simulation

**Life** is a collaborative multiplayer fantasy life simulation where players experience the world as different creatures across reincarnation cycles. Play as an Angel, Demon, Dragon, Elf, Necromancy creature, Dwarf, Human, or Goblin—each with unique abilities, needs, and challenges.

## 🌟 Core Features

- **Reincarnation System**: Die and respawn as a different random race (weighted by rarity)
- **8 Playable Races**: Angels, Demons, Dragons, Elves, Necromancy creatures, Dwarfs, Humans, Goblins
- **Needs-Based Gameplay**: Manage hunger, energy, social needs, and alignment
- **Shared Multiplayer World**: Live alongside other players in persistent fantasy realms
- **Emergent Storytelling**: Natural conflicts and collaborations based on race lore
- **Dynamic Population**: Humans dominate (~80%), rarer races offer unique experiences

## 🚀 Quick Start

### Prerequisites
- **Godot 4.x** (download from [godotengine.org](https://godotengine.org))
- **Git** for version control

### Installation

```bash
# Clone the repository
git clone https://github.com/destinybruno005-png/life-game.git
cd life-game

# Open in Godot 4
# 1. Launch Godot
# 2. Click "Open Project" → Select this folder
# 3. Click "Edit" to open the editor
```

### Running the Game

1. **Open `scenes/main/Main.tscn`** in the Godot editor
2. **Press F5** or click the **Play** button to run
3. **Select a race** from the Race Selector UI
4. **Explore the village**, manage your needs, and interact with other players

## 📖 Documentation

- **[GAME_DESIGN.md](./GAME_DESIGN.md)** – Detailed game mechanics, races, progression
- **[DEVELOPMENT_ROADMAP.md](./DEVELOPMENT_ROADMAP.md)** – Phase-by-phase development plan
- **[docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md)** – Technical architecture and systems
- **[docs/API_REFERENCE.md](./docs/API_REFERENCE.md)** – GDScript API for core systems

## 🎮 Gameplay Overview

### Choose Your Race
At start or after death, you're randomly assigned a race (weighted by population):

| Race | Population | Strength | Special Trait |
|------|-----------|----------|---------------|
| **Humans** | 80% | Medium | Versatile, adaptable, great at forming societies |
| **Goblins** | 8% | Low | Chaotic, inventive, pack tactics |
| **Dwarfs** | 4% | Medium-High | Mining, forging, sturdy builds |
| **Necromancy** | 2% | High | Undead, unique needs, raise minions |
| **Elves** | 1.5% | High | Long lifespan, nature magic, fine crafting |
| **Dragons** | 0.75% | Very High | Hoarding, flying, territorial |
| **Demons** | 0.5% | Very High | High magic, moral alignment, power spikes |
| **Angels** | 0.25% | Extreme | Rarest, healing/light, community duties |

### Daily Needs
Manage four core needs to survive and thrive:

- **Hunger**: Find food or cook meals
- **Energy**: Rest and sleep
- **Social**: Interact with other players
- **Alignment**: Act according to your race's moral alignment (good for Angels, evil for Demons)

### Progression
- **Skills**: Learn race-specific abilities (Dragon hoarding, Elf crafting, Dwarf mining)
- **Relationships**: Form bonds with other players, build families, create legacies
- **Housing**: Customize your home (styles vary by race)
- **Economy**: Trade, gather resources, establish a career

### Death & Reincarnation
When you die (old age, combat, accidents), you respawn as a **new random race**. Your previous character's legacy remains (buildings, children, stories) but you experience a fresh life from birth.

## 🏗️ Architecture

### Core Systems

1. **RaceManager** – Handles race definitions, abilities, stat modifiers
2. **ReincarnationSystem** – Weighted random spawning, death mechanics, respawn logic
3. **NeedsSystem** – Tracks hunger, energy, social, alignment; triggers events when depleted
4. **CharacterController** – Player input, movement, animation, interaction
5. **MultiplayerManager** – Lobbies, server sync, player spawning
6. **NetworkSync** – Real-time position, animation, needs synchronization

### Data Flow

```
Player Input → CharacterController
             ↓
         Movement & Actions
             ↓
    NeedsSystem (decay over time)
             ↓
         World State
             ↓
    NetworkSync (to other players)
             ↓
         UI Updates (HUD, needs bars)
```

## 📦 Dependencies

- **Godot 4.x** (built-in multiplayer support)
- **No external plugins required** (uses built-in GDScript, MultiplayerAPI, etc.)

## 🛠️ Development

### Building from Source

```bash
# Install Godot 4.x
# Clone repo
git clone https://github.com/destinybruno005-png/life-game.git

# Open in Godot editor
# Make changes to scripts and scenes
# Commit and push:
git add .
git commit -m "Describe your changes"
git push origin main
```

### Running Tests

```gdscript
# Tests are in tests/ directory
# Run via Godot's testing framework or manually verify in-game
```

## 🎨 Art & Assets

**Current Status**: Placeholder assets (colored squares for races)

**To-Do**:
- [ ] Commission or create race-specific character models
- [ ] Design housing styles per race
- [ ] Create environment tilesets
- [ ] Audio: Ambient music, SFX (footsteps, eating, building)

Recommended approaches:
- **Pixel Art**: Itch.io free packs, aseprite for animation
- **Low-Poly 3D**: Blender + Godot FBX export
- **Modular Rigging**: MakeHuman or Unity Store assets adapted for Godot

## 🤝 Contributing

We welcome contributions! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit changes (`git commit -m "Add feature"`)
4. Push to branch (`git push origin feature/your-feature`)
5. Open a Pull Request

See [DEVELOPMENT_ROADMAP.md](./DEVELOPMENT_ROADMAP.md) for planned features and current priorities.

## 📜 License

This project is licensed under the **MIT License** – see [LICENSE](./LICENSE) file for details.

## 👥 Credits

**Created by**: destinybruno005-png
**Concept & Design**: Based on the "Life" fantasy simulation manuscript
**Engine**: Godot 4.x

## 🔗 Links

- [Godot Engine](https://godotengine.org)
- [GDScript Documentation](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/index.html)
- [Godot Multiplayer Guide](https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html)

## 📧 Support

For bugs, feature requests, or questions:
- Open an **Issue** on GitHub
- Check existing issues first to avoid duplicates

---

**Start your new life today! 🌍✨**