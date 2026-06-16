import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:battery_notifier/main.dart';
import 'package:battery_notifier/models/settings.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = Settings(prefs);

    await tester.pumpWidget(BatteryNotifierApp(settings: settings));
    await tester.pumpAndSettle();

    expect(find.text('Battery Notifier'), findsOneWidget);
    expect(find.text('Activate Alarm'), findsOneWidget);
  });
}
