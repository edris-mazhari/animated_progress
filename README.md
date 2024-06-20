
Load your data more beautiful.


## Installation

You just need to add ```animated_progress``` as a dependency in your pubspec.yaml file.

```dart
dependencies:
  animated_progress: ^0.0.1
```

## Getting started

All features you can use :<br><br>

![full](https://github.com/edris-mazhari/animated_progress/assets/91206674/5e78983c-a850-4104-86da-aaa27e01401f)


## How To Use

![first](https://github.com/edris-mazhari/animated_progress/assets/91206674/1c25ccc8-a37c-40c3-8055-59e0097a69f8)

```dart
AnimatedProgress().circular(
                    isSpining: true,
                    value: .5, // The value of progrees. Default is 0.5
                    backgroundColor: Colors.green.shade100, // Background color
                    valueColor: Colors.green.shade900, // Progress color
                  ),
```

![second](https://github.com/edris-mazhari/animated_progress/assets/91206674/7d0694ad-e0b0-46b6-bb10-f612c95bed59)

```dart
AnimatedProgress().circular(
                    isSpining: true,
                    value: .5, // The value of progrees. Default is 0.5
                    valueColor: Colors.green.shade900, // Progress color
                    secondaryWidth : 5 , // Secondary width
                    secondaryColor :Colors.green.shade500, // Secondary color
                  ),
```

## Other Circular Progress Features

```dart
spinDuration  // Animation Duration
backgroundBorder // You Can Set Border With Your Customization
backgroundShape // Background Shape : BoxShape.rectangle
backgroundRadius // This Feature Only Works With BoxShape.rectangle
```

![thirdandforth](https://github.com/edris-mazhari/animated_progress/assets/91206674/d5a0871d-a1ea-4db1-bbb3-770fe644f50a)

```dart
AnimatedProgress().linear(
    height: 10,
    width: MediaQuery.of(context).size.width,
    value: .5, // The value of progrees. Default is 0.5
    valueColor: Colors.green.shade900,// Progress color
    backgroundColor: Colors.green.shade100, // Background color
    ),
```
## Linear With Secondary Value

```dart
AnimatedProgress().linear(
    height: 10,
    width: MediaQuery.of(context).size.width * .8,
    value: .5, // The value of progrees. Default is 0.5
    valueColor: Colors.green.shade900,// Progress color
    backgroundColor: Colors.green.shade100, // Background color
    secondaryValue: .7,// The value of progrees. Default is 0
    secondaryValueColor: fgColor.withAlpha(100), // Progress color
    ),
```

## Other Linear Progress Features

```dart
boxShadow  // You Can Set Shadow
border // You Can Set Border With Your Customization
valueAnimationDuration // Duration Of Animation
direction // Use LinearDirection.leftToRight Or LinearDirection.rightToLeft
```
