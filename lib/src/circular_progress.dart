import 'dart:math';
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

import 'progress_controller.dart';

class CircularProgress extends StatefulWidget {
  final double? value;
  final Color? valueColor;
  final Gradient? valueGradient;
  final double strokeWidth;
  final Color? trackColor;
  final double trackWidth;
  final StrokeCap strokeCap;
  final bool spinning;
  final bool reverseSpin;
  final Duration? spinDuration;
  final Duration? duration;
  final Curve curve;
  final double? size;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final BoxShape backgroundShape;
  final BoxBorder? backgroundBorder;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry? backgroundBorderRadius;
  final Widget? child;
  final ProgressController? controller;
  final int quarterTurns;
  final VoidCallback? onCompleted;

  const CircularProgress({
    super.key,
    this.value,
    this.valueColor,
    this.valueGradient,
    this.strokeWidth = 6.0,
    this.trackColor,
    this.trackWidth = 10.0,
    this.strokeCap = StrokeCap.round,
    this.spinning = false,
    this.reverseSpin = false,
    this.spinDuration,
    this.duration,
    this.curve = Curves.easeInOut,
    this.size,
    this.backgroundColor,
    this.backgroundGradient,
    this.backgroundShape = BoxShape.circle,
    this.backgroundBorder,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.backgroundBorderRadius,
    this.child,
    this.controller,
    this.quarterTurns = 0,
    this.onCompleted,
  }) : assert(
         value == null || (value >= 0.0 && value <= 1.0),
         'value must be between 0.0 and 1.0, or null for indeterminate.',
       );

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress>
    with TickerProviderStateMixin {
  AnimationController? _valueController;
  AnimationController? _spinController;
  AnimationController? _indeterminateController;
  double? _fromValue;
  double? _toValue;
  double _spinRadians = 0.0;
  double _indeterminateValue = 0.0;
  bool _playing = true;

  @override
  void initState() {
    super.initState();
    _toValue = widget.value;
    _fromValue = widget.value;
    _setupValueController();
    _setupIndeterminateController();
    _setupSpinController();
    _bindController();
  }

  @override
  void didUpdateWidget(CircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animateToValue(widget.value);
    }
    if (oldWidget.spinning != widget.spinning ||
        oldWidget.spinDuration != widget.spinDuration) {
      _setupSpinController();
    }
    if (oldWidget.valueGradient != widget.valueGradient ||
        (oldWidget.value != null) != (widget.value != null)) {
      _setupIndeterminateController();
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      _bindController();
    }
  }

