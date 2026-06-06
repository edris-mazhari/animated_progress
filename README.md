A beautifully animated progress library for Flutter — smooth linear & circular progress bars with gradients, spinning, value transitions, and programmatic control.

![Demo](https://raw.githubusercontent.com/edris-mazhari/animated_progress/main/screenshots/demo.gif)

---

## Features

| Feature | Description |
|---|---|
| **Linear & Circular** | Both progress bar types in one package |
| **Smooth Transitions** | Animated value/color changes via `AnimationController` with configurable `duration` & `curve` |
| **Gradient Arcs** | `valueGradient` for gradient-filled progress arcs (SweepGradient, RadialGradient, etc.) |
| **Background Gradients** | `backgroundGradient` for decorated containers |
| **Spinning (Circular)** | Continuous rotation effect with configurable direction and speed |
| **Animation Control** | `ProgressController` lets you play, pause, and resume animations |
| **Secondary Value (Linear)** | Two stacked values for comparison |
| **Center Child (Circular)** | Place any widget in the center of the ring |
| **Callbacks** | `onCompleted` fires when an animation reaches its target |
| **Direction (Linear)** | Left-to-right or right-to-left |

---

## Installation

```yaml
dependencies:
  animated_progress: ^1.0.1
```

Then import:

```dart
import 'package:animated_progress/animated_progress.dart';
```

---

## Usage

### Linear — Basic

```dart
LinearProgress(
  value: 0.65,
  height: 12,
  valueColor: Colors.green.shade900,
  backgroundColor: Colors.green.shade100,
)
```

### Linear — With secondary value

```dart
LinearProgress(
  value: 0.5,
  secondaryValue: 0.75,
  valueColor: Colors.green.shade900,
  secondaryValueColor: Colors.green.shade300,
  backgroundColor: Colors.green.shade100,
  height: 12,
)
```

### Linear — Right to left

```dart
LinearProgress(
  value: 0.6,
  direction: LinearDirection.rightToLeft,
  valueColor: Colors.blue,
  backgroundColor: Colors.blue.shade100,
  height: 12,
)
```

### Linear — Gradient

```dart
LinearProgress(
  value: 0.8,
  height: 14,
  borderRadius: 8,
  valueGradient: const LinearGradient(
    colors: [Colors.purple, Colors.pink],
  ),
  backgroundGradient: const LinearGradient(
    colors: [Colors.purple.shade50, Colors.pink.shade50],
  ),
)
```

### Linear — With box shadow

```dart
LinearProgress(
  value: 0.5,
  height: 14,
  valueColor: Colors.orange,
  backgroundColor: Colors.orange.shade50,
  boxShadow: BoxShadow(
    color: Colors.orange.withValues(alpha: 0.3),
    blurRadius: 4,
    offset: Offset(0, 2),
  ),
)
```

### Circular — Basic determinate

```dart
CircularProgress(
  value: 0.65,
  size: 80,
  valueColor: Colors.indigo,
  trackColor: Colors.grey.shade200,
)
```

### Circular — Indeterminate

Set `value` to `null`:

```dart
CircularProgress(
  size: 80,
  valueColor: Colors.pink,
  trackColor: Colors.deepPurple.shade900,
)
```

### Circular — With spinning

```dart
CircularProgress(
  value: 0.4,
  size: 80,
  spinning: true,
  spinDuration: Duration(seconds: 3),
  valueColor: Colors.pink,
  trackColor: Colors.deepPurple.shade900,
)
```

### Circular — Gradient arc

```dart
CircularProgress(
  value: 0.7,
  size: 80,
  valueGradient: SweepGradient(
    colors: [Colors.indigo, Colors.cyan, Colors.indigo],
  ),
  trackColor: Colors.grey.shade200,
)
```

### Circular — With background gradient

```dart
CircularProgress(
  value: 0.5,
  size: 80,
  valueGradient: SweepGradient(
    colors: [Colors.green, Colors.lime, Colors.green],
  ),
  backgroundGradient: LinearGradient(
    colors: [Colors.lightGreen, Colors.white],
  ),
  backgroundShape: BoxShape.rectangle,
  backgroundBorderRadius: BorderRadius.circular(12),
  trackColor: Colors.grey.shade300,
)
```

### Circular — With center child

```dart
CircularProgress(
  value: 0.75,
  size: 120,
  strokeWidth: 8,
  trackWidth: 12,
  valueColor: Colors.indigo,
  trackColor: Colors.grey.shade200,
  child: Text('75%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
)
```

### With animation controller

```dart
final _controller = ProgressController();

// Pass to either LinearProgress or CircularProgress:
CircularProgress(
  value: 0.5,
  size: 80,
  controller: _controller,
)

// Control anywhere:
_controller.pause();
_controller.resume();
_controller.togglePlay();
```

---

## API Reference

### `CircularProgress`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `value` | `double?` | `null` | Progress 0.0–1.0; `null` for indeterminate |
| `valueColor` | `Color?` | `Colors.purple` | Progress arc color (ignored when `valueGradient` is set) |
| `valueGradient` | `Gradient?` | `null` | Gradient for progress arc (overrides `valueColor`) |
| `strokeWidth` | `double` | `6.0` | Width of the progress arc |
| `trackColor` | `Color?` | `null` | Background track ring color |
| `trackWidth` | `double` | `10.0` | Width of the track ring |
| `strokeCap` | `StrokeCap` | `StrokeCap.round` | Cap style of the progress arc |
| `spinning` | `bool` | `false` | Continuously rotate the indicator |
| `reverseSpin` | `bool` | `false` | Reverse spin direction |
| `spinDuration` | `Duration?` | `2s` | Duration of one full spin |
| `duration` | `Duration?` | `300ms` | Value transition duration |
| `curve` | `Curve` | `Curves.easeInOut` | Value transition curve |
| `size` | `double?` | `null` | Widget diameter |
| `backgroundColor` | `Color?` | `null` | Background fill color |
| `backgroundGradient` | `Gradient?` | `null` | Background gradient (overrides `backgroundColor`) |
| `backgroundShape` | `BoxShape` | `BoxShape.circle` | Background container shape |
| `backgroundBorder` | `BoxBorder?` | `null` | Background border |
| `backgroundBorderRadius` | `BorderRadiusGeometry?` | `null` | Border radius (rectangle only) |
| `padding` | `EdgeInsetsGeometry` | `zero` | Padding between background and rings |
| `margin` | `EdgeInsetsGeometry` | `zero` | Margin outside background |
| `child` | `Widget?` | `null` | Center widget |
| `controller` | `ProgressController?` | `null` | Programmatic animation control |
| `quarterTurns` | `int` | `0` | Rotate the progress ring |
| `onCompleted` | `VoidCallback?` | `null` | Called when animation reaches target |

### `LinearProgress`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `value` | `double` | `0` | Progress 0.0–1.0 |
| `secondaryValue` | `double` | `0` | Secondary progress bar |
| `valueColor` | `Color` | `Colors.green` | Progress bar color |
| `valueGradient` | `Gradient?` | `null` | Gradient for the progress bar |
| `secondaryValueColor` | `Color` | `Colors.lightGreen` | Secondary bar color |
| `backgroundColor` | `Color` | `Colors.white` | Background color |
| `backgroundGradient` | `Gradient?` | `null` | Background gradient |
| `height` | `double` | `10` | Bar height |
| `width` | `double?` | `null` | Bar width (infinite if null) |
| `borderRadius` | `double` | `50` | Border radius |
| `border` | `BoxBorder?` | `null` | Border around the bar |
| `boxShadow` | `BoxShadow?` | `null` | Shadow |
| `direction` | `LinearDirection` | `leftToRight` | Fill direction |
| `duration` | `Duration` | `500ms` | Animation duration |
| `curve` | `Curve` | `Curves.easeInOut` | Animation curve |
| `controller` | `ProgressController?` | `null` | Programmatic control |
| `onCompleted` | `VoidCallback?` | `null` | Called when animation reaches target |

### `ProgressController`

| Method | Description |
|---|---|
| `play()` | Start / resume |
| `pause()` | Pause |
| `resume()` | Alias for `play()` |
| `togglePlay()` | Toggle play/pause |

| Property | Type | Description |
|---|---|---|
| `isPlaying` | `bool` | Whether animations are playing |

---

> **1.0.1** includes only bug fixes — no breaking changes from 1.0.0.

## Migration from 0.x

| 0.x | 1.x |
|---|---|
| `AnimatedProgress().circular(...)` | `CircularProgress(...)` |
| `AnimatedProgress().linear(...)` | `LinearProgress(...)` |
| `valueWidth` | `strokeWidth` |
| `secondaryColor` (circular) | `trackColor` |
| `secondaryWidth` (circular) | `trackWidth` |
| `isSpining` *(sic)* | `spinning` |
| `spinDuration` (circular) | `spinDuration` (unchanged) |
| `backgroundRadius` (circular) | `backgroundBorderRadius` |
| `backgroundShape` *(typo)* | `backgroundShape` |
| `valueAnimationDuration` (linear) | `duration` |
| `secondaryValue` (linear) | `secondaryValue` (unchanged) |
