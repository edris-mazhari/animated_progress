library animated_progress;

import 'package:flutter/material.dart';
import 'dart:math' as math;

enum LinearDirection {
  leftToRight,
  righToLeft,
}

class AnimatedProgress {
  Widget linear({
    required double width,
    required double height,
    required double value,
    Color valueColor = Colors.green,
    Color backgroundColor = Colors.white,
    BoxShadow? boxShadow,
    Border? border,
    double borderRadius = 50,
    Duration valueAnimationDuration = const Duration(milliseconds: 500),
    LinearDirection direction = LinearDirection.leftToRight,
  }) {
    double realValue = 0;
    if (value < 0) {
      realValue = 0;
    } else if (value > 1) {
      realValue = 1;
    } else {
      realValue = value;
    }
    double valueWidth = width * realValue;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                      child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: backgroundColor,
                        border: border,
                        boxShadow: boxShadow == null ? [] : [boxShadow]),
                  )),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: direction == LinearDirection.leftToRight ? 0 : null,
                      right: direction == LinearDirection.righToLeft ? 0 : null,
                      child: AnimatedContainer(
                        width: valueWidth,
                        duration: valueAnimationDuration,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          color: valueColor,
                        ),
                      )),
                ],
              )),
        ),
      ],
    );
  }

  Widget circular(
      {bool? isSpining,
      bool? hasSpinReverse,
      double? value,
      double? valueWidth,
      Color? secondaryColor,
      double? secondaryWidth,
      double? width,
      Duration? spinDuration,
      Color? valueColor,
      BoxShape? backgroundShape,
      Border? backgroundBorder,
      EdgeInsets? padding,
      EdgeInsets? margin,
      double? backgroundRadius,
      Color? backgroundColor,
      double? height}) {
    return AnimatedCircularProgress(
      height: height,
      isSpining: isSpining,
      secondaryColor: secondaryColor,
      secondaryWidth: secondaryWidth,
      value: value,
      valueColor: valueColor,
      valueWidth: valueWidth,
      spinDuration: spinDuration,
      width: width,
      hasSpinReverse: hasSpinReverse,
      backgrounShape: backgroundShape,
      backgroundBorder: backgroundBorder,
      backgroundColor: backgroundColor,
      backgroundRadius: backgroundRadius,
      margin: margin,
      padding: padding,
    );
  }
}

class AnimatedCircularProgress extends StatefulWidget {
  const AnimatedCircularProgress(
      {this.isSpining = true,
      this.valueColor,
      this.valueWidth,
      this.secondaryColor = Colors.transparent,
      this.secondaryWidth,
      this.value,
      this.height,
      this.hasSpinReverse,
      this.width,
      this.spinDuration,
      this.backgrounShape,
      this.backgroundColor,
      this.backgroundRadius,
      this.margin,
      this.padding,
      this.backgroundBorder,
      super.key});
  final bool? isSpining;
  final bool? hasSpinReverse;
  final double? value;
  final Color? valueColor;
  final double? valueWidth;
  final Color? secondaryColor;
  final double? secondaryWidth;
  final double? backgroundRadius;
  final Color? backgroundColor;
  final BoxShape? backgrounShape;
  final Border? backgroundBorder;
  final double? width;
  final double? height;
  final Duration? spinDuration;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  State<AnimatedCircularProgress> createState() => _NormalCircularProgressIndState();
}

class _NormalCircularProgressIndState extends State<AnimatedCircularProgress>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: widget.spinDuration ?? const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: math.pi * 2.0).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSpining == true) {
      animationController.repeat();
    } else {
      animationController.stop();
    }
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: widget.margin,
        padding: widget.padding,
        decoration: BoxDecoration(
            shape: widget.backgrounShape ?? BoxShape.circle,
            color: widget.backgroundColor ?? Colors.transparent,
            border: widget.backgroundBorder,
            borderRadius: widget.backgroundRadius != null
                ? BorderRadius.circular(widget.backgroundRadius ?? 10)
                : null),
        width: widget.width ?? 50,
        height: widget.height ?? 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              strokeAlign: BorderSide.strokeAlignCenter,
              strokeWidth: widget.secondaryWidth ?? 0,
              value: widget.secondaryWidth == null ? 0 : 1,
              valueColor: AlwaysStoppedAnimation(widget.secondaryColor),
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.rotate(
                angle: animation.value,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: widget.value ?? .5),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, child) => TweenAnimationBuilder(
                    tween: ColorTween(begin: Colors.white, end: widget.valueColor ?? Colors.purple),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, col, child) => CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      strokeWidth: widget.valueWidth ?? 3,
                      value: value,
                      valueColor: AlwaysStoppedAnimation(col),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
