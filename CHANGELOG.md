# Changelog

## 1.0.1

- **Fixed:** `LinearProgress` no longer crashes with infinite width assertion when placed inside a card or constrained layout (replaced `double.infinity * fraction` with `FractionallySizedBox` + `Positioned.fill`).
- **Fixed:** `LinearProgress` no longer throws `!semantics.parentDataDirty` assertion (replaced `AnimatedBuilder` inside `Positioned` with a `setState` listener on `AnimationController`).

## 1.0.0

- **Breaking:** Replaced `AnimatedProgress().circular()` with a declarative `CircularProgress(...)` widget.
- **Breaking:** Replaced `AnimatedProgress().linear()` with a declarative `LinearProgress(...)` widget.
- **Breaking:** Renamed parameters for consistency (`valueWidth` → `strokeWidth`, `secondaryColor` → `trackColor`, etc.).
- Added smooth value transitions via `AnimationController` with configurable `duration` and `curve`.
- Added `ProgressController` for programmatic play/pause control.
- Added `valueGradient` and `backgroundGradient` for gradient-filled arcs and backgrounds.
- Added `CustomPainter`-based rendering for gradient progress arcs.
- Added `spinning` and `reverseSpin` for continuous circular rotation.
- Added `strokeCap` customization for circular progress.
- Added `child` widget support in the center of circular progress.
- Added `onCompleted` callback for animations.
- Improved `LinearProgress` with color animation, gradient support, and proper animation lifecycle.
- Added comprehensive widget tests.
- Cleaned up code structure with proper separation of concerns (`lib/src/`).
