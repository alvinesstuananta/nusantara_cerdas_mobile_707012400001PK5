import 'package:flutter_test/flutter_test.dart';
import 'package:nusantara_cerdas_mobile_707012400001/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NusantaraCerdasApp());
  });
}
