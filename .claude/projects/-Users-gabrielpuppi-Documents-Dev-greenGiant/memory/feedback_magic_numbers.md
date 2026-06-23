---
name: feedback_magic_numbers
description: Magic numbers in physics/gameplay code are intentional — they were hand-tuned during playtesting and should not be treated as cleanup targets
metadata:
  type: feedback
---

Don't flag hardcoded numeric values (branch mass multipliers, rotation values, timing thresholds, score increments, camera velocity, etc.) as technical debt or suggest extracting them to constants.

**Why:** These values (e.g. 0.15s sprint threshold, 1.2 score per tap, ×1–4 branch mass randomness, camera +7 velocity per 5 points) were deliberately tuned through playtesting to get the physics and game feel right. They are not accidental — they are the result of iteration.

**How to apply:** When reviewing or suggesting changes to gameplay-affecting numbers in DifficultyManager, Branch, Trunk, GameScene, or any physics-related code, do not recommend extracting to constants or call them magic numbers. Only flag a number if it causes an actual bug.
