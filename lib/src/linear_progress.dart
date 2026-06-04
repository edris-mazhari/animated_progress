import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

import 'progress_controller.dart';

enum LinearDirection { leftToRight, rightToLeft }

class LinearProgress extends StatefulWidget {
  final double value;
  final double secondaryValue;
  final Color valueColor;
  final Gradient? valueGradient;
  final Color secondaryValueColor;
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final double height;
  final double? width;
  final double borderRadius;
  final BoxBorder? border;
  final BoxShadow? boxShadow;
  final LinearDirection direction;
  final Duration duration;
  final Curve curve;
  final ProgressController? controller;
  final VoidCallback? onCompleted;

  const LinearProgress({
    super.key,
    this.value = 0,
    this.secondaryValue = 0,
    this.valueColor = Colors.green,
    this.valueGradient,
    this.secondaryValueColor = Colors.lightGreen,
    this.backgroundColor = Colors.white,
    this.backgroundGradient,
    this.height = 10,
    this.width,
    this.borderRadius = 50,
    this.border,
    this.boxShadow,
    this.direction = LinearDirection.leftToRight,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.controller,
    this.onCompleted,
  }) : assert(value >= 0 && value <= 1,
         'value must be between 0.0 and 1.0'),
       assert(secondaryValue >= 0 && secondaryValue <= 1,
         'secondaryValue must be between 0.0 and 1.0');

  @override
  State<LinearProgress> createState() => _LinearProgressState();
}

class _LinearProgressState extends State<LinearProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _valueAnimation;
  late Animation<double> _secondaryAnimation;
  late Animation<Color?> _valueColorAnimation;
  late Animation<Color?> _secondaryColorAnimation;

  double _prevValue = 0;
  double _prevSecondary = 0;
  Color _prevValueColor = Colors.green;
  Color _prevSecondaryColor = Colors.lightGreen;
  bool _playing = true;

  @override
  void initState() {
    super.initState();
    _prevValue = widget.value;
    _prevSecondary = widget.secondaryValue;
    _prevValueColor = widget.valueColor;
    _prevSecondaryColor = widget.secondaryValueColor;
    _setupAnimations();
    _bindController();
  }

  @override
  void didUpdateWidget(LinearProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      _bindController();
    }
    _animateTo(
      oldWidget.value != widget.value ? widget.value : null,
      oldWidget.secondaryValue != widget.secondaryValue ? widget.secondaryValue : null,
      oldWidget.valueColor != widget.valueColor ? widget.valueColor : null,
      oldWidget.secondaryValueColor != widget.secondaryValueColor ? widget.secondaryValueColor : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.controller?.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _bindController() {
    widget.controller?.addListener(_onControllerChanged);
    if (widget.controller != null) {
      _playing = widget.controller!.isPlaying;
    }
  }

  void _onControllerChanged() {
    final playing = widget.controller?.isPlaying ?? true;
    if (playing != _playing) {
      setState(() => _playing = playing);
    }
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() => setState(() {}));

    _valueAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    )..addListener(() {
      if (_controller.isCompleted) widget.onCompleted?.call();
    });

    _secondaryAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _valueColorAnimation = ColorTween(
      begin: _prevValueColor,
      end: widget.valueColor,
    ).animate(_controller);

    _secondaryColorAnimation = ColorTween(
      begin: _prevSecondaryColor,
      end: widget.secondaryValueColor,
    ).animate(_controller);

    if (_playing && _controller.value == 0) {
      _controller.forward();
    }
  }

  void _animateTo(
    double? newValue,
    double? newSecondary,
    Color? newValueColor,
    Color? newSecondaryColor,
  ) {
    if (newValue != null) {
      _prevValue = _currentValue;
    }
    if (newSecondary != null) {
      _prevSecondary = _currentSecondary;
    }
    if (newValueColor != null) {
      _prevValueColor = _currentValueColor;
    }
    if (newSecondaryColor != null) {
      _prevSecondaryColor = _currentSecondaryColor;
    }

    _controller.reset();

    _valueAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _secondaryAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _valueColorAnimation = ColorTween(begin: _prevValueColor, end: widget.valueColor).animate(_controller);
    _secondaryColorAnimation = ColorTween(begin: _prevSecondaryColor, end: widget.secondaryValueColor).animate(_controller);

    if (_playing) {
      _controller.forward();
    }
  }

  double get _currentValue => lerpDouble(_prevValue, widget.value, _valueAnimation.value) ?? widget.value;
  double get _currentSecondary => lerpDouble(_prevSecondary, widget.secondaryValue, _secondaryAnimation.value) ?? widget.secondaryValue;
  Color get _currentValueColor => _valueColorAnimation.value ?? widget.valueColor;
  Color get _currentSecondaryColor => _secondaryColorAnimation.value ?? widget.secondaryValueColor;

  @override
  Widget build(BuildContext context) {
    final animate = _controller.isAnimating || _controller.value < 1;
    final val = animate ? _currentValue : widget.value;
    final secVal = animate ? _currentSecondary : widget.secondaryValue;
    final valCol = animate ? _currentValueColor : widget.valueColor;
    final secCol = animate ? _currentSecondaryColor : widget.secondaryValueColor;

    final clampedVal = val.clamp(0.0, 1.0);
    final clampedSec = secVal.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundGradient == null ? widget.backgroundColor : null,
          gradient: widget.backgroundGradient,
          border: widget.border,
          boxShadow: widget.boxShadow != null ? [widget.boxShadow!] : null,
        ),
        child: Stack(
          children: [
            if (clampedSec > 0)
              Positioned.fill(
                child: Align(
                  alignment: widget.direction == LinearDirection.leftToRight
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: clampedSec,
                    child: _bar(secCol),
                  ),
                ),
              ),
            if (clampedVal > 0)
              Positioned.fill(
                child: Align(
                  alignment: widget.direction == LinearDirection.leftToRight
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: clampedVal,
                    child: _bar(valCol),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _bar(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: widget.valueGradient == null ? color : null,
        gradient: widget.valueGradient,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
    );
  }
}
