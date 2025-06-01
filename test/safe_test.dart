import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_overflow/smart_overflow.dart';
import 'package:smart_overflow/src/core/overflow_config.dart';
import 'package:smart_overflow/src/widgets/safe_text.dart';

void main() {
  group('SafeText Tests', () {
    testWidgets('should display text normally when no overflow',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              width: 200,
              child: SafeText('Short text'),
            ),
          ),
        ),
      );

      expect(find.text('Short text'), findsOneWidget);
    });

    testWidgets('should handle overflow with scale strategy', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              width: 50,
              child: SafeText(
                'Very long text that will definitely overflow',
                strategy: OverflowStrategy.scale,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FittedBox), findsOneWidget);
    });
  });
}
