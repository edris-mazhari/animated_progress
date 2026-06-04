import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_progress/animated_progress.dart';

void main() {
  // ---- Circular Tests ----

  testWidgets('CircularProgress renders with determinate value',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: CircularProgress(value: 0.5, size: 100)),
    );
    expect(find.byType(CircularProgress), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('CircularProgress renders in indeterminate mode',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: CircularProgress(size: 100)),
    );
    expect(find.byType(CircularProgress), findsOneWidget);
  });

  testWidgets('CircularProgress renders child widget', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CircularProgress(
            value: 0.3, size: 100, child: Text('30%')),
      ),
    );
    expect(find.text('30%'), findsOneWidget);
  });

  testWidgets('CircularProgress renders with background', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CircularProgress(
          value: 0.5,
          size: 100,
          backgroundColor: Colors.amber,
          backgroundShape: BoxShape.circle,
          backgroundBorder: Border.all(color: Colors.deepPurple, width: 3),
        ),
      ),
    );
    expect(find.byType(CircularProgress), findsOneWidget);
  });

  testWidgets('CircularProgress controller pauses and resumes',
      (tester) async {
    final controller = ProgressController();
    await tester.pumpWidget(
      MaterialApp(
        home: CircularProgress(
          value: 0.5,
          size: 100,
          controller: controller,
        ),
      ),
    );
    expect(find.byType(CircularProgress), findsOneWidget);

    controller.pause();
    await tester.pump();
    controller.resume();
    await tester.pump();
    expect(find.byType(CircularProgress), findsOneWidget);
  });

  testWidgets('CircularProgress with spinning', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CircularProgress(value: 0.5, size: 100, spinning: true),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(CircularProgress), findsOneWidget);
  });

  testWidgets('CircularProgress with gradient', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CircularProgress(
          value: 0.6,
          size: 100,
          valueGradient: SweepGradient(colors: [Colors.red, Colors.yellow]),
        ),
      ),
    );
    expect(find.byType(CircularProgress), findsOneWidget);
  });

  testWidgets('CircularProgress asserts valid value', (tester) async {
    expect(() => CircularProgress(value: -0.1), throwsAssertionError);
    expect(() => CircularProgress(value: 1.5), throwsAssertionError);
  });

  // ---- Linear Tests ----

  testWidgets('LinearProgress renders with value', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LinearProgress(value: 0.5, width: 200, height: 12),
      ),
    );
    expect(find.byType(LinearProgress), findsOneWidget);
  });

  testWidgets('LinearProgress renders with secondary value', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LinearProgress(
          value: 0.5,
          secondaryValue: 0.75,
          width: 200,
          height: 12,
        ),
      ),
    );
    expect(find.byType(LinearProgress), findsOneWidget);
  });

  testWidgets('LinearProgress renders right to left', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LinearProgress(
          value: 0.5,
          width: 200,
          height: 12,
          direction: LinearDirection.rightToLeft,
        ),
      ),
    );
    expect(find.byType(LinearProgress), findsOneWidget);
  });

  testWidgets('LinearProgress with gradient', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LinearProgress(
          value: 0.7,
          width: 200,
          height: 12,
          valueGradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
        ),
      ),
    );
    expect(find.byType(LinearProgress), findsOneWidget);
  });

  testWidgets('LinearProgress controller pauses and resumes',
      (tester) async {
    final controller = ProgressController();
    await tester.pumpWidget(
      MaterialApp(
        home: LinearProgress(
          value: 0.5,
          width: 200,
          height: 12,
          controller: controller,
        ),
      ),
    );
    expect(find.byType(LinearProgress), findsOneWidget);

    controller.pause();
    await tester.pump();
    controller.resume();
    await tester.pump();
    expect(find.byType(LinearProgress), findsOneWidget);
  });

  testWidgets('LinearProgress asserts valid values', (tester) async {
    expect(
      () => LinearProgress(value: -0.1),
      throwsAssertionError,
    );
    expect(
      () => LinearProgress(value: 1.5),
      throwsAssertionError,
    );
    expect(
      () => LinearProgress(secondaryValue: -0.1),
      throwsAssertionError,
    );
    expect(
      () => LinearProgress(secondaryValue: 1.5),
      throwsAssertionError,
    );
  });
}