  @override
  void dispose() {
    _valueController?.dispose();
    _spinController?.dispose();
    _indeterminateController?.dispose();
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
      setState(() {
        _playing = playing;
        if (_playing) {
          _resumeAnimations();
        } else {
          _pauseAnimations();
        }
      });
    }
  }

  void _setupValueController() {
    _valueController?.dispose();
    _valueController = null;
    if (widget.value != null) {
      _valueController = AnimationController(
        vsync: this,
        duration: widget.duration ?? const Duration(milliseconds: 300),
      )..addListener(_onValueAnimUpdate)
       ..addStatusListener(_onValueAnimStatus);
    }
  }

  void _animateToValue(double? newValue) {
    if (newValue == null) {
      setState(() {
        _toValue = null;
        _fromValue = null;
      });
      _valueController?.dispose();
      _valueController = null;
      _setupIndeterminateController();
      return;
    }
    _fromValue = _toValue;
    _toValue = newValue;
    _setupValueController();
    _indeterminateController?.dispose();
    _indeterminateController = null;
    if (_playing && _valueController != null) {
      _valueController!.forward(from: 0.0);
    }
  }

  void _onValueAnimUpdate() {
    if (mounted) setState(() {});
  }

  void _onValueAnimStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onCompleted?.call();
    }
  }

  double? get _currentProgress {
    if (_toValue == null) return null;
    if (_valueController == null || _valueController!.isCompleted) {
      return _toValue;
    }
    final t = widget.curve.transform(_valueController!.value);
    if (_fromValue == null) return _toValue;
    return lerpDouble(_fromValue, _toValue, t);
  }

  void _setupIndeterminateController() {
    _indeterminateController?.dispose();
    _indeterminateController = null;
    _indeterminateValue = 0.0;

    if (widget.value == null && widget.valueGradient != null) {
      _indeterminateController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          _indeterminateValue = _indeterminateController!.value;
          if (mounted) setState(() {});
        });
      if (_playing) {
        _indeterminateController!.repeat();
      }
    }
  }

  void _setupSpinController() {
    _spinController?.removeListener(_onSpinUpdate);
    _spinController?.dispose();
    _spinController = null;
    _spinRadians = 0.0;
    if (widget.spinning) {
      _spinController = AnimationController(
        vsync: this,
        duration: widget.spinDuration ?? const Duration(seconds: 2),
      )..addListener(_onSpinUpdate);
      if (_playing) {
        _spinController!.repeat();
      }
    }
    if (mounted) setState(() {});
  }

  void _onSpinUpdate() {
    if (_spinController == null) return;
    _spinRadians = _spinController!.value * 2 * pi;
    if (mounted) setState(() {});
  }

  void _resumeAnimations() {
    if (widget.spinning && _spinController != null) {
      _spinController!.repeat();
    }
    if (_indeterminateController != null) {
      _indeterminateController!.repeat();
    }
    if (_valueController != null && !_valueController!.isCompleted) {
      _valueController!.forward();
    }
  }

  void _pauseAnimations() {
    _spinController?.stop();
    _indeterminateController?.stop();
    _valueController?.stop();
  }

  bool get _useGradientProgress => widget.valueGradient != null;

  @override
  Widget build(BuildContext context) {
    final bgDecoration = BoxDecoration(
      shape: widget.backgroundShape,
      color: widget.backgroundGradient == null ? widget.backgroundColor : null,
      gradient: widget.backgroundGradient,
      border: widget.backgroundBorder,
      borderRadius: widget.backgroundBorderRadius,
    );

    return Container(
      margin: widget.margin,
      width: widget.size,
      height: widget.size,
      decoration: bgDecoration,
      padding: widget.padding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            strokeAlign: 0.0,
            strokeWidth: widget.trackWidth,
            value: widget.trackColor != null ? 1.0 : 0.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              widget.trackColor ?? Colors.transparent,
            ),
          ),
          Transform.rotate(
            angle: _spinRadians * (widget.reverseSpin ? -1 : 1),
            child: RotatedBox(
              quarterTurns: widget.quarterTurns,
              child: _useGradientProgress
                  ? _GradientProgress(
                      value: _currentProgress,
                      strokeWidth: widget.strokeWidth,
                      strokeCap: widget.strokeCap,
                      valueGradient: widget.valueGradient!,
                      valueColor: widget.valueColor,
                      indeterminateValue: _indeterminateValue,
                    )
                  : CircularProgressIndicator(
                      strokeAlign: 0.0,
                      strokeWidth: widget.strokeWidth,
                      strokeCap: widget.strokeCap,
                      value: _currentProgress,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.valueColor ?? Colors.purple,
                      ),
                    ),
            ),
          ),
          if (widget.child != null) widget.child!,
        ],
      ),
    );
  }
}

class _GradientProgress extends StatelessWidget {
  final double? value;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Gradient valueGradient;
  final Color? valueColor;
  final double indeterminateValue;

  const _GradientProgress({
    this.value,
    required this.strokeWidth,
    required this.strokeCap,
    required this.valueGradient,
    this.valueColor,
    required this.indeterminateValue,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ProgressArcPainter(
        progress: value,
        strokeWidth: strokeWidth,
        strokeCap: strokeCap,
        gradient: valueGradient,
        color: valueColor ?? Colors.purple,
        indeterminateValue: indeterminateValue,
      ),
      size: const Size.square(double.infinity),
    );
  }
}

class _ProgressArcPainter extends CustomPainter {
  final double? progress;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Gradient gradient;
  final Color color;
  final double indeterminateValue;

  _ProgressArcPainter({
    this.progress,
    required this.strokeWidth,
    required this.strokeCap,
    required this.gradient,
    required this.color,
    required this.indeterminateValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(
      center: center,
      radius: radius.clamp(0, double.infinity),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;

    if (progress != null) {
      final sweepAngle = 2 * pi * progress!;
      if (sweepAngle <= 0) return;
      paint.shader = gradient.createShader(rect);
      canvas.drawArc(rect, -pi / 2, sweepAngle, false, paint);
    } else {
      const arcLength = pi / 2;
      final startAngle = -pi / 2 + indeterminateValue * 2 * pi;
      paint.shader = gradient.createShader(rect);
      canvas.drawArc(rect, startAngle, arcLength, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.strokeCap != strokeCap ||
        oldDelegate.gradient != gradient ||
        oldDelegate.color != color ||
        oldDelegate.indeterminateValue != indeterminateValue;
  }
}
