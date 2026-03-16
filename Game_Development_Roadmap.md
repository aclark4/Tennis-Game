# Tennis Tiny Bookshop — Game Development Roadmap

This roadmap is designed to get you from zero Godot experience to a working prototype as quickly as possible. It prioritizes gameplay mechanics first, placeholder art throughout, and polish/art/music last.

---

## Phase 0: Learn the Basics of Godot (1–2 weeks)

Before touching your game, spend a short focused period learning how Godot works. You don't need to master everything — just enough to be dangerous.

### What to learn

- **The Godot editor**: Nodes, scenes, the scene tree, and how they relate to each other
- **GDScript fundamentals**: Variables, functions, conditionals, loops, signals
- **Scene composition**: How to build reusable scenes and instance them
- **Input handling**: How to detect keyboard/mouse/touch input
- **Basic UI**: Labels, buttons, containers

### Recommended tutorials

1. **Official Godot Step-by-Step Guide** — Start here. It's free and covers all the fundamentals.
   - https://docs.godotengine.org/en/stable/getting_started/step_by_step/index.html

2. **GDQuest: Learn GDScript From Zero** — Free, interactive, runs in the browser. Great if you're new to programming entirely.
   - https://gdquest.github.io/learn-gdscript/

3. **Godot Game Developer Roadmap (2026)** — An interactive checklist you can use to track what you've learned.
   - https://godot-roadmap.vercel.app/roadmap

4. **Brackeys Godot Beginner Series (YouTube)** — Highly recommended video series for visual learners.
   - Search "Brackeys Godot" on YouTube

### Milestone
> You can create a scene with a character that moves around using keyboard input, and a button that prints text to the console.

---

## Phase 1: The Overworld Map Prototype (1–2 weeks)

This is the connective tissue of your whole game. Build it first because every other system plugs into it.

### What to build

- A simple 2D sideview map
- A player character that can walk around
- Interactable icons/zones on the map (one for each minigame/activity)
- Walking into a zone triggers a scene transition

### Key concepts to learn

- **TileMap or simple sprite-based map layout**
- **Area2D and collision detection** (for triggering zone entries)
- **Scene switching** (changing from the overworld to a minigame scene and back)
- **CharacterBody2D** for player movement

### Tutorials to look up

- Godot docs: "Your First 2D Game" (official tutorial)
  - https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html
- Search YouTube: "Godot 4 scene switching tutorial"
- Search YouTube: "Godot 4 top down movement tutorial"

### Milestone
> A character walks around a map with colored rectangles as placeholders. Walking into a rectangle loads a different scene (even if that scene is just a label that says "Tennis Match" or "Shop").

---

## Phase 2: The Shop — Core Loop (2–3 weeks)

This is the heart of your game, the Tiny Bookshop equivalent. Get this working with placeholder everything.

### What to build (in order)

1. **Inventory system**: A data structure that tracks what items your shop has in stock (balls, rackets, shoes, etc.), quantities, and prices
2. **Customer system**: Customers arrive, browse, and want to buy something. Start with random customers who want random items.
3. **Buy/sell interaction**: Player can complete or reject a sale. Money goes up.
4. **Customer preferences**: When a customer likes an item, store that preference (this is your "stored favorites" mechanic)
5. **Basic shop UI**: Show your inventory, current money, and incoming customer requests

### Key concepts to learn

- **Resource files** in Godot (great for defining item types, customer data)
- **Dictionaries and arrays** in GDScript for inventory management
- **Signals** for connecting UI to game logic
- **Control nodes** for building the shop interface (VBoxContainer, HBoxContainer, Labels, Buttons)
- **Save/Load basics** so progress persists between sessions

### Tutorials to look up

