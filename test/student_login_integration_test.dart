import 'package:enseignement_en_ligne/pages/login/login.dart' as student;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EPST bundles the school login logo and QR entry', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MaterialApp(home: student.Login(embedded: true)));
    await tester.pumpAndSettle();
    expect(find.text('Identifiant élève'), findsOneWidget);
    expect(find.text('Scanner mon QR-code'), findsOneWidget);
    expect(find.text('Créer un compte'), findsNothing);
    final logo = tester.widget<Image>(find.byType(Image).first).image as AssetImage;
    expect(logo.package, 'enseignement_en_ligne');
    expect(tester.takeException(), isNull);
  });
}
