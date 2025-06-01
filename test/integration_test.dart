import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_overflow/smart_overflow.dart';
import 'package:smart_overflow/src/core/overflow_config.dart';
import 'package:smart_overflow/src/widgets/safe_row.dart';
import 'package:smart_overflow/src/widgets/safe_text.dart';

void main() {
  group('Integration Tests', () {
    testWidgets('Complete overflow prevention workflow', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                SafeRow(
                  children: [
                    SafeText('Item 1'),
                    SafeText('Item 2'),
                    SafeText('Very long item that might overflow'),
                  ],
                  strategy: OverflowStrategy.flexible,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(SafeRow), findsOneWidget);
      expect(find.byType(SafeText), findsNWidgets(3));
    });
  });
}
