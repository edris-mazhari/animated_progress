
Load your data more beautiful.


## Installation

You just need to add ```animated_progress``` as a dependency in your pubspec.yaml file.

```dart
dependencies:
  animated_progress: ^0.0.1
```

## Getting started

All features you can use :<br><br>





```dart
AnimatedProgress().circular(
                    isSpining: true,
                    value: .5, // The value of progrees. Default is 0.5
                    backgroundColor: Colors.green.shade100, // Background color
                    valueColor: Colors.green.shade900, // Progress color
                  ),
```



 
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



```dart
AnimatedProgress().linear(
    height: 10,
    width: MediaQuery.of(context).size.width,
    value: .5, // The value of progrees. Default is 0.5
    valueColor: Colors.green.shade900,// Progress color
    backgroundColor: Colors.green.shade100, // Background color
    ),
```




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