- Godot docs: "Saving Games" — https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
- GDQuest: "Saving and Loading Games in Godot 4" — https://www.gdquest.com/library/save_game_godot4/
- Search YouTube: "Godot 4 inventory system tutorial"
- Search YouTube: "Godot 4 shop system tutorial"
- KidsCanCode Godot 4 Recipes (great for quick how-to snippets) — https://kidscancode.org/godot_recipes/4.x/

### Milestone
> Customers appear with requests. You can sell them items from your inventory. Money increases. Customer preferences are saved. You can close and reopen the game without losing progress.

---

## Phase 3: Location/Level System (1–2 weeks)

Now connect the shop to your progression system.

### What to build

1. **Location data**: Define several locations (local park, club, ATP/WTA tournament, Grand Slam) with properties like unlock cost, customer types, and difficulty
2. **Shop upgrade system**: Track shop quality/level. Better shop = access to better locations.
3. **Location selection screen**: Player picks where to travel next (or it's shown on the overworld map)
4. **Location-specific customers**: Different locations spawn different customer types with different demands

### Key concepts to learn

- **Exported variables and Resource files** for defining location data
- **State machines** (simple ones) for tracking game progression
- **Conditional logic** for gating content behind upgrades

### Milestone
> You start at a local park selling basic items. After earning enough money and upgrading your shop, you unlock a club event, then a tournament. Each location has different customers wanting different things.

---

## Phase 4: First Minigame — Tennis Match (2–3 weeks)

Pick the most essential minigame and build it. The tennis match is the most thematic, so start there.

### What to build

1. **A simple 2D tennis court** (top-down or side-view, placeholder art)
2. **Player-controlled character** that can move and swing
3. **Ball physics**: Ball moves, bounces, responds to hits
4. **Opponent AI**: A basic opponent that returns the ball (start very simple — just move toward the ball and hit it back)
5. **Scoring system**: Track points, games, sets
6. **Win/lose condition** that returns you to the overworld

### Key concepts to learn

- **RigidBody2D or custom ball physics** (depending on how you want the ball to feel)
- **State machines for match flow** (serving, rally, point scored, game over)
- **Basic AI** (move toward ball, swing when close)
- **AnimationPlayer** for swing animations (even with placeholder sprites)

### Tutorials to look up

- Search YouTube: "Godot 4 pong tutorial" (Pong is essentially simplified tennis — great starting point)
- Search YouTube: "Godot 4 simple enemy AI"
- Search YouTube: "Godot 4 state machine tutorial"

### Milestone
> You can play a basic tennis rally against an AI opponent. Points are scored. A match can be won or lost. Winning returns you to the map.

---

## Phase 5: Additional Minigames (1–2 weeks each)

Build the remaining minigames one at a time. Each one is a self-contained scene.

### Driving Minigame
- Could be a simple top-down driving game or an endless-runner-style road
- Focus: Steering, avoiding obstacles, reaching a destination
- Search YouTube: "Godot 4 top down car movement"

### Making Lunch
- Could be a simple drag-and-drop or timed cooking game
- Focus: Dragging ingredients, timer mechanics, recipe matching
- Search YouTube: "Godot 4 drag and drop tutorial"

### Training Game
- Could be a rhythm-based or timing-based minigame (like hitting targets)
- Focus: Timing windows, score tracking
- Training results could buff your tennis match performance

### Milestone
> Each minigame is playable from the overworld map. They don't need to be perfect — just functional and fun enough to test.

---

## Phase 6: Keystone Customers & Storyline (1–2 weeks)

### What to build

1. **Named NPC characters** with portraits (placeholder) and dialogue
2. **A simple dialogue system** (text box that shows lines of dialogue, advances on click)
3. **Story flags**: Track which story events have happened (e.g., "met Coach Rick", "helped Maria find racket")
4. **Trigger story beats** based on shop level, location, or items sold

### Tutorials to look up

- Search YouTube: "Godot 4 dialogue system tutorial"
- Look into the **Dialogic** addon for Godot (a popular free dialogue plugin)
  - https://github.com/dialogic-godot/dialogic

### Milestone
> A few named characters appear at certain locations. They have short dialogue sequences. Their storylines advance as you progress.

---

## Phase 7: Renting System (1 week)

You mentioned renting in your notes. This can layer on top of your existing shop.

### What to build

1. **Rental inventory** (separate from sale inventory): Items that get lent out and returned
2. **Rental timer**: Items come back after X days/turns
3. **Rental income**: Recurring income from rented items
4. **Risk mechanic** (optional): Sometimes items come back damaged

### Milestone
> Players can choose to rent or sell items. Rented items return after a set period. Rental income adds a strategic layer to shop management.

---

## Phase 8: Polish, Art & Music (Ongoing, but focused last)

Only after everything above is working with placeholders do you focus on visuals and audio.

### Art tasks

- Player character sprite + walk animations
- Tennis ball, racket, and item sprites
- Shop interior background
- Customer character sprites (a few unique ones for keystone characters, generic ones for random customers)
- Overworld map tiles/background
- Minigame-specific art (tennis court, car, kitchen, training area)
- UI elements (buttons, panels, icons)

### Music & sound

- Shop background music
- Overworld map music
- Minigame music (one track per minigame)
- Sound effects (selling items, hitting tennis ball, UI clicks, customer arrival)

### Where to find assets (if you're not making your own)

- **Kenney.nl** — Huge library of free game assets
- **OpenGameArt.org** — Community-contributed free assets
- **itch.io free assets** — Search "free game assets" on itch.io
- **Pixabay** — Free music and sound effects

---

## General Tips for Your First Game

1. **Use placeholder art from day one.** Colored rectangles, circles, and simple shapes are fine. Don't let "I need art first" slow you down.

2. **Test constantly.** After every small change, run the game and make sure it works. Don't build 500 lines of code before testing.

3. **Scope small, then expand.** Your instinct to prototype first is exactly right. A working ugly game is infinitely more valuable than a beautiful broken one.

4. **Use version control (Git).** Even as a solo developer. It saves you when things break. GitHub Desktop makes it easy if you're new to Git.

5. **Keep a devlog.** Even a simple text file where you write what you did each session. It helps you stay motivated and track progress.

6. **Join the Godot community.** The Godot Discord, Reddit (r/godot), and the official forums are all active and beginner-friendly.

---

## Estimated Total Timeline

| Phase | Time Estimate |
|-------|--------------|
| Phase 0: Learn Godot Basics | 1–2 weeks |
| Phase 1: Overworld Map | 1–2 weeks |
| Phase 2: Shop Core Loop | 2–3 weeks |
| Phase 3: Location/Level System | 1–2 weeks |
| Phase 4: Tennis Minigame | 2–3 weeks |
| Phase 5: Other Minigames | 3–6 weeks |
| Phase 6: Story & Characters | 1–2 weeks |
| Phase 7: Renting System | 1 week |
| Phase 8: Art & Music | Ongoing |
| **Total to playable prototype (Phases 0–4):** | **~7–12 weeks** |

These are rough estimates assuming you're learning as you go and working on this part-time. Your mileage will vary — and that's totally fine.

---

## Key Tutorial & Resource Links (Quick Reference)

- Official Godot Docs: https://docs.godotengine.org/en/stable/
- GDQuest Learn GDScript From Zero: https://gdquest.github.io/learn-gdscript/
- Godot Roadmap Tracker: https://godot-roadmap.vercel.app/roadmap
- Godot 4 Recipes: https://kidscancode.org/godot_recipes/4.x/
- Saving Games (Official): https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
- GDQuest Save/Load: https://www.gdquest.com/library/save_game_godot4/
- Dialogic (Dialogue Plugin): https://github.com/dialogic-godot/dialogic
- Kenney Free Assets: https://kenney.nl
- OpenGameArt: https://opengameart.org
- Itch.io Free Assets: https://itch.io/game-assets/free
