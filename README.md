
Load your data more beautiful.


## Installation

You just need to add ```animated_progress``` as a dependency in your pubspec.yaml file.

```dart
dependencies:
  animated_progress: ^0.0.1
```

## Getting started

All features you can use :<br><br>

![full](https://github.com/edris-mazhari/animated_progress/assets/91206674/9edb61db-1c38-4f44-a7ed-e5e9b2390a6f)


## How To Use

![first](https://github.com/edris-mazhari/animated_progress/assets/91206674/628d0ec4-cc45-4862-9209-86b6838f7898)

```dart
AnimatedProgress().circular(
                    isSpining: true,
                    value: .5, // The value of progrees. Default is 0.5
                    backgroundColor: Colors.green.shade100, // Background color
                    valueColor: Colors.green.shade900, // Progress color
                  ),
```

![second](https://github.com/edris-mazhari/animated_progress/assets/91206674/0233fd35-f82d-46f6-93f2-09ae51ab0a1d)

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

![thirdAndForth](https://github.com/edris-mazhari/animated_progress/assets/91206674/c4635689-360b-45a5-81f0-ceef7e7b457e)


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
