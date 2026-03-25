import 'package:flutter_test/flutter_test.dart';

import 'package:fitbook/main.dart';

void main() {
  testWidgets('App renders onboarding screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FitBookApp());
    await tester.pumpAndSettle();
    expect(find.text('FITBOOK'), findsOneWidget);
  });
}
