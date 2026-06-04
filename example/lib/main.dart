import 'package:flutter/material.dart';
import 'package:animated_progress/animated_progress.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedProgress Demo',
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  double _progress = 0.6;
  bool _spinning = false;
  double _strokeWidth = 8;
  final _controller = ProgressController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('animated_progress')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            // Circular
            CircularProgress(
              value: _progress,
              size: 140,
              strokeWidth: _strokeWidth,
              trackWidth: _strokeWidth + 4,
              trackColor: Colors.grey.shade200,
              valueColor: Colors.green,
              spinning: _spinning,
              controller: _controller,
              child: Text(
                '${(_progress * 100).round()}%',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
              ),
            ),
            const SizedBox(height: 32),

            // Linear
            LinearProgress(
              value: _progress,
              width: double.infinity,
              height: 12,
              valueColor: Colors.green,
              backgroundColor: Colors.green.shade100,
              borderRadius: 6,
            ),
            const SizedBox(height: 8),
            LinearProgress(
              value: _progress,
              secondaryValue: (_progress * 1.3).clamp(0, 1),
              width: double.infinity,
              height: 12,
              valueColor: Colors.green.shade800,
              secondaryValueColor: Colors.green.shade300,
              backgroundColor: Colors.green.shade50,
              borderRadius: 6,
            ),
            const SizedBox(height: 32),

            // Controls
            Text('Progress',
                style: Theme.of(context).textTheme.titleSmall),
            Slider(
              value: _progress,
              min: 0,
              max: 1,
              onChanged: (v) => setState(() => _progress = v),
            ),
            const SizedBox(height: 8),
            Text('Stroke Width',
                style: Theme.of(context).textTheme.titleSmall),
            Slider(
              value: _strokeWidth,
              min: 2,
              max: 20,
              onChanged: (v) => setState(() => _strokeWidth = v),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilterChip(
                  label: const Text('Spinning'),
                  selected: _spinning,
                  onSelected: (v) => setState(() => _spinning = v),
                ),
                FilterChip(
                  label: Text(
                    _controller.isPlaying ? 'Playing' : 'Paused',
                  ),
                  selected: _controller.isPlaying,
                  onSelected: (_) => _controller.togglePlay(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
